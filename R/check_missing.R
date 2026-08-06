#' Check for missing values in a data frame
#'
#' Computes the count and percentage of missing (`NA`) values for each
#' column in a data frame.
#'
#' @param data A data frame.
#'
#' @return A data frame with one row per column of `data`, containing:
#' \describe{
#'   \item{column_name}{Name of the column.}
#'   \item{n_missing}{Number of missing values.}
#'   \item{pct_missing}{Percentage of missing values, rounded to 2 decimals.}
#' }
#'
#' @examples
#' df <- data.frame(x = c(1, NA, 3), y = c("a", "b", NA))
#' check_missing(df)
#'
#' @export
check_missing <- function(data) {
  if (!is.data.frame(data)) stop("`data` must be a data frame.", call. = FALSE)
  n_missing <- vapply(data, \(x) sum(is.na(x)), FUN.VALUE = integer(1))
  pct_missing <- round(n_missing / nrow(data) * 100, 2)

  data.frame(
    column_name = names(data),
    n_missing = n_missing,
    pct_missing = pct_missing,
    row.names = NULL
  )
}
