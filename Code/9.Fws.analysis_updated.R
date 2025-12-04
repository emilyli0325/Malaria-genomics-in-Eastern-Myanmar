## Updated version with explicit rounding rule:
## Round calls with ref <1 OR alt <1 OR f < 0.05 OR f > 0.95 to 0 or 1.

###############################################################################
## Helper: fractional genotype with depth & rounding filters (Python fgt_525)
###############################################################################

#' Compute fractional genotype with depth and rounding filters
#'
#' Rounds calls with:
#'   - ref < 1
#'   - alt < 1
#'   - f < 0.05
#'   - f > 0.95
#' to exactly 0 or 1.
#'
#' Depth < 5 is set to NA.
#'
#' @param x matrix: rows = samples, columns = alleles (ref, alt)
#' @return numeric vector of alt allele fractions
fracGT_525 <- function(x,
                       min_depth = 5L,
                       hom_read_thresh = 2L,
                       hom_freq_thresh = 0.05) {

    x <- x[, 1:2, drop = FALSE]

    depth <- rowSums(x)
    f <- x[, 2] / depth

    # Depth < 5 or depth == 0 → NA
    f[depth < min_depth | depth == 0] <- NA_real_

    #----- EXPLICIT rounding rule (Python consistent) -----
    homs <- (x[, 1] <= hom_read_thresh) |      # ref <= 1
            (x[, 2] <= hom_read_thresh) |      # alt <= 1
            (f < hom_freq_thresh)        |     # f < 0.05
            (f > 1 - hom_freq_thresh)          # f > 0.95
    #-------------------------------------------------------

    homs[is.na(f)] <- FALSE   # don't modify missing values

    f[homs] <- round(f[homs]) # round to 0 or 1

    f
}

###############################################################################
## Minor allele frequency
###############################################################################

getMAF <- function(gdsfile) {
    stopifnot(inherits(gdsfile, "SeqVarGDSClass"))
    vars <- SeqArray::seqSummary(gdsfile, check="none", verbose=FALSE)$format$ID

    if (!("AD" %in% vars))
        stop("annotation/format/AD required")

    maf_fun <- function(x) {
        f_alt <- fracGT_525(x)
        p_alt <- mean(f_alt, na.rm = TRUE)
        if (is.nan(p_alt)) return(NA_real_)
        min(p_alt, 1 - p_alt)
    }

    SeqArray::seqApply(
        gdsfile,
        "annotation/format/AD",
        maf_fun,
        margin="by.variant",
        as.is="double"
    )
}

###############################################################################
## Heterozygosity by sample
###############################################################################

getHeterozygosityBySample <- function(gdsfile) {
    stopifnot(inherits(gdsfile, "SeqVarGDSClass"))
    vars <- SeqArray::seqSummary(gdsfile, check="none", verbose=FALSE)$format$ID

    if (!("AD" %in% vars))
        stop("annotation/format/AD required")

    heterozygosity <- function(x) {
        f_alt <- fracGT_525(x)
        p_ref <- 1 - f_alt
        1 - (p_ref^2 + f_alt^2)   # 2pq
    }

    het_list <- SeqArray::seqApply(
        gdsfile,
        "annotation/format/AD",
        heterozygosity,
        margin="by.variant",
        as.is="list"
    )

    matrix(
        unlist(het_list),
        ncol=length(het_list),
        dimnames=list(
            sample  = SeqArray::seqGetData(gdsfile, "sample.id"),
            variant = SeqArray::seqGetData(gdsfile, "variant.id")
        )
    )
}

###############################################################################
## Population heterozygosity
###############################################################################

getHeterozygosity <- function(gdsfile) {
    maf <- getMAF(gdsfile)
    1 - (maf^2 + (1 - maf)^2)
}

###############################################################################
## Fws calculation
###############################################################################

getFws <- function(gdsfile) {

    sample.het <- getHeterozygosityBySample(gdsfile)
    population.het <- getHeterozygosity(gdsfile)
    maf <- getMAF(gdsfile)

    maf.bins <- findInterval(maf, seq(0, 0.5, length.out=11))

    mu.population.het <- tapply(population.het, maf.bins, mean, na.rm=TRUE)

    mu.sample.het <- apply(
        sample.het,
        1,
        function(x) tapply(x, maf.bins, mean, na.rm=TRUE)
    )

    if (is.vector(mu.sample.het))
        mu.sample.het <- matrix(mu.sample.het, ncol = 1)

    fws <- apply(
        mu.sample.het,
        2,
        function(x) {
            good <- !is.na(x) & !is.na(mu.population.het)
            if (sum(good) < 2) return(NA_real_)
            beta <- coef(lm(x[good] ~ mu.population.het[good] - 1))[[1]]
            1 - beta
        }
    )

    fws
}

