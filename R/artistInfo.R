#' @name artistInfo
#' @author Bruna Wundervald, \email{brunadaviesw@ufpr.br}.
#' @export
#' @title Artist Information
#' @description Gives some information about a given artist/band.
#' @param name The name of the artist/band.
#' @return \code{artistInfo} returns a data.frame with the information.
#' @details The variables returned by the function are extracted with
#'     the Vagalume API.
#' @examples
#'
#' \dontrun{
#' artistInfo("the-beatles")
#' artistInfo("chico-buarque")
#' }
#'
artistInfo <- function(name) {

  req <-httr::GET(paste("https://www.vagalume.com.br/",name,"/index.js"))
  json <-httr::content(req)
  cont <- jsonlite::fromJSON(json)

  artist <- data.frame(id = cont$artist$id,
                       name = cont$artist$desc,
                       views = cont$artist$rank$views,
                       pos = cont$artist$rank$pos,
                       period = cont$artist$rank$period,
                       uniques = cont$artist$rank$uniques,
                       points = cont$artist$rank$points)
  return(artist)
}
