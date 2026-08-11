test_that("check_types flags a mostly-numeric character column with a straggler", {
  df <- data.frame(
    income = c("50000", "62000", "N/A", "48000", "71000"),
    stringsAsFactors = FALSE
  )
  result <- check_numeric_like(df)

  expect_equal(length(result), 1)
  expect_equal(result$income$expected_type, "numeric")
  expect_equal(result$income$proportion_convertible, 80)
  expect_equal(result$income$bad_rows, 3)
})

test_that("check_types does not flag a fully convertible character column", {
  df <- data.frame(
    income = c("50000", "62000", "48000", "71000"),
    stringsAsFactors = FALSE
  )
  result <- check_numeric_like(df)

  expect_equal(length(result), 0)
})

test_that("check_types does not flag a genuinely textual column", {
  df <- data.frame(
    city = c("Thimphu", "Paro", "Punakha", "Wangdue", "Trongsa"),
    stringsAsFactors = FALSE
  )
  result <- check_numeric_like(df)

  expect_equal(length(result), 0)
})

test_that("check_types skips numeric columns entirely", {
  df <- data.frame(age = c(25, 30, 45, 22, 31))
  result <- check_numeric_like(df)

  expect_equal(length(result), 0)
})

test_that("check_types rejects input that is not a data frame", {
  expect_error(check_numeric_like(c(1, 2, 3)))
})
