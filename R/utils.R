#' Pipe operator
#'
#' See \code{\link[magrittr]{\%>\%}} for more details.
#'
#' @name %>%
#' @rdname pipe
#' @keywords internal
#' @export
#' @importFrom magrittr %>%
#' @examples{
#'
#'   iris %>% as.matrix()
#'}
NULL

# Get rid of NOTES
globalVariables(c(".", "name", "id", "text"))