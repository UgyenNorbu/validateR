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
#' @return An object of class `validation_report`. See
#'   [new_validation_report()] for details on its structure. Printing the
#'   result shows a short summary; the full results for each check are
#'   available under `report$results$missing`, `report$results$outliers`,
#'   `report$results$duplicates`, and `report$results$types`.
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
#' @export
validate_df <- function(data) {
  if (!is.data.frame(data)) {
    stop("Error - the input data is not a data frame.")
  }

  df_name <- deparse(substitute(data))
  missing_result <- check_missing(data)
  outliers_result <- check_outliers(data)
  duplicates_result <- check_duplicates(data)
  types_result <- check_types(data)

  validation_report <- new_validation_report(
    data,
    df_name = df_name,
    missing_result = missing_result,
    outliers_result = outliers_result,
    duplicates_result = duplicates_result,
    types_result = types_result
  )

  return(validation_report)
}
