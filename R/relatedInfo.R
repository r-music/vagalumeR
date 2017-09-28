#' @name relatedInfo
#' @author Bruna Wundervald, \email{brunadaviesw@ufpr.br}.
#' @export
#' @title Artist's Related
#' @description Gives information about what artists/bands are
#'     related to a specific artist/band.
#' @param name The name of the artist/band.
#' @return \code{relatedInfo} returns a data.frame with information
#'     about the related artists.
#' @details The variables returned by the function are extracted with
#'     the Vagalume API.
#' @examples
#'
#' relatedInfo("the-beatles")
#' relatedInfo("chico-buarque")
#'
library(jsonlite)
library(curl)
library(httr)

relatedInfo <- function(name){
  req <-httr::GET(paste("https://www.vagalume.com.br/",name,"/index.js"))
  json <-httr::content(req)
  cont <- fromJSON(json)

  rel <- data.frame(id = cont$artist$id,
                    name = cont$artist$desc,
                    rel.id = cont$artist$related$id,
                    related = cont$artist$related$name)
  return(rel)
}

