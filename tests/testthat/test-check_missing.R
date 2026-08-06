test_that("check_missing counts missing values correctly on a normal case", {
  df <- data.frame(
    x = c(1, NA, 3),
    y = c("a", "b", "c")
  )

  result <- check_missing(df)

  expect_equal(result$n_missing[1], 1)
  expect_equal(result$pct_missing[1], 33.33)
})

test_that("check_missing reports zero for a column with no missing values", {
  df <- data.frame(x = c(1, 2, 3))
  result <- check_missing(df)

  expect_equal(result$n_missing[1], 0)
  expect_equal(result$pct_missing[1], 0)
})

test_that("check_missing reports 100 percent for a fully missing column", {
  df <- data.frame(x = c(NA, NA, NA))
  result <- check_missing(df)

  expect_equal(result$n_missing[1], 3) # should be 3
  expect_equal(result$pct_missing[1], 100) # should be 100
})

test_that("check_missing errors when given a non-data-frame input", {
  expect_error(check_missing(c(1, 2, 3)))
})
