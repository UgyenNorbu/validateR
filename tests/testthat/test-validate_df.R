test_that("validate_df returns an object of class validation_report", {
  df <- data.frame(x = c(1, 2, 3), y = c("a", "b", "c"))
  report <- validate_df(df)

  expect_s3_class(report, "validation_report")
})

test_that("validate_df captures the data frame name correctly", {
  my_data <- data.frame(x = c(1, 2, 3))
  report <- validate_df(my_data)

  expect_equal(report$meta$df_name, "my_data")
})

test_that("validate_df captures the correct dimensions", {
  df <- data.frame(x = c(1, 2, 3), y = c("a", "b", "c"))
  report <- validate_df(df)

  expect_equal(report$meta$dim, c(3, 2))
})

test_that("validate_df assembles results from all four checks", {
  df <- data.frame(
    age = c(25, 30, NA, 45, 200),
    income = c("50000", "62000", "N/A", "48000", "71000"),
    stringsAsFactors = FALSE
  )
  report <- validate_df(df)

  expect_true(is.data.frame(report$results$missing))
  expect_true(is.data.frame(report$results$outliers))
  expect_true(is.list(report$results$duplicates))
  expect_true(is.list(report$results$types))
})

test_that("validate_df rejects input that is not a data frame", {
  expect_error(validate_df(c(1, 2, 3)))
})
