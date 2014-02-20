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
  id = rtematres.api.conversion.term_id(term, warn = F)
  term_notes = rtematres.api(task = "fetchNotes", argument = id)
  term_notes$description = clean_html_string(term_notes$description)
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
      id = rtematres.api.conversion.term_id(term, warn = F)
      results = rtematres.api(task = "fetchUp", argument = id)
      return(results)
    }
  if (task=="narrow")
    {
      id = rtematres.api.conversion.term_id(term, warn = F)
      results = rtematres.api(task = "fetchDown", argument = id)
      return(results)
    }
}

#' A convenient wrapper to all tasks of the base api.
#'
#' As some of the task of the base api only take ids the wrapper does
#' a conversion from a term to the id to communicate with the server.
#' So you can use terms in all taks with this function.
#' @param task The api task you like to execute. Use the the "availableTasks"
#' 	  to get an overview about the base api. It returns a data frame with
#'        descriptions and the arguments for the tasks.
#' @param term Is the term(s) you like to execute the task for.
#' @param verbose Either true of false and determines the ammount of info
#'        that is returned by a query. 
#' @return The function returns either a dataframe for information or a list
#'         of keywords and ids
#' @examples \dontrun{
#'     rtematres(task = "availableTasks")
#'     rtematres(task = "fetchVocabularyData")
#'     rtematres(task = "suggest", term = "measurement")
#'     rtematres(task = "suggestDetails", term = "measurement")
#'     rtematres(task = "fetchTopTerms")
#'     rtematres(task = "search", term = "measurement")
#'     rtematres(task = "letter", term = "t")
#'     rtematres(task = "fetchTerm", term = "tree")
#'     rtematres(task = "fetchTerms", term = c("Context", "tree") )
#'     rtematres(task = "fetchDown", term = "Context")
#'     rtematres(task = "fetchUp", term = "measurement")
#'     rtematres(task = "fetchRelated", term = "tree")
#'     rtematres(task = "fetchAlt", term = "tree" )
#'     rtematres(task = "fetchCode", term = "tree")
#'     rtematres(task = "fetchNotes", term = "Context")
#'     rtematres(task = "fetchDirectTerms", term = "carbon")
#'     rtematres(task = "fetchURI", term = "carbon")
#'     rtematres(task = "fetchTargetTerms", term = "carbon")
#'     rtematres(task = "fetchSourceTerm", term = "Context")
#'     rtematres(task = "fetchRelatedTerms", term = c("Context", "tree"))
#'     rtematres(task = "fetchSimilar", term = "tree")
#'     rtematres(task = "fetchLast")
#'   }
#' @import plyr
#' @export rtematres

rtematres <- function(task, verbose=F, term, includenotes=F) {
  if (task == "search")
  {
    if(nchar(term) < 2) {
      search = rtematres.api(task = "letter", argument = term)
    } else {
      search = rtematres.api(task = "search", argument = term)
    }
    results = search
    if(includenotes){
      notes = rtematres.api(task = "searchNotes", argument = term)
      results$term = unique(c(search$term, notes$term))
    }
    return(results$term)
  }

  if (task=="broaden")
    {
      id = rtematres.api.conversion.term_id(term, warn = F)
      results = rtematres.api(task = "fetchUp", argument = id)
      return(results$term)
    }

  if (task=="narrow")
    {
      id = rtematres.api.conversion.term_id(term, warn = F)
      results = rtematres.api(task = "fetchDown", argument = id)
      return(results$term)
    }

  if (task == "define")
    {
      id = rtematres.api.conversion.term_id(term, warn = F)
      results = rtematres.api(task = "fetchNotes", argument = id)
      results$description = clean_html_string(results$description)
      if(verbose) {
	editing = rtematres.api(task = "fetchTerm", argument = id)
	results$created_at = editing$created_at
	results$last_modified = editing$last_modified 

	return(results)
      } else {
	return(results$description)
      }
    }

  if (task == "definerelation") {

    id = rtematres.api.conversion.term_id(term, warn = F)

    broader_terms = rtematres.api(task = "fetchUp", argument = id)$term
    narrower_terms = rtematres.api(task = "fetchDown", argument = id)$term
    directly_connected_terms = rtematres.api(task = "fetchDirectTerms", argument = id) # fetch all relations directly connected
    source_terms = rtematres.api(task = "fetchSourceTerms", argument = id) # fetch all relations directly connected
    target_terms = rtematres.api(task = "fetchTargetTerms", argument = id) # from source to target
    related_terms = rtematres.api(task = "fetchRelated", argument = id)
    results = list("broader_terms" = broader_terms, 
		   "narrower_terms" = narrower_terms, 
		   "source_terms" = source_terms, 
		   "directly_connected_terms" = directly_connected_terms, 
		   "target_terms" = target_terms, 
		   "related_terms" = related_terms)
    return(results)
  }

  # old ones 

  if (task == "fetchTerm")
    {
      id = rtematres.api.conversion.term_id(term, warn = F)
      return(results)
    }
  # if (task == "fetchTerms")
    # {
      # id = paste(sapply(term, function(x) rtematres.api.conversion.term_id(x, warn = F), USE.NAMES = F), collapse = ",")
      # results = rtematres.api(task = "fetchTerms", argument = id)
      # return(results)
    # }
  if (task == "fetchRelated")
    {
      id = rtematres.api.conversion.term_id(term, warn = F)
      results = rtematres.api(task = "fetchRelated", argument = id)
      return(results)
    }
  if (task == "related")
    {
      id = rtematres.api.conversion.term_id(term, warn = F)
      results = list(results_alternative = rtematres.api(task = "fetchAlt", argument = id),
      results_direct_relations = rtematres.api(task = "fetchDirectTerms", argument = id))
      return(results)
    }

  if (task == "fetchDirectTerms")
    {
      id = rtematres.api.conversion.term_id(term, warn = F)
      results = rtematres.api(task = "fetchDirectTerms", argument = id)
      return(results)
    }
  if (task == "fetchURI")
    {
      id = rtematres.api.conversion.term_id(term, warn = F)
      results = rtematres.api(task = "fetchURI", argument = id)
      return(results)
    }
  if (task == "fetchTargetTerms")
    {
      id = rtematres.api.conversion.term_id(term, warn = F)
      results = rtematres.api(task = "fetchTargetTerms", argument = id)
      return(results)
    }
  if (task == "fetchSourceTerms")
    {
      id = rtematres.api.conversion.term_id(term, warn = F)
      results = rtematres.api(task = "fetchSourceTerms", argument = id)
      return(results)
    }
  if (task == "fetchRelatedTerms")
    {
      id = paste(sapply(term, function(x) rtematres.api.conversion.term_id(x, warn = F), USE.NAMES = F), collapse = ",")
      results = rtematres.api(task = "fetchRelatedTerms", argument = id)
      return(results)
    }
  if (task == "fetchSimilar")
    {
      id = rtematres.api.conversion.term_id(term, warn = F)
      results = rtematres.api(task = "fetchSimilar", argument = id)
      return(results)
    }
  if (task == "fetchCode")
    {
      results = rtematres.api(task = "fetchCode", argument = term)
      return(results)
    }
  if (task == "suggest")
    {
      results = rtematres.api(task = "suggest", argument = term)
      return(results)
    }
  if (task == "suggestDetails")
    {
      results = rtematres.api(task = "suggestDetails", argument = term)
      return(results)
    }
  if (task == "letter")
    {
      results = rtematres.api(task = "letter", argument = term)
      return(results)
    }
  if (task == "fetchLast")
    {
      results = rtematres.api(task = "fetchLast")
      return(results)
    }
  if (task == "fetchVocabularyData")
    {
      results = rtematres.api(task = "fetchVocabularyData")
      return(results)
    }
  if (task == "fetchTopTerms")
    {
      results = rtematres.api(task = "fetchTopTerms")
      return(results)
    }
}

