# Check for duplicate rows in a data frame

Identifies exact duplicate rows across all columns of a data frame.

## Usage

``` r
check_duplicates(data)
```

## Arguments

- data:

  A data frame

## Value

A list where each element is an integer vector giving the row indices of
a group of duplicate rows. Returns an empty list if no duplicates are
found.

## Examples

``` r
df <- data.frame(
  x = c(1, 2, 1, 4, 5, 4, 4),
  y = c("a", "b", "a", "d", "e", "d", "d")
)

check_duplicates(df)
#> [[1]]
#> [1] 1 3
#> 
#> [[2]]
#> [1] 4 6 7
#> 
```
