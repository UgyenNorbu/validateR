#' @noRd
check_column_type <- function(chr_vec) {
  na_index <- is.na(chr_vec)
  non_missing_count <- sum(!na_index)
  convert_to_num <- suppressWarnings(as.numeric(chr_vec))
  convertible_check <- !is.na(convert_to_num)
  convertible_count <- sum(convertible_check)
  propotion <- round(convertible_count / non_missing_count * 100, 2)

  if (propotion >= 80 & propotion < 100) {
    non_convertible_index <- which(is.na(convert_to_num) & !na_index)
    return_val <- list(
      expected_type = "numeric",
      proportion_convertible = propotion,
      bad_rows = non_convertible_index
    )
  } else {
    return_val <- NULL
  }

  return(return_val)
}

#' Check for type inconsistencies in character columns
#'
#' Examines each character column of a data frame and tests whether its
#' non-missing values can be converted to numeric. If at least 80% (but
#' less than 100%) of non-missing values are numeric-looking, the column
#' is flagged as likely intended to be numeric, and the row positions of
#' the non-convertible ("straggler") values are reported for inspection.
#' Columns that are already numeric, or that fall below the 80% threshold,
#' are not flagged.
#'
#' @param data A data frame.
#'
#' @return A named list, one element per flagged column (named by column
#' name). Each element is itself a list containing:
#' \describe{
#'   \item{expected_type}{The type the column is likely meant to be
#'   (currently always `"numeric"`).}
#'   \item{proportion_convertible}{Percentage of non-missing values that
#'   can be converted to numeric, rounded to 2 decimals.}
#'   \item{bad_rows}{Integer vector of row indices whose values could not
#'   be converted to numeric.}
#' }
#' Returns an empty list if no columns are flagged.
#'
#' @examples
#' df <- data.frame(
#'   income = c("50000", "62000", "N/A", "48000", "71000"),
#'   city = c("Thimphu", "Paro", "Punakha", "Wangdue", "Trongsa"),
#'   stringsAsFactors = FALSE
#' )
#' check_types(df)
#'
#' @export
check_types <- function(data) {
  if (!is.data.frame(data)) {
    stop("`data` must be a data frame.", call. = FALSE)
  }
  chr_col_index <- vapply(data, is.character, FUN.VALUE = logical(1))
  chr_cols_only <- data[, chr_col_index, drop = FALSE]

  checked_cols <- lapply(chr_cols_only, check_column_type)

  checked_cols_no_null <- Filter(Negate(is.null), checked_cols)

  return(checked_cols_no_null)
}
