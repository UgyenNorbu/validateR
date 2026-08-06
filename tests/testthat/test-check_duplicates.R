test_that("check_duplicates finds duplicate row groups correctly", {
  df <- data.frame(
    x = c(1, 2, 1, 4, 5, 4, 4),
    y = c("a", "b", "a", "d", "e", "d", "d")
  )
  result <- check_duplicates(df)

  expect_equal(length(result), 2)

  expect_equal(result[[1]], c(1, 3))
  expect_equal(result[[2]], c(4, 6, 7))
})

test_that("check_duplicates returns an empty list when there are no duplicates", {
  df <- data.frame(x = 1:3, y = c("a", "b", "c"))
  result <- check_duplicates(df)

  expect_equal(length(result), 0)
})

test_that("check_duplicates excludes groups of size one", {
  df <- data.frame(
    x = c(1, 1, 2, 3),
    y = c("a", "a", "b", "c")
  )
  result <- check_duplicates(df)

  expect_equal(length(result), 1)
  expect_equal(result[[1]], c(1, 2))
})

test_that("check_duplicates rejects input that is not a data frame", {
  expect_error(check_duplicates(c(1, 2, 3)))
})
