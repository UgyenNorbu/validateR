#' Construct a validation_report object
#'
#' Low-level constructor that assembles already-computed check results
#' into a single `validation_report` object. This function does not run
#' any checks itself — it simply packages results produced elsewhere
#' (typically by [check_missing()], [check_outliers()],
#' [check_duplicates()], and [check_types()]) into a structured, classed
#' object. In most cases, users should call [validate_df()] instead, which
#' runs all four checks and calls this constructor automatically.
#'
#' @param df The data frame that was checked. Used only to derive
#'   dimensions; not stored directly in the report.
#' @param df_name A character string giving the name to display for the
#'   data frame in printed output.
#' @param missing_result Output of [check_missing()].
#' @param outliers_result Output of [check_outliers()].
#' @param duplicates_result Output of [check_duplicates()].
#' @param types_result Output of [check_types()].
#'
#' @return An object of class `validation_report`, a list containing:
#' \describe{
#'   \item{meta}{A list with `df_name` (character), `dim` (integer vector
#'   of rows and columns), and `timestamp` (the time the report was
#'   created).}
#'   \item{results}{A list with four elements, `missing`, `outliers`,
#'   `duplicates`, and `types`, containing the corresponding check
#'   results.}
#' }
#'
#' @examples
#' df <- data.frame(x = c(1, NA, 3), y = c("a", "b", "c"))
#' report <- new_validation_report(
#'   df = df,
#'   df_name = "df",
#'   missing_result = check_missing(df),
#'   outliers_result = check_outliers(df),
#'   duplicates_result = check_duplicates(df),
#'   types_result = check_types(df)
#' )
#' class(report)
#'
#' @export
new_validation_report <- function(df,
                                  df_name,
                                  missing_result,
                                  outliers_result,
                                  duplicates_result,
                                  types_result) {
  validation_report_list <- list(
    meta = list(
      df_name = df_name,
      dim = dim(df),
      timestamp = Sys.time()
    ),
    results = list(
      missing = missing_result,
      outliers = outliers_result,
      duplicates = duplicates_result,
      types = types_result
    )
  )
  class(validation_report_list) <- "validation_report"

  return(validation_report_list)
}

#' Print a validation_report object
#'
#' Displays a concise summary of a `validation_report`, showing the data
#' frame's dimensions, when it was checked, and how many columns (or
#' groups, for duplicates) were flagged by each check.
#'
#' @param x A `validation_report` object.
#' @param ... Further arguments passed to or from other methods (currently
#'   unused).
#'
#' @return The input `x`, returned invisibly.
#'
#' @export
print.validation_report <- function(x, ...) {
  cat("< validation_report for '", x$meta$df_name, "' >\n", sep = "")
  cat(x$meta$dim[1], "rows,", x$meta$dim[2], "columns\n")
  cat("Checked:", format(x$meta$timestamp), "\n\n")

  cat("Missing values: ", sum(x$results$missing$n_missing > 0), " column(s) affected\n")
  cat("Outliers:       ", sum(x$results$outliers$n_outliers > 0), " column(s) affected\n")
  cat("Duplicates:     ", length(x$results$duplicates), " group(s) affected\n")
  cat("Type issues:    ", length(x$results$types), " column(s) affected\n")
  cat("\nFor details, inspect report$results$missing, $outliers, $duplicates, $types\n")

  invisible(x)
}
