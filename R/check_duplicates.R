#' Check for duplicate rows in a data frame
#'
#' Identifies exact duplicate rows across all columns of a data frame.
#'
#' @param data A data frame
#'
#' @return A list where each element is an integer vector giving the row indices
#' of a group of duplicate rows. Returns an empty list if no duplicates are
#' found.
#'
#' @examples
#' df <- data.frame(
#'   x = c(1, 2, 1, 4, 5, 4, 4),
#'   y = c("a", "b", "a", "d", "e", "d", "d")
#' )
#'
#' check_duplicates(df)
#'
#' @export
check_duplicates <- function(data) {
  if (!is.data.frame(data)) {
    stop("`data` must be a data frame.", call. = FALSE)
  }

  row_signatures <- apply(data, MARGIN = 1, FUN = paste0, collapse = "_")
  row_split <- unname(split(seq_len(nrow(data)), row_signatures))
  Filter(\(x) length(x) > 1, row_split)
}
