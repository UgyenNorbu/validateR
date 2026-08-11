
<!-- README.md is generated from README.Rmd. Please edit that file -->

# validateR

<!-- badges: start -->

<!-- badges: end -->

`validateR` is a lightweight toolkit for checking data frames for common
data quality issues: missing values, outliers, duplicate rows,
numeric-like inconsistencies, and (optionally) date-like
inconsistencies. Results are returned as a structured report object with
`print` and `plot` methods, so you can quickly see what’s wrong with
your data before you start analyzing it.

## Installation

You can install the development version of validateR from
[GitHub](https://github.com/UgyenNorbu/validateR) with:

``` r
pak::pak("UgyenNorbu/validateR")
```

## Example

The main entry point is `validate_df()`, which runs several checks at
once and returns a single report:

``` r
library(validateR)

messy_df <- data.frame(
  age = c(25, 30, NA, 45, 22, 31, 29, 200),
  income = c("50000", "62000", "N/A", "48000",
             "71000", "55000", "60000", "48000"),
  city = c("Thimphu", "Paro", "Thimphu", "Paro",
           "Thimphu", "Paro", "Punakha", "Paro"),
  stringsAsFactors = FALSE
)
messy_df <- rbind(messy_df, messy_df[1, ], messy_df[4, ])

report <- validate_df(messy_df)
report
#> < validation_report for 'messy_df' >
#> 10 rows, 3 columns
#> Checked: 2026-08-11 14:36:44 
#> 
#> Missing values:          1  column(s) affected
#> Outliers:                1  column(s) affected
#> Duplicates:              2  group(s) affected
#> Numeric-like issues:     1  column(s) affected
#> Date-like issues:        NOT checked 
#> 
#> For details, inspect report$results$missing, $outliers, $duplicates, $numeric_like, $date_like
```

You can drill into the full detail behind any of the checks:

``` r
report$results$missing
#>   column_name n_missing pct_missing
#> 1         age         1          10
#> 2      income         0           0
#> 3        city         0           0
report$results$numeric_like
#> $income
#> $income$expected_type
#> [1] "numeric"
#> 
#> $income$proportion_convertible
#> [1] 90
#> 
#> $income$bad_rows
#> [1] 3
```

And visualize missing values and outliers per column:

<img src="man/figures/README-plot-example-1.png" alt="" width="100%" />

## Checking date-like columns

`validate_df()` can also check whether character columns contain values
that look like dates in a format you specify. This check is optional,
since date formats are ambiguous (for example, `"03/04/2023"` could mean
March 4th or April 3rd, depending on convention) — so rather than
guessing, you tell it what format to expect for each column you want
checked.

``` r
dated_df <- data.frame(
  signup_date = c("2023-01-15", "2023-02-20", "not a date",
                  "2023-03-10", "2023-04-01"),
  stringsAsFactors = FALSE
)

report_with_dates <- validate_df(
  dated_df,
  date_columns = c(signup_date = "%Y-%m-%d")
)
report_with_dates
#> < validation_report for 'dated_df' >
#> 5 rows, 1 columns
#> Checked: 2026-08-11 14:36:44 
#> 
#> Missing values:          0  column(s) affected
#> Outliers:                0  column(s) affected
#> Duplicates:              0  group(s) affected
#> Numeric-like issues:     0  column(s) affected
#> Date-like issues:        1  column(s) affected 
#> 
#> For details, inspect report$results$missing, $outliers, $duplicates, $numeric_like, $date_like
```

If `date_columns` isn’t supplied, `validate_df()` skips date checking
entirely, and the report notes that it wasn’t checked rather than
implying the column was fine:

``` r
report_without_dates <- validate_df(dated_df)
report_without_dates
#> < validation_report for 'dated_df' >
#> 5 rows, 1 columns
#> Checked: 2026-08-11 14:36:44 
#> 
#> Missing values:          0  column(s) affected
#> Outliers:                0  column(s) affected
#> Duplicates:              0  group(s) affected
#> Numeric-like issues:     0  column(s) affected
#> Date-like issues:        NOT checked 
#> 
#> For details, inspect report$results$missing, $outliers, $duplicates, $numeric_like, $date_like
```

## Individual checks

Each check is also available on its own, if you only need one:

``` r
check_duplicates(messy_df)
#> [[1]]
#> [1] 1 9
#> 
#> [[2]]
#> [1]  4 10
```
