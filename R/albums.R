#' @name albums
#' @author Bruna Wundervald, \email{brunadaviesw@gmail.com}.
#' @export
#' @title An artist's music albums. 
#' @description Gives information about the albums  of an artist/band. 
#' @param name The name of the artist/band.
#' @param message Should the function print something if the
#' required data is not found?
#' @return \code{gente} returns a data.frame with information
#'     about the albums, as the id, name and year of release.
#' @details The variables returned by the function are extracted with
#'     the Vagalume API.
#' @examples
#'
#' \dontrun{
#' albums("the-beatles")
#' albums("chico-buarque")
#' }


albums <- function (name, message = TRUE) {
  name <- stringr::str_to_lower(name)
  cont <- paste0("https://www.vagalume.com.br/", name, "/index.js") %>% 
    jsonlite::fromJSON()
  if (!is.null(cont)) {
    albums <- data.frame(cont$artist$album$item)[,-3] 
    names(albums)[2] <- "title"
  }
  else {
    albums <- NULL
    if (message) 
      print("Artist not found.")
  }
  return(albums)
}