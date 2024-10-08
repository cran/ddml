% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ols.R
\name{ols}
\alias{ols}
\title{Ordinary least squares.}
\usage{
ols(y, X, const = TRUE, w = NULL)
}
\arguments{
\item{y}{The outcome variable.}

\item{X}{The feature matrix.}

\item{const}{Boolean equal to \code{TRUE} if a constant should be included.}

\item{w}{A vector of weights for weighted least squares.}
}
\value{
\code{ols} returns an object of S3 class
\code{ols}. An object of class \code{ols} is a list containing
the following components:
\describe{
\item{\code{coef}}{A vector with the regression coefficents.}
\item{\code{y}, \code{X}, \code{const}, \code{w}}{Pass-through of the
user-provided arguments. See above.}
}
}
\description{
Simple implementation of ordinary least squares that computes
with sparse feature matrices.
}
\examples{
ols_fit <- ols(rnorm(100), cbind(rnorm(100), rnorm(100)), const = TRUE)
ols_fit$coef
}
\seealso{
Other ml_wrapper: 
\code{\link{mdl_glmnet}()},
\code{\link{mdl_glm}()},
\code{\link{mdl_ranger}()},
\code{\link{mdl_xgboost}()}
}
\concept{ml_wrapper}
