#' @importFrom stats quantile
#' @noRd
count_outliers_iqr <- function(vec) {
  Q3 <- quantile(vec, 0.75, na.rm = TRUE)
  Q1 <- quantile(vec, 0.25, na.rm = TRUE)
  iqr_val <- Q3 - Q1
  lower_bound <- Q1 - 1.5 * iqr_val
  upper_bound <- Q3 + 1.5 * iqr_val

  is_outlier <- vec < lower_bound | vec > upper_bound
  n_outliers <- sum(is_outlier, na.rm = TRUE)

  return(n_outliers)
}

#' Check for outlier values in a data frame
#'
#' Calculates the count and percentage of outlier values using IQR method
#' (values beyond Q1 - 1.5*IQR or Q3 + 1.5*IQR).
#'
#' @param data A data frame
#'
#' @return A data frame with one row per column of `data`, containing:
#' \describe{
#'    \item{column_name}{Name of the column.}
#'    \item{n_outliers}{Number of outlier values.}
#'    \item{pct_outliers}{Percentage of outlier values, rounded to 2 decimals.}
#' }
#'
#' @examples
#' df <- data.frame(
#'   x = c(1, 2, 3, 4, 100),
#'   y = c(10, 12, 11, 13, 12)
#' )
#' check_outliers(df)
#'
#' @export
check_outliers <- function(data) {
  if (!is.data.frame(data)) {
    stop("`data` must be a data frame.", call. = FALSE)
  }

  is_numeric_col <- vapply(data, \(x) is.numeric(x), FUN.VALUE = logical(1))
  numeric_data <- data[, is_numeric_col, drop = FALSE]

  n_outliers <- vapply(numeric_data, FUN = count_outliers_iqr, FUN.VALUE = integer(1))
  pct_outliers <- round(100 * n_outliers / nrow(numeric_data), 2)

  data.frame(
    column_name = names(numeric_data),
    n_outliers = n_outliers,
    pct_outliers = pct_outliers,
    row.names = NULL
  )
}
