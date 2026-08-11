#' Validate a data frame for common data quality issues
#'
#' Runs a full suite of data quality checks on a data frame — missing
#' values, outliers, duplicate rows, and type inconsistencies — and
#' returns a single, structured report summarizing the results. This is
#' the main entry point for the package; most users should start here
#' rather than calling the individual `check_*()` functions directly.
#'
#' @param data A data frame to validate.
#'
#' @param date_columns Optional. A named character vector mapping column
#'   names in `data` to their expected date format (using the format
#'   codes accepted by [base::as.Date()]). If supplied, `check_date_like()`
#'   is run on those columns as a fifth check. If `NULL` (the default),
#'   date checking is skipped entirely, and the report notes it was not
#'   checked.
#'
#' @return An object of class `validation_report`. See
#'   [new_validation_report()] for details on its structure. Printing the
#'   result shows a short summary; the full results for each check are
#'   available under `report$results$missing`, `report$results$outliers`,
#'   `report$results$duplicates`, `report$results$numeric_like` and
#'   `report$results$date_like`.
#'
#' @examples
#' df <- data.frame(
#'   age = c(25, 30, NA, 45, 200),
#'   income = c("50000", "62000", "N/A", "48000", "71000"),
#'   stringsAsFactors = FALSE
#' )
#' report <- validate_df(df)
#' report
#'
#' # With an optional date check
#' df2 <- data.frame(
#'   signup_date = c(
#'     "2023-01-15", "2023-02-20", "not a date",
#'     "2023-03-10", "2023-04-01"
#'   ),
#'   stringsAsFactors = FALSE
#' )
#' report2 <- validate_df(df2, date_columns = c(signup_date = "%Y-%m-%d"))
#' report2
#'
#' @export
validate_df <- function(data, date_columns = NULL) {
  if (!is.data.frame(data)) {
    stop("Error - the input data is not a data frame.", call. = FALSE)
  }


  df_name <- deparse(substitute(data))
  missing_result <- check_missing(data)
  outliers_result <- check_outliers(data)
  duplicates_result <- check_duplicates(data)
  numeric_like_result <- check_numeric_like(data)

  if (is.null(date_columns)) {
    date_like_result <- NULL
  } else {
    date_like_result <- check_date_like(data, date_columns = date_columns)
  }

  validation_report <- new_validation_report(
    data,
    df_name = df_name,
    missing_result = missing_result,
    outliers_result = outliers_result,
    duplicates_result = duplicates_result,
    numeric_like_result = numeric_like_result,
    date_like_result = date_like_result
  )

  return(validation_report)
}
