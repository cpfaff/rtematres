#' This contains functions for user interaction with the api

#' More smart functions that wrap functionality of multiple
#' API tasks.
#'
#'
#' A tematres base api based function to retrieve definitions
#'
#' It retrieves the definition of a term given the case it has been described in the
#' vocuabulary on the temates server.
#'
#' @param term It takes a term that you are searching the definition for
#'
#' @return Either a string or id
#' @export rtematres.api.define

rtematres.api.define <- function(term) {
  id = rtematres.api.conversion.term_id(term)
  term_notes = rtematres.api(task = "fetchNotes", argument = id)
  term_notes$description = html.escape(term_notes$description)
  return(term_notes)
}

#' A tematres base api based function to search the server
#'
#' Search a Tematres thesaurus via keywords. This function is a wrapper and so it calls
#' the appropriate funtions depending on the search task.
#'
#' @param term The term you are looking for
#' @param task Defines behavior on search. Defaults to "search" but can also be "broader"
#'        (look for upward definitions) and "narrower" (looking for downward definitions).
#'
#' @return The function returns a vector of keywords
#' @export rtematres.api.search

rtematres.api.search <- function(term, task="search") {
  if (task=="search")
    {
      results=rtematres.api(task = "search", argument = term)
      return(results)
    }
  if (task=="broaden")
    {
      id = rtematres.api.conversion.term_id(term)
      results = rtematres.api(task = "fetchUp", argument = id)
      return(results)
    }
  if (task=="narrow")
    {
      id = rtematres.api.conversion.term_id(term)
      results = rtematres.api(task = "fetchDown", argument = id)
      return(results)
    }
}

