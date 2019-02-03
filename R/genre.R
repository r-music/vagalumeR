#' @name genre
#' @author Bruna Wundervald, \email{brunadaviesw@gmail.com}.
#' @export
#' @title An artist's musical genre(s)
#' @description Gives information about the genre (ou multiple genres)
#' of an artist/band. 
#' @param name The name of the artist/band.
#' @param message Should the function print something if the
#' required data is not found?
#' @return \code{genre} returns a data.frame with information
#'     about the genre(s).
#' @details The variables returned by the function are extracted with
#'     the Vagalume API.
#' @examples
#'
#' \dontrun{
#' genre("the-beatles")
#' genre("chico-buarque")
#' }


genre <- function (name, message = TRUE) {
  name <- stringr::str_to_lower(name)
  cont <- paste0("https://www.vagalume.com.br/", name, "/index.js") %>% 
    jsonlite::fromJSON()
  if (!is.null(cont)) {
    genre <- data.frame(genre = cont$artist$genre$name)
  }
  else {
    genre <- NULL
    if (message) 
      print("Artist not found.")
  }
  return(genre)
}