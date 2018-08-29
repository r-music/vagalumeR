#' @name topLyrics
#' @author Bruna Wundervald, \email{brunadaviesw@gmail.com}.
#' @export
#' @title Top lyrics of an artist/band
#' @description Gives information about the top lyrics (most viewed)
#'     about an specific artist/band.
#' @param name The name of the artist/band.
#' @param message Should the function print something if the
#' required data is not found?
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
topLyrics <- function(name, message = TRUE){
  name <- stringr::str_to_lower(name)
  
  cont <- paste0("https://www.vagalume.com.br/",name,"/index.js") %>% 
    jsonlite::fromJSON()
  
  if(!is.null(cont)){
    top <- data.frame(id = cont$artist$id,
                      name = cont$artist$desc,
                      id.top = cont$artist$toplyrics$item$id,
                      song = cont$artist$toplyrics$item$desc)
  } else{
    top <- NULL
    if(message) print("No top lyrics found.")
  }
  return(top)
}
