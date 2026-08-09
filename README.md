
<!-- README.md is generated from README.Rmd. Please edit that file -->

# validateR

<!-- badges: start -->

<!-- badges: end -->

`validateR` is a lightweight toolkit for checking data frames for common
data quality issues: missing values, outliers, duplicate rows, and type
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

The main entry point is `validate_df()`, which runs all four checks at
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
#> Checked: 2026-08-08 10:51:56 
#> 
#> Missing values:  1  column(s) affected
#> Outliers:        1  column(s) affected
#> Duplicates:      2  group(s) affected
#> Type issues:     1  column(s) affected
#> 
#> For details, inspect report$results$missing, $outliers, $duplicates, $types
```

You can drill into the full detail behind any of the four checks:

``` r
report$results$missing
#>   column_name n_missing pct_missing
#> 1         age         1          10
#> 2      income         0           0
#> 3        city         0           0
report$results$types
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

<img src="man/figures/README-report-1.png" alt="" width="100%" />

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
