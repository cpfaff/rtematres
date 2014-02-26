#' Deprecated functions in package rtematres
#'
#' These following functions are renamed or removed. Please use new functions instead.
#'
#' \tabular{ll}{
#'  \strong{Deprecated functions} \tab \strong{Replacement} \cr
#'  \code{rtematres.api.do} \tab \code{\link{rtematres}} \cr
#' }
#'
#' @name rtematres-deprecated
#' @aliases rtematres.api.do
#' @export rtematres.api.do
#' @keywords internal

#' @rdname rtematres-deprecated
rtematres.api.do <- function(...) {
  .Deprecated("rtematres")
  rtematres(...)
}
