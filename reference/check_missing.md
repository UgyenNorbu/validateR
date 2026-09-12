# Check for missing values in a data frame

Computes the count and percentage of missing (`NA`) values for each
column in a data frame.

## Usage

``` r
check_missing(data)
```

## Arguments

- data:

  A data frame.

## Value

A data frame with one row per column of `data`, containing:

- column_name:

  Name of the column.

- n_missing:

  Number of missing values.

- pct_missing:

  Percentage of missing values, rounded to 2 decimals.

## Examples

``` r
df <- data.frame(x = c(1, NA, 3), y = c("a", "b", NA))
check_missing(df)
#>   column_name n_missing pct_missing
#> 1           x         1       33.33
#> 2           y         1       33.33
```
