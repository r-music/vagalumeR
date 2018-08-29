#' @name songNames
#' @author Bruna Wundervald, \email{brunadaviesw@gmail.com}.
#' @export
#' @title Song names of an artist/band.
#' @description Gives information about the song names of an specific
#'     artist/band.
#' @param name The name of the artist/band.
#' @param message Should the function print something if the
#' required data is not found?
#' @return \code{relatedInfo} returns a data.frame with information
#'     about song names.
#' @details The variables returned by the function are extracted with
#'     the Vagalume API.
#' @examples
#'
#' \dontrun{
#' songNames("the-beatles")
#' songNames("chico-buarque")
#' }
#'
songNames <- function(name, message = TRUE){
  name <- stringr::str_to_lower(name)
  cont <- paste0("https://www.vagalume.com.br/",name,"/index.js") %>% 
    jsonlite::fromJSON()

  if(!is.null(cont)){
    mus <- data.frame(id = cont$artist$id,
                      name = cont$artist$desc,
                      song.id = cont$artist$lyrics$item$id,
                      song = cont$artist$lyrics$item$desc)
  } else{
    mus <- NULL
    if(message) print("No song names found.")
  }
  return(mus)
}
