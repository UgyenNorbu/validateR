# Validate a data frame for common data quality issues

Runs a full suite of data quality checks on a data frame — missing
values, outliers, duplicate rows, and type inconsistencies — and returns
a single, structured report summarizing the results. This is the main
entry point for the package; most users should start here rather than
calling the individual `check_*()` functions directly.

## Usage

``` r
validate_df(data, date_columns = NULL)
```

## Arguments

- data:

  A data frame to validate.

- date_columns:

  Optional. A named character vector mapping column names in `data` to
  their expected date format (using the format codes accepted by
  [`base::as.Date()`](https://rdrr.io/r/base/as.Date.html)). If
  supplied,
  [`check_date_like()`](https://ugyennorbu.github.io/validateR/reference/check_date_like.md)
  is run on those columns as a fifth check. If `NULL` (the default),
  date checking is skipped entirely, and the report notes it was not
  checked.

## Value

An object of class `validation_report`. See
[`new_validation_report()`](https://ugyennorbu.github.io/validateR/reference/new_validation_report.md)
for details on its structure. Printing the result shows a short summary;
the full results for each check are available under
`report$results$missing`, `report$results$outliers`,
`report$results$duplicates`, `report$results$numeric_like` and
`report$results$date_like`.

## Examples

``` r
df <- data.frame(
  age = c(25, 30, NA, 45, 200),
  income = c("50000", "62000", "N/A", "48000", "71000"),
  stringsAsFactors = FALSE
)
report <- validate_df(df)
report
#> < validation_report for 'df' >
#> 5 rows, 2 columns
#> Checked: 2026-09-12 04:07:46 
#> 
#> Missing values:          1  column(s) affected
#> Outliers:                1  column(s) affected
#> Duplicates:              0  group(s) affected
#> Numeric-like issues:     1  column(s) affected
#> Date-like issues:        NOT checked 
#> 
#> For details, inspect report$results$missing, $outliers, $duplicates, $numeric_like, $date_like 

# With an optional date check
df2 <- data.frame(
  signup_date = c(
    "2023-01-15", "2023-02-20", "not a date",
    "2023-03-10", "2023-04-01"
  ),
  stringsAsFactors = FALSE
)
report2 <- validate_df(df2, date_columns = c(signup_date = "%Y-%m-%d"))
report2
#> < validation_report for 'df2' >
#> 5 rows, 1 columns
#> Checked: 2026-09-12 04:07:46 
#> 
#> Missing values:          0  column(s) affected
#> Outliers:                0  column(s) affected
#> Duplicates:              0  group(s) affected
#> Numeric-like issues:     0  column(s) affected
#> Date-like issues:        1  column(s) affected 
#> 
#> For details, inspect report$results$missing, $outliers, $duplicates, $numeric_like, $date_like 
```
