#' @name lyrics
#' @author Bruna Wundervald, \email{brunadaviesw@gmail.com}.
#' @export
#' @title Lyrics of a song.
#' @description Gives the lyrics text of a song and the translation text,
#'    when the language of the song its not Portuguese.
#' @param identifier The identifier of the song.
#' @param type The type of identifier os the song ("name" or "id").
#' @param artist The name of the artist/band.
#' @param key The apikey.
#' @param message Should the function print something if the
#' required data is not found?
#' @return \code{lyrics} returns a data.frame with information
#'     about the artist, the song and the texts.
#' @details The variables returned by the function are extracted with
#'     the Vagalume API.
#' @examples
#'
#' \dontrun{
#' identifier <- "A-Day-In-The-Life"
#' key <- "your token"
#' artist <- "the-beatles"
#' type <- "name"
#' lyrics(identifier, type, artist, key)
#'
#' key <- "your token"
#' identifier <- "3ade68b4gdc96eda3"
#' type <- "id"
#' lyrics(identifier = identifier, type = type, key = key)
#' }
lyrics <- function(identifier, type, artist, key, message = TRUE){
  artist <- stringr::str_to_lower(artist)
  
  if(type == "id"){
    req <-httr::GET(paste0("https://api.vagalume.com.br/search.php?apikey=",
                           key, "&musid=", identifier))
  }
  if(type == "name"){
    req <- httr::GET(paste0("https://api.vagalume.com.br/search.php?art=",
                            artist,"&mus=",identifier,"&extra=relmus&apikey=", key))
  }
  
  cont <- httr::content(req, encoding = "UTF-8")
  
  if(!is.null(cont$mus)){
    
  mus <- cont$mus[[1]][c(1, 2, 4, 5)]  %>%
    purrr::transpose() %>%
    purrr::map_df(data.frame) %>% 
    dplyr::mutate(id = identifier,
                  name = artist,
                  song.id = id, 
                  song = name, 
                  text = stringr::str_replace_all(
                    as.character(text), "[\n]" , " ")) %>% 
    `if`(!is.null(cont$mus[[1]]$translate[[1]]$lang), 
         dplyr::mutate(., 
                       language = cont$mus[[1]]$translate[[1]]$lang), .)  
  
  cont$mus[[1]]$translate
  if(!is.null(cont$mus[[1]]$lang) && cont$mus[[1]]$lang > 1){
    if(!is.null(cont$mus[[1]]$translate)){
      
      mus <- mus %>% 
        dplyr::mutate(
          translation = 
            stringr::str_replace_all(
              cont$mus[[1]]$translate[[1]]$text,
              "[\n]" , " "))
    }
  }
  } 
  else{ mus <- NULL
    if(message) print("Lyrics not found") }
  Sys.sleep(2)
  return(mus)
}

