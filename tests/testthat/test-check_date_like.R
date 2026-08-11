test_that("check_date_like flags a mostly-parseable date column with a straggler", {
  df <- data.frame(
    signup_date = c(
      "2023-01-15", "2023-02-20", "not a date",
      "2023-03-10", "2023-04-01"
    ),
    stringsAsFactors = FALSE
  )
  result <- check_date_like(df, date_columns = c(signup_date = "%Y-%m-%d"))

  expect_equal(length(result), 1)
  expect_equal(result$signup_date$expected_type, "date")
  expect_equal(result$signup_date$proportion_parsable_to_date, 80)
  expect_equal(result$signup_date$bad_rows, 3)
})

test_that("check_date_like does not flag a fully parseable date column", {
  df <- data.frame(
    signup_date = c("2023-01-15", "2023-02-20", "2023-03-10"),
    stringsAsFactors = FALSE
  )
  result <- check_date_like(df, date_columns = c(signup_date = "%Y-%m-%d"))

  expect_equal(length(result), 0)
})

test_that("check_date_like does not flag a column that isn't date-like at all", {
  df <- data.frame(
    notes = c("apple", "banana", "cherry", "date", "elderberry"),
    stringsAsFactors = FALSE
  )
  result <- check_date_like(df, date_columns = c(notes = "%Y-%m-%d"))

  expect_equal(length(result), 0)
})

test_that("check_date_like handles multiple columns with different formats", {
  df <- data.frame(
    signup_date = c(
      "2023-01-15", "2023-02-20", "not a date",
      "2023-03-10", "2023-04-01"
    ),
    dob = c("01/15/1990", "02/20/1985", "03/10/1992", "bad", "04/01/1988"),
    stringsAsFactors = FALSE
  )
  result <- check_date_like(
    df,
    date_columns = c(signup_date = "%Y-%m-%d", dob = "%m/%d/%Y")
  )

  expect_equal(length(result), 2)
  expect_true("signup_date" %in% names(result))
  expect_true("dob" %in% names(result))
})

test_that("check_date_like errors when a requested column doesn't exist in data", {
  df <- data.frame(signup_date = c("2023-01-15", "2023-02-20"))

  expect_error(
    check_date_like(df, date_columns = c(s_up_date = "%Y-%m-%d"))
  )
})

test_that("check_date_like rejects input that is not a data frame", {
  expect_error(check_date_like(list(x = c(1:5)), date_columns = c(x = "%Y-%m-%d")))
})
