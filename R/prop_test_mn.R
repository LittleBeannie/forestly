#' Test of Equal Proportion Using Miettinen and Nurminen Method
#'
#'   1. Assign numbers and define parameters
#'   2. Perform algebra for calculating maximum likelihood estimates of proportion on treatment and control groups.
#'   3. Calculate sample variance based on step 2 and constract test-statistics
#'   4. For non-inferiority or one-sided equivalence hypothesis, the p-value is computed based on the test-statistic (Zdiff) using the standard normal distribution.
#'   5. For superiority or two-sided test, the p-value is computed based on the test statistic (Zdiff^2) using the Chi-square distribuiton with df = 1.
#'
#' @param x0 number of successes for the first group.
#' @param n0 number of trials for the first group.
#' @param x1 number of successes for the second group.
#' @param n1 number of trials for the second group.
#' @param delta  assumed proportion difference
#' @param sides  specify the hypothesis directions: two.sided, righ(less than), left(greater than)
#' @param alpha  pre-difined significant level
#'
#' @examples
#'
#' x0 <- c(1,2); n0 <- c(100, 100);
#' x1 <- c(4,5); n1 <- c(100, 100);
#' prop_test_mn(x0, n0, x1, n1)
#'
#' @export
prop_test_mn <- function(x0, n0, x1, n1,
                         delta = 0,
                         sides = 'two.sided',
                         alpha = 0.05){

  # Test with p-values
  p0 <- x0/n0
  p1 <- x1/n1

  N  <- n0 + n1
  X  <- x0 +x1

  L3 <- N
  L2 <- (n1+2*n0) * delta - N - X
  L1 <- (n0*delta  - N - 2*n0) * delta + X
  L0 <- x0*delta*(1-delta)

  q <- L2^3/((3*L3)^3) - L1*L2/(6*(L3^2)) + L0/(2*L3)
  p_temp <- sqrt( L2^2/((3*L3)^2) - L1/(3*L3) )
  p <- (q>0)*p_temp - (q<0)*p_temp
  a <- (1/3)*(pi + acos(pmin(pmax(q/(p^3), -1.0), 1.0)))
  
  p0_ml <- 2*p*cos(a) - L2/(3*L3)
  p1_ml <- p0_ml + delta

  V <- (p0_ml*(1-p0_ml)/n0 + p1_ml*(1-p1_ml)/n1) * (N/(N-1))
  z_stats <- (p1 - p0 - delta) / sqrt(V)

  if (sides == 'right' | sides == 'left'){
    pvalue <- ifelse(delta <= 0, 1- stats::pnorm(z_stats), stats::pnorm(z_stats))
  } else if (sides == 'two.sided') {
    pvalue <- 1- stats::pchisq((z_stats^2), 1)
  }

  # Confidence Interval
  ci <- DescTools::BinomDiffCI(x1, n1, x0, n0,
                               method= "mn", sides = sides, conf.level = 1- alpha)*100
  ci <- data.frame(ci)
  names(ci) <- c("est", "lower", "upper")
  rownames(ci) <- NULL
  ci$p <- pvalue

  ci

}
