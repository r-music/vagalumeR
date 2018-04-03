#' @name relatedInfo
#' @author Bruna Wundervald, \email{brunadaviesw@gmail.com}.
#' @export
#' @title Artist's Related
#' @description Gives information about what artists/bands are
#'     related to a specific artist/band.
#' @param name The name of the artist/band.
#' @param message Should the function print something if the
#' required data is not found?
#' @return \code{relatedInfo} returns a data.frame with information
#'     about the related artists.
#' @details The variables returned by the function are extracted with
#'     the Vagalume API.
#' @examples
#'
#' \dontrun{
#' relatedInfo("the-beatles")
#' relatedInfo("chico-buarque")
#' }
relatedInfo <- function(name, message = TRUE){
  name <- stringr::str_to_lower(name)

  req <- httr::GET(paste("https://www.vagalume.com.br/",name,"/index.js"))
  json <- httr::content(req, encoding = "UTF-8")
  cont <- jsonlite::fromJSON(json)
  
  if(!is.null(cont$artist$related)){
    rel <- data.frame(id = cont$artist$id,
                      name = cont$artist$desc,
                      rel.id = cont$artist$related$id,
                      related = cont$artist$related$name)
  } else { 
    rel <- NULL
    if(message) print("No related artists available.")
  }
  return(rel) 
}

