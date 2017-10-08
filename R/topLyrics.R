#' @name topLyrics
#' @author Bruna Wundervald, \email{brunadaviesw@ufpr.br}.
#' @export
#' @title Top lyrics of an artist/band
#' @description Gives information about the top lyrics (most viewed)
#'     about an specific artist/band.
#' @param name The name of the artist/band.
#' @return \code{topLyrics} returns a data.frame with information
#'     about the top lyrics.
#' @details The variables returned by the function are extracted with
#'     the Vagalume API.
#' @examples
#'
#' \dontrun{
#' topLyrics("the-beatles")
#' topLyrics("chico-buarque")
#' }
#'
topLyrics <- function(name){
  req <- httr::GET(paste("https://www.vagalume.com.br/",name,"/index.js"))
  json <- httr::content(req)
  cont <- jsonlite::fromJSON(json)

  top <- data.frame(id = cont$artist$id,
                    name = cont$artist$desc,
                    id.top = cont$artist$toplyrics$item$id,
                    song = cont$artist$toplyrics$item$desc)
  return(top)
}
