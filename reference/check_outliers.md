# Check for outlier values in a data frame

Calculates the count and percentage of outlier values using IQR method
(values beyond Q1 - 1.5*IQR or Q3 + 1.5*IQR).

## Usage

``` r
check_outliers(data)
```

## Arguments

- data:

  A data frame

## Value

A data frame with one row per column of `data`, containing:

- column_name:

  Name of the column.

- n_outliers:

  Number of outlier values.

- pct_outliers:

  Percentage of outlier values, rounded to 2 decimals.

## Examples

``` r
df <- data.frame(
  x = c(1, 2, 3, 4, 100),
  y = c(10, 12, 11, 13, 12)
)
check_outliers(df)
#>   column_name n_outliers pct_outliers
#> 1           x          1           20
#> 2           y          0            0
```
