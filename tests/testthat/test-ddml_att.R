test_that("ddml_att computes with a single model", {
  # Simulate small dataset
  nobs <- 200
  X <- cbind(1, matrix(rnorm(nobs*39), nobs, 39))
  D_tld <-  X %*% runif(40) + rnorm(nobs)
  D <- 1 * (D_tld > mean(D_tld))
  y <- D + X %*% runif(40) + rnorm(nobs)
  # Define arguments
  learners <- list(what = ols)
  learners_DX <- list(what = mdl_glm)
  ddml_att_fit <- ddml_att(y, D, X,
                           learners = learners,
                           learners_DX = learners_DX,
                           cv_folds = 3,
                           sample_folds = 3,
                           silent = T)
  # Check output with expectations
  expect_equal(length(ddml_att_fit$att), 1)
})#TEST_THAT

test_that("ddml_att computes with an ensemble procedure", {
  # Simulate small dataset
  nobs <- 200
  X <- cbind(1, matrix(rnorm(nobs*39), nobs, 39))
  D_tld <-  X %*% runif(40) + rnorm(nobs)
  D <- 1 * (D_tld > mean(D_tld))
  y <- D + X %*% runif(40) + rnorm(nobs)
  # Define arguments
  learners <- list(list(fun = ols),
                   list(fun = ols))
  # Compute DDML PLM estimator
  ddml_att_fit <- ddml_att(y, D, X,
                           learners = learners,
                           ensemble_type = "ols",
                           cv_folds = 3,
                           sample_folds = 3,
                           silent = T)
  # Check output with expectations
  expect_equal(length(ddml_att_fit$att), 1)
})#TEST_THAT

test_that("ddml_att computes w/ multiple ensembles + custom weights", {
  # Simulate small dataset
  nobs <- 200
  X <- cbind(1, matrix(rnorm(nobs*39), nobs, 39))
  D_tld <-  X %*% runif(40) + rnorm(nobs)
  D <- 1 * (D_tld > mean(D_tld))
  y <- D + X %*% runif(40) + rnorm(nobs)
  # Define arguments
  learners <- list(list(fun = ols),
                   list(fun = ols))
  # Compute DDML PLM estimator
  ddml_att_fit <- ddml_att(y, D, X,
                           learners,
                           ensemble_type = c("ols", "nnls",
                                             "singlebest", "average"),
                           cv_folds = 3,
                           custom_ensemble_weights = diag(1, 2),
                           sample_folds = 3,
                           silent = T)
  # Check output with expectations
  expect_equal(length(ddml_att_fit$att), 6)
})#TEST_THAT

test_that("ddml_att computes w/ multp ensembles, custom weights + shortstack", {
  # Simulate small dataset
  nobs <- 200
  X <- cbind(1, matrix(rnorm(nobs*39), nobs, 39))
  D_tld <-  X %*% runif(40) + rnorm(nobs)
  D <- 1 * (D_tld > mean(D_tld))
  y <- D + X %*% runif(40) + rnorm(nobs)
  # Define arguments
  learners <- list(list(fun = ols),
                   list(fun = ols))
  # Compute DDML PLM estimator
  ddml_att_fit <- ddml_att(y, D, X,
                           learners,
                           ensemble_type = c("ols", "average"),
                           shortstack = TRUE,
                           cv_folds = 3,
                           custom_ensemble_weights = diag(1, 2),
                           sample_folds = 3,
                           silent = T)
  # Check output with expectations
  expect_equal(length(ddml_att_fit$att), 4)
})#TEST_THAT

test_that("summary.ddml_att computes with a single model", {
  # Simulate small dataset
  nobs <- 200
  X <- cbind(1, matrix(rnorm(nobs*39), nobs, 39))
  D_tld <-  X %*% runif(40) + rnorm(nobs)
  D <- 1 * (D_tld > mean(D_tld))
  y <- D + X %*% runif(40) + rnorm(nobs)
  # Define arguments
  learners <- list(what = ols)
  ddml_att_fit <- ddml_att(y, D, X,
                           learners = learners,
                           cv_folds = 3,
                           sample_folds = 3,
                           silent = T)
  capture_output({inf_res <- summary(ddml_att_fit)})
  # Check output with expectations
  expect_equal(length(inf_res), 4)
})#TEST_THAT

test_that("summary.ddml_att computes with multiple ensemble procedures", {
  # Simulate small dataset
  nobs <- 200
  X <- cbind(1, matrix(rnorm(nobs*39), nobs, 39))
  D_tld <-  X %*% runif(40) + rnorm(nobs)
  D <- 1 * (D_tld > mean(D_tld))
  y <- D + X %*% runif(40) + rnorm(nobs)
  # Define arguments
  learners <- list(list(fun = ols))
  # Compute DDML PLM estimator
  ddml_att_fit <- ddml_att(y, D, X,
                           learners,
                           ensemble_type = c("ols", "nnls",
                                             "singlebest", "average"),
                           cv_folds = 3,
                           sample_folds = 3,
                           silent = T)
  capture_output({inf_res <- summary(ddml_att_fit)}, print = FALSE)
  # Check output with expectations
  expect_equal(length(inf_res), 16)
})#TEST_THAT
