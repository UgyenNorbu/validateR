# Plot a validation_report object

Displays two side-by-side bar charts summarizing a `validation_report`:
the count of missing values per column, and the count of outliers per
numeric column.

## Usage

``` r
# S3 method for class 'validation_report'
plot(x, ...)
```

## Arguments

- x:

  A `validation_report` object.

- ...:

  Further arguments passed to or from other methods (currently unused).

## Value

The input `x`, returned invisibly. Called for its side effect of
producing a plot.
