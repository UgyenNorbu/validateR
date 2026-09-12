# Package index

## Main entry point

Run all checks at once and get a structured report.

- [`validate_df()`](https://ugyennorbu.github.io/validateR/reference/validate_df.md)
  : Validate a data frame for common data quality issues

## Individual checks

Run a single check on its own.

- [`check_missing()`](https://ugyennorbu.github.io/validateR/reference/check_missing.md)
  : Check for missing values in a data frame
- [`check_outliers()`](https://ugyennorbu.github.io/validateR/reference/check_outliers.md)
  : Check for outlier values in a data frame
- [`check_duplicates()`](https://ugyennorbu.github.io/validateR/reference/check_duplicates.md)
  : Check for duplicate rows in a data frame
- [`check_numeric_like()`](https://ugyennorbu.github.io/validateR/reference/check_numeric_like.md)
  : Check for type inconsistencies in character columns
- [`check_date_like()`](https://ugyennorbu.github.io/validateR/reference/check_date_like.md)
  : Check for date-like inconsistencies in character columns

## The validation_report object

Constructor and display methods for the report object.

- [`new_validation_report()`](https://ugyennorbu.github.io/validateR/reference/new_validation_report.md)
  : Construct a validation_report object
- [`print(`*`<validation_report>`*`)`](https://ugyennorbu.github.io/validateR/reference/print.validation_report.md)
  : Print a validation_report object
- [`plot(`*`<validation_report>`*`)`](https://ugyennorbu.github.io/validateR/reference/plot.validation_report.md)
  : Plot a validation_report object
