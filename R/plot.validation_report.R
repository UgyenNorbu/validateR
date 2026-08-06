#' @importFrom graphics par barplot
#' Plot a validation_report object
#'
#' Displays two side-by-side bar charts summarizing a `validation_report`:
#' the count of missing values per column, and the count of outliers per
#' numeric column.
#'
#' @param x A `validation_report` object.
#' @param ... Further arguments passed to or from other methods (currently
#'   unused).
#'
#' @return The input `x`, returned invisibly. Called for its side effect
#'   of producing a plot.
#'
#' @export
plot.validation_report <- function(x, ...) {
  old_par <- par(mfrow = c(2, 1), mar = c(4, 4, 2, 1))
  on.exit(par(old_par))

  barplot(
    height = x$results$missing$n_missing,
    names.arg = x$results$missing$column_name,
    main = "Missing Values by Column",
    xlab = "Column",
    ylab = "Count of Missing Values"
  )

  barplot(
    height = x$results$outliers$n_outliers,
    names.arg = x$results$outliers$column_name,
    main = "Outliers by Column",
    xlab = "Column",
    ylab = "Count of Outliers"
  )

  invisible(x)
}
