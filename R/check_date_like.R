#' @noRd
check_column_date <- function(chr_vec, format_str) {
  na_index <- is.na(chr_vec)
  non_missing_count <- sum(!na_index)
  parsed_to_date <- as.Date(chr_vec, format = format_str)

  parsed_proportion <- round(sum(!is.na(parsed_to_date)) / non_missing_count * 100, 2)

  if (parsed_proportion >= 80 & parsed_proportion < 100) {
    non_parsable_index <- which(!na_index & is.na(parsed_to_date))
    return_val <- list(
      expected_type = "date",
      proportion_parsable_to_date = parsed_proportion,
      bad_rows = non_parsable_index
    )
  } else {
    return_val <- NULL
  }

  return(return_val)
}

#' Check for date-like inconsistencies in character columns
#'
#' Examines specified character columns of a data frame and tests
#' whether their non-missing values can be parsed as dates under a
#' given format. If at least 80% (but less than 100%) of a column's
#' non-missing values parse successfully, the column is flagged, and
#' the row positions of the non-parsable ("straggler") values are
#' reported for inspection. Unlike [check_numeric_like()], this check does not
#' attempt to guess a date format automatically - the caller must supply
#' the expected format for each column to be checked, since date formats
#' are ambiguous (for example, `"03/04/2023"` could mean March 4th or
#' April 3rd depending on convention) and guessing incorrectly could
#' silently produce misleading results.
#'
#' @param data A data frame.
#' @param date_columns A named character vector, where each name is a
#'   column in `data` to check, and each value is the expected date
#'   format for that column, using the format codes accepted by
#'   [base::as.Date()] (for example, `"%Y-%m-%d"` or `"%m/%d/%Y"`). An
#'   error is raised if any name in `date_columns` does not match a
#'   column in `data`.
#'
#' @return A named list, one element per flagged column (named by column
#' name). Each element is itself a list containing:
#' \describe{
#'   \item{expected_type}{Always `"date"`.}
#'   \item{proportion_parsable_to_date}{Percentage of non-missing values
#'   that were successfully parsed under the given format, rounded to 2
#'   decimals.}
#'   \item{bad_rows}{Integer vector of row indices whose values could
#'   not be parsed under the given format.}
#' }
#' Returns an empty list if no columns are flagged.
#'
#' @examples
#' df <- data.frame(
#'   signup_date = c(
#'     "2023-01-15", "2023-02-20", "not a date",
#'     "2023-03-10", "2023-04-01"
#'   ),
#'   notes = c("a", "b", "c", "d", "e")
#' )
#' check_date_like(df, date_columns = c(signup_date = "%Y-%m-%d"))
#'
#' @export
check_date_like <- function(data, date_columns) {
  if (!is.data.frame(data)) {
    stop("`data` must be a data frame.", call. = FALSE)
  }

  column_exists <- names(date_columns) %in% names(data)
  missing_columns <- names(date_columns)[!column_exists]

  if (length(missing_columns) > 0) {
    stop(
      "The following column(s) in `date_columns` were not found in `data`: \n",
      paste(missing_columns, collapse = ", "),
      call. = FALSE
    )
  }

  results <- list()

  for (col_name in names(date_columns)) {
    # Pull the actual column values out of `data`, using col_name
    col_values <- data[[col_name]]

    # Pull the format that corresponds to THIS column, out of date_columns
    col_format <- date_columns[[col_name]]

    # Run the per-column helper function
    col_result <- check_column_date(col_values, col_format)

    # Only keep it if it was actually flagged (i.e., not NULL)
    if (!is.null(col_result)) {
      results[[col_name]] <- col_result
    }
  }

  return(results)
}
