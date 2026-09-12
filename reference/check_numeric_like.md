# Check for type inconsistencies in character columns

Examines each character column of a data frame and tests whether its
non-missing values can be converted to numeric. If at least 80% (but
less than 100%) of non-missing values are numeric-looking, the column is
flagged as likely intended to be numeric, and the row positions of the
non-convertible ("straggler") values are reported for inspection.
Columns that are already numeric, or that fall below the 80% threshold,
are not flagged.

## Usage

``` r
check_numeric_like(data)
```

## Arguments

- data:

  A data frame.

## Value

A named list, one element per flagged column (named by column name).
Each element is itself a list containing:

- expected_type:

  The type the column is likely meant to be (currently always
  `"numeric"`).

- proportion_convertible:

  Percentage of non-missing values that can be converted to numeric,
  rounded to 2 decimals.

- bad_rows:

  Integer vector of row indices whose values could not be converted to
  numeric.

Returns an empty list if no columns are flagged.

## Examples

``` r
df <- data.frame(
  income = c("50000", "62000", "N/A", "48000", "71000"),
  city = c("Thimphu", "Paro", "Punakha", "Wangdue", "Trongsa"),
  stringsAsFactors = FALSE
)
check_numeric_like(df)
#> $income
#> $income$expected_type
#> [1] "numeric"
#> 
#> $income$proportion_convertible
#> [1] 80
#> 
#> $income$bad_rows
#> [1] 3
#> 
#> 
```
