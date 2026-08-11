# validateR 0.2.0

* Added `check_date_like()` for detecting date-format inconsistencies
  in character columns, with an explicit, required `format` per column
  (no automatic format guessing).
* `validate_df()` gained an optional `date_columns` argument to run
  date checking as part of the full report.
* Renamed `check_types()` to `check_numeric_like()`, and its `$types`
  result field to `$numeric_like`, for clarity now that there are two
  type-inconsistency checks.

# validateR 0.1.0

* Initial CRAN submission.
