# Check for date-like inconsistencies in character columns

Examines specified character columns of a data frame and tests whether
their non-missing values can be parsed as dates under a given format. If
at least 80% (but less than 100%) of a column's non-missing values parse
successfully, the column is flagged, and the row positions of the
non-parsable ("straggler") values are reported for inspection. Unlike
[`check_numeric_like()`](https://ugyennorbu.github.io/validateR/reference/check_numeric_like.md),
this check does not attempt to guess a date format automatically - the
caller must supply the expected format for each column to be checked,
since date formats are ambiguous (for example, `"03/04/2023"` could mean
March 4th or April 3rd depending on convention) and guessing incorrectly
could silently produce misleading results.

## Usage

``` r
check_date_like(data, date_columns)
```

## Arguments

- data:

  A data frame.

- date_columns:

  A named character vector, where each name is a column in `data` to
  check, and each value is the expected date format for that column,
  using the format codes accepted by
  [`base::as.Date()`](https://rdrr.io/r/base/as.Date.html) (for example,
  `"%Y-%m-%d"` or `"%m/%d/%Y"`). An error is raised if any name in
  `date_columns` does not match a column in `data`.

## Value

A named list, one element per flagged column (named by column name).
Each element is itself a list containing:

- expected_type:

  Always `"date"`.

- proportion_parsable_to_date:

  Percentage of non-missing values that were successfully parsed under
  the given format, rounded to 2 decimals.

- bad_rows:

  Integer vector of row indices whose values could not be parsed under
  the given format.

Returns an empty list if no columns are flagged.

## Examples

``` r
df <- data.frame(
  signup_date = c(
    "2023-01-15", "2023-02-20", "not a date",
    "2023-03-10", "2023-04-01"
  ),
  notes = c("a", "b", "c", "d", "e")
)
check_date_like(df, date_columns = c(signup_date = "%Y-%m-%d"))
#> $signup_date
#> $signup_date$expected_type
#> [1] "date"
#> 
#> $signup_date$proportion_parsable_to_date
#> [1] 80
#> 
#> $signup_date$bad_rows
#> [1] 3
#> 
#> 
```
