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
    req <-httr::GET(paste("https://api.vagalume.com.br/search.php?musid=",
                          identifier,"&apikey=", key))
  }
  if(type == "name"){
    req <- httr::GET(paste("https://api.vagalume.com.br/search.php?art=",
                           artist,"&mus=",identifier,"&extra=relmus&apikey=", key))
  }

  cont <- httr::content(req, encoding = "UTF-8")
  if(!is.null(cont)){

  l <- lapply(cont$mus, "[", c("id", "name", "lang", "text"))
  l <- plyr::ldply(l, data.frame)

  mus <- data.frame(id = cont$art$id,
                    name = cont$art$name,
                    song.id = l$id,
                    song = l$name,
                    language = l$lang,
                    text = l$text)
  mus$text <- as.character(mus$text)
  mus$text <- stringr::str_replace_all(mus$text, "[\n]" , " ")

  if(!is.null(cont$mus[[1]]$lang) && cont$mus[[1]]$lang > 1){
    if(!is.null(cont$mus[[1]]$translate)){
      tr <- lapply(cont$mus[[1]]$translate, "[", c("text"))
      tr <- plyr::ldply(tr, data.frame)
      mus <- data.frame(mus, tr$text)
      mus$tr.text <- as.character(mus$tr.text)
      mus$tr.text <- stringr::str_replace_all(mus$tr.text, "[\n]" , " ")
    }
  }

  } else{ 
    mus <- NULL
    if(message) print("Lyrics not found") }
  return(mus)
}

