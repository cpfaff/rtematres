#' A convenient wrapper to all tasks of the base api.
#'
#' As some of the task of the base api only take ids the wrapper does
#' a conversion from a term to the id to communicate with the server.
#' So you can use terms in all taks with this function.
#' @param task The api task you like to execute.
#' @param term Is the term(s) you like to execute the task for.
#' @param verbose Either true of false and determines the ammount of info
#'        that is returned by a query.
#' @return The function returns either a dataframe for information or a list
#'         of keywords and ids
#' @examples \dontrun{
#'     rtematres(task = "fetchVocabularyData")
#'     rtematres(task = "fetchTopTerms")
#'     rtematres(task = "fetchCode", term = "tree")
#'     rtematres(task = "search", term = "measurement")
#'     rtematres(task = "fetch", term = "measurement")
#'     rtematres(task = "searchNotes", term = "measurement")
#'     rtematres(task = "suggest", term = "measurement")
#'     rtematres(task = "suggestDetails", term = "measurement")
#'     rtematres(task = "fetchSimilar", term = "t")
#'     rtematres(task = "letter", term = "t")
#'     rtematres(task = "fetchAlt", term = "tree" )
#'     rtematres(task = "fetchTerm", term = "tree")
#'     rtematres(task = "fetchTerms", term = c("Context", "tree") )
#'     rtematres(task = "fetchDown", term = "Context")
#'     rtematres(task = "fetchUp", term = "measurement")
#'     rtematres(task = "fetchRelated", term = "tree")
#'     rtematres(task = "fetchRelatedTerms", term = c("Context", "tree"))
#'     rtematres(task = "fetchNotes", term = "Context")
#'     rtematres(task = "fetchDirectTerms", term = "carbon")
#'     rtematres(task = "fetchURI", term = "carbon")
#'     rtematres(task = "fetchTargetTerms", term = "carbon")
#'     rtematres(task = "fetchSourceTerms", term = "Context")
#'     rtematres(task = "fetchLast")
#'   }
#' @import plyr
#' @export rtematres

rtematres <- function(task, verbose = F, term) {

  task = match.arg(task, c("fetchVocabularyData", "suggest", "suggestDetails", "fetchTopTerms", "search", "fetch", "searchNotes", "fetchCode", "fetchSimilar", "letter", "fetchTerm", "fetchAlt", "fetchDown", "fetchUp", "fetchRelated", "fetchNotes", "fetchDirectTerms", "fetchURI", "fetchTargetTerms", "fetchSourceTerms", "fetchTerms", "fetchRelatedTerms", "fetchLast"))

  if(task == "fetchVocabularyData")
  {
    results = rtematres.api(task = "fetchVocabularyData")
    return(results)
  }
  if(task == "fetchTopTerms")
  {
    results = rtematres.api(task = "fetchTopTerms")
    if(verbose)
      return(results)
    else
      return(results$term)
  }
  if(task == "fetchLast")
  {
    results = rtematres.api(task = "fetchLast")
    if(length(results$term) == 1 && all(is.na(results$term))){
      warning("Sorry no results for your query!")
    } else {
      if(verbose)
	return(results)
      else
	return(results$term)
    }
  }

  # tasks that accept multiple terms NOTE: This must be tested if it works
  if(task %in% c("fetchTerms", "fetchRelatedTerms")){
    if(class(term) != "character") stop("This task only takes a string or character vector as input")
    id = paste(sapply(term, function(x) rtematres.api.conversion.term_id(x), USE.NAMES = F), collapse = ",")
  }

  if(task == "fetchTerms")
  {
    results = rtematres.api(task = "fetchTerms", argument = id)
    if(length(results$term) == 1 && all(is.na(results$term))){
      warning("Sorry no results for your query!")
    } else {
      return(results)
    }
  }
  if(task == "fetchRelatedTerms")
  {
    results = rtematres.api(task = "fetchRelatedTerms", argument = id)
    if(length(results$term) == 1 && all(is.na(results$term))){
      warning("Sorry no results for your query!")
    } else {
      return(results)
    }
  }

  # tasks that accept one term
  if(class(term) != "character") stop("This task only takes a string as input")
  if(length(term) != 1) stop("This task only works on a single string as input")

  if(task == "fetchCode")
  {
    results = rtematres.api(task = "fetchCode", argument = term)
    if(length(results$term) == 1 && all(is.na(results$term))){
      warning("Sorry no results for your query!")
    } else {
      return(results)
    }
  }

  if(task == "search")
  {
    if(nchar(term) < 2) {
      stop("This task only works for > 2 letters")
    }
    results = rtematres.api(task = "search", argument = term)
    if(length(results$term) == 1 && all(is.na(results$term))){
      warning("Sorry no results for your query!")
    } else {
      return(results$term)
    }

  }

  if(task == "fetch")
  {
    if(nchar(term) < 2) {
      stop("This task only works for > 2 letters")
    }
    results = rtematres.api(task = "fetch", argument = term)
    if(length(results$term) == 1 && all(is.na(results$term))){
      warning("Sorry no results for your query!")
    } else {
      return(results)
    }
  }
  if(task == "searchNotes")
  {
    if(nchar(term) < 2) {
      warning("This task only works for > 2 letters")
    }
    results = rtematres.api(task = "searchNotes", argument = term)
    if(length(results$term) == 1 && all(is.na(results$term))){
      warning("Sorry no results for your query!")
    } else {
      if(verbose)
	return(results)
      else
	return(results$term)
    }
  }
  if(task == "suggest")
  {
    if(nchar(term) < 2) {
      warning("This task only works for > 2 letters")
    }
    results = rtematres.api(task = "suggest", argument = term)
    if(length(results$term) == 1 && all(is.na(results$term))){
      warning("Sorry no results for your query!")
    } else {
      return(results)
    }
  }
  if(task == "suggestDetails")
  {
    if(nchar(term) < 2) {
      warning("This task only works for > 2 letters")
    }
    results = rtematres.api(task = "suggestDetails", argument = term)
    if(length(results$term) == 1 && all(is.na(results$term))){
      warning("Sorry no results for your query!")
    } else {
      if(verbose)
	return(results)
      else
	return(results$term)
    }
  }
  if(task == "fetchSimilar")
  {
    results = rtematres.api(task = "fetchSimilar", argument = term)
    if(length(results$term) == 1 && all(is.na(results$term))){
      warning("Sorry no results for your query!")
    } else {
      if(verbose)
	return(results)
      else
	return(results$term)
    }
  }
  if(task == "letter")
  {
    if(nchar(term) > 1) {
      warning("This task only works for 1 letter input")
    }
    results = rtematres.api(task = "letter", argument = term)
    if(length(results$term) == 1 && all(is.na(results$term))){
      warning("Sorry no results for your query!")
    } else {
      return(results$term)
    }
  }
  if(task == "fetchAlt")
  {
    id = rtematres.api.conversion.term_id(term)
    results = rtematres.api(task = "fetchAlt", argument = id)
    if(length(results$term) == 1 && all(is.na(results$term))){
      warning("Sorry no results for your query!")
    } else {
      if(verbose)
	return(results)
      else
	return(results$term)
    }
  }
  if(task == "fetchTerm")
  {
    id = rtematres.api.conversion.term_id(term)
    results = rtematres.api(task = "fetchTerm", argument = id)
    if(length(results$term) == 1 && all(is.na(results$term))){
      warning("Sorry no results for your query!")
    } else {
      return(results)
    }
  }
  if(task=="fetchDown")
  {
    id = rtematres.api.conversion.term_id(term)
    results = rtematres.api(task = "fetchDown", argument = id)
    # if(recurisve) {
      # then fetch down a round as normal
      # find terms hat have more terms down (has_narrower_terms)
      # pick these only and fetch further down with the fetch down term
	# NOTE: this is a loop task like the oters above
	# e.g like paste(sapply(term, function(x) rtematres.api.conversion.term_id(x), USE.NAMES = F), collapse = ",")
      #
    # }
    if(length(results$term) == 1 && all(is.na(results$term))){
      warning("Sorry no results for your query!")
    } else {
      if(verbose)
	return(results)
      else
	return(results$term)
    }
  }
  if(task=="fetchUp")
  {
    id = rtematres.api.conversion.term_id(term)
    results = rtematres.api(task = "fetchUp", argument = id)
    if(length(results$term) == 1 && all(is.na(results$term))){
      warning("Sorry no results for your query!")
    } else {
      if(verbose)
	return(results)
      else
	return(results$term)
    }
  }
  if(task == "fetchRelated")
  {
    id = rtematres.api.conversion.term_id(term)
    results = rtematres.api(task = "fetchRelated", argument = id)
    if(length(results$term) == 1 && all(is.na(results$term))){
      warning("Sorry no results for your query!")
    } else {
      if(verbose)
	return(results)
      else
	return(results$term)
    }
  }
  if(task == "fetchNotes")
  {
    id = rtematres.api.conversion.term_id(term)
    results = rtematres.api(task = "fetchNotes", argument = id)
    results$note_text = html.sanitize(results$note_text)
    if(length(results$term) == 1 && all(is.na(results$term))){
      warning("Sorry no results for your query!")
    } else {
      if(verbose)
	return(results)
      else
	return(results$note_text)
    }
  }
  if(task == "fetchDirectTerms")
  {
    id = rtematres.api.conversion.term_id(term)
    results = rtematres.api(task = "fetchDirectTerms", argument = id)
    if(length(results$term) == 1 && all(is.na(results$term))){
      warning("Sorry no results for your query!")
    } else {
      return(results)
    }
  }
  if(task == "fetchURI")
  {
    id = rtematres.api.conversion.term_id(term)
    results = rtematres.api(task = "fetchURI", argument = id)
    if(length(results$term) == 1 && all(is.na(results$term))){
      warning("Sorry no results for your query!")
    } else {
      return(results)
    }
  }
  if(task == "fetchTargetTerms")
  {
    if(class(term) != "character") stop("This task only takes a string as input")
    id = rtematres.api.conversion.term_id(term)
    results = rtematres.api(task = "fetchTargetTerms", argument = id)
    if(verbose)
      return(results)
    else
      return(results$term)
  }
  if(task == "fetchSourceTerms")
  {
    id = rtematres.api.conversion.term_id(term)
    results = rtematres.api(task = "fetchSourceTerms", argument = id)
  }
}
