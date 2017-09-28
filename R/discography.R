#' @name discography
#' @author Bruna Wundervald, \email{brunadaviesw@ufpr.br}.
#' @export
#' @title Discography of an artist/band.
#' @description Gives the list of albums of an specific artist/band.
#' @param name The name of the artist/band.
#' @return \code{discography} returns a data.frame with information
#'     about the artist and the discography.
#' @details The variables returned by the function are extracted with
#'     the Vagalume API.
#' @examples
#'
#' discography("the-beatles")
#'

library(jsonlite)
library(curl)
library(httr)

discography <- function(name){
  req <-httr::GET(paste("https://www.vagalume.com.br/",name,"/discografia/index.js"))
  json <-httr::content(req)

  cont <- fromJSON(json)

  disc <- data.frame(album.id = cont$discography$item$id,
                     album.name = cont$discography$item$desc,
                     label = cont$discography$item$label,
                     date = cont$discography$item$published)

  disc$id <-  cont$discography$artist$id
  disc$name <-  cont$discography$artist$desc

  return(disc)
}
