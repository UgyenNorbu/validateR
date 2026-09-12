# Construct a validation_report object

Low-level constructor that assembles already-computed check results into
a single `validation_report` object. This function does not run any
checks itself — it simply packages results produced elsewhere (typically
by
[`check_missing()`](https://ugyennorbu.github.io/validateR/reference/check_missing.md),
[`check_outliers()`](https://ugyennorbu.github.io/validateR/reference/check_outliers.md),
[`check_duplicates()`](https://ugyennorbu.github.io/validateR/reference/check_duplicates.md),
[`check_numeric_like()`](https://ugyennorbu.github.io/validateR/reference/check_numeric_like.md),
and
[`check_date_like()`](https://ugyennorbu.github.io/validateR/reference/check_date_like.md))
into a structured, classed object. In most cases, users should call
[`validate_df()`](https://ugyennorbu.github.io/validateR/reference/validate_df.md)
instead, which runs all five checks and calls this constructor
automatically.

## Usage

``` r
new_validation_report(
  df,
  df_name,
  missing_result,
  outliers_result,
  duplicates_result,
  numeric_like_result,
  date_like_result
)
```

## Arguments

- df:

  The data frame that was checked. Used only to derive dimensions; not
  stored directly in the report.

- df_name:

  A character string giving the name to display for the data frame in
  printed output.

- missing_result:

  Output of
  [`check_missing()`](https://ugyennorbu.github.io/validateR/reference/check_missing.md).

- outliers_result:

  Output of
  [`check_outliers()`](https://ugyennorbu.github.io/validateR/reference/check_outliers.md).

- duplicates_result:

  Output of
  [`check_duplicates()`](https://ugyennorbu.github.io/validateR/reference/check_duplicates.md).

- numeric_like_result:

  Output of
  [`check_numeric_like()`](https://ugyennorbu.github.io/validateR/reference/check_numeric_like.md).

- date_like_result:

  Output of
  [`check_date_like()`](https://ugyennorbu.github.io/validateR/reference/check_date_like.md)

## Value

An object of class `validation_report`, a list containing:

- meta:

  A list with `df_name` (character), `dim` (integer vector of rows and
  columns), and `timestamp` (the time the report was created).

- results:

  A list with four elements, `missing`, `outliers`, `duplicates`,
  `numeric_like` and `date_like`, containing the corresponding check
  results.

## Examples

``` r
df <- data.frame(x = c(1, NA, 3), y = c("a", "b", "c"))
report <- new_validation_report(
  df = df,
  df_name = "df",
  missing_result = check_missing(df),
  outliers_result = check_outliers(df),
  duplicates_result = check_duplicates(df),
  numeric_like_result = check_numeric_like(df),
  date_like_result = check_date_like(df, date_columns = c(y = "%Y-%m-%d"))
)
class(report)
#> [1] "validation_report"
```
