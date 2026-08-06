test_that("check_outliers detects outlier values correctly on a normal case", {
  df <- data.frame(x = c(1, 2, 3, 4, 100))
  result <- check_outliers(df)
  expect_equal(result$n_outliers[1], 1)
})

test_that("check_outliers finds no outliers in a vector without outliers", {
  df <- data.frame(y = 1:5)
  result <- check_outliers(df)
  expect_equal(result$n_outliers[1], 0)
})

test_that("check_outliers works correctly on a data frame with only one numeric column", {
  df <- data.frame(
    y = 1:5,
    z = letters[1:5]
  )
  result <- check_outliers(df)
  expect_equal(result$n_outliers[1], 0)
})

test_that("check_outliers returns an empty data frame when there are no numeric columns", {
  df <- data.frame(
    a = letters[1:3],
    b = LETTERS[5:7]
  )
  result <- check_outliers(df)
  expect_equal(nrow(result), 0)
})

test_that("check_outliers correctly excludes NA when detecting outliers", {
  df <- data.frame(x = c(1, 2, 3, 4, 100, NA))
  result <- check_outliers(df)
  expect_equal(result$n_outliers[1], 1)
})

test_that("check_outliers rejects input that is not a data frame", {
  expect_error(check_outliers(c(1, 2, 3)))
})
