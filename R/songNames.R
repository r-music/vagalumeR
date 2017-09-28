#' @name songNames
#' @author Bruna Wundervald, \email{brunadaviesw@ufpr.br}.
#' @export
#' @title Song names of an artist/band.
#' @description Gives information about the song names of an specific
#'     artist/band.
#' @param name The name of the artist/band.
#' @return \code{relatedInfo} returns a data.frame with information
#'     about song names.
#' @details The variables returned by the function are extracted with
#'     the Vagalume API.
#' @examples
#'
#' songNames("the-beatles")
#' songNames("chico-buarque")
#'

library(jsonlite)
library(curl)
library(httr)

songNames <- function(name){
  req <-httr::GET(paste("https://www.vagalume.com.br/",name,"/index.js"))
  json <-httr::content(req)
  cont <- fromJSON(json)

  mus <- data.frame(id = cont$artist$id,
                    name = cont$artist$desc,
                    song.id = cont$artist$lyrics$item$id,
                    song = cont$artist$lyrics$item$desc)
  return(mus)
}
