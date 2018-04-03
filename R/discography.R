#' @name discography
#' @author Bruna Wundervald, \email{brunadaviesw@gmail.com}.
#' @export
#' @title Discography of an artist/band.
#' @description Gives the list of albums of an specific artist/band.
#' @param name The name of the artist/band.
#' @param message Should the function print something if the
#' required data is not found?
#' @return \code{discography} returns a data.frame with information
#'     about the artist and the discography.
#' @details The variables returned by the function are extracted with
#'     the Vagalume API.
#' @examples
#'
#' \dontrun{
#' discography("the-beatles")
#' }
discography <- function(name, message = TRUE){
  name <- stringr::str_to_lower(name)
  
  req <-httr::GET(paste("https://www.vagalume.com.br/",name,"/discografia/index.js"))
  json <-httr::content(req)

  cont <- jsonlite::fromJSON(json)
  if(!is.null(cont)){
    disc <- data.frame(album.id = cont$discography$item$id,
                       album.name = cont$discography$item$desc,
                       label = cont$discography$item$label,
                       date = cont$discography$item$published)
    
    disc$id <-  cont$discography$artist$id
    disc$name <-  cont$discography$artist$desc
    

  } else{ 
    disc <- NULL
    if(message) print("Discography not found")
  }
  return(disc)
}
