#' @name artistInfo
#' @author Bruna Wundervald, \email{brunadaviesw@gmail.com}.
#' @export
#' @title Artist Information
#' @description Gives some information about a given artist/band.
#' @param name The name of the artist/band.
#' @param message Should the function print something if the
#' required data is not found?
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
artistInfo <- function(name, message = TRUE) {
  name <- stringr::str_to_lower(name)
  
  req <-httr::GET(paste("https://www.vagalume.com.br/",name,"/index.js"))
  json <-httr::content(req, encoding = "UTF-8")
  cont <- jsonlite::fromJSON(json)

  if(!is.null(cont)){
  artist <- data.frame(id = cont$artist$id,
                       name = cont$artist$desc,
                       views = cont$artist$rank$views,
                       pos = cont$artist$rank$pos,
                       period = cont$artist$rank$period,
                       uniques = cont$artist$rank$uniques,
                       points = cont$artist$rank$points)
  } else{ 
    artist <- NULL
    if(message) 
      print("Artist not found.")}
  return(artist)
}
