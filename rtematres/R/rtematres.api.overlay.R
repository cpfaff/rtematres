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
#'     rtematres(task = "availableTasks")
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
  # task only tasks
  if(task == "availableTasks")
  {
    results = rtematres.api(task = "availableTasks")
    return(results)
  }

  if(task == "fetchVocabularyData")
  {
    results = rtematres.api(task = "fetchVocabularyData")
    return(results)
  }
  if(task == "fetchTopTerms")
  {
    results = rtematres.api(task = "fetchTopTerms")
    return(results)
  }
  if(task == "fetchLast")
  {
    results = rtematres.api(task = "fetchLast")
    return(results)
  }

  # tasks that accept multiple terms

  if(task == "fetchTerms")
  {
    if(class(term) != "character") stop("This task only takes a string or character vector as input")
    id = paste(sapply(term, function(x) rtematres.api.conversion.term_id(x), USE.NAMES = F), collapse = ",")
    results = rtematres.api(task = "fetchTerms", argument = id)
    return(results)
  }
  if(task == "fetchRelatedTerms")
  {
    if(class(term) != "character") stop("This task only takes a string as input")
    id = paste(sapply(term, function(x) rtematres.api.conversion.term_id(x), USE.NAMES = F), collapse = ",")
    results = rtematres.api(task = "fetchRelatedTerms", argument = id)
    return(results)
  }

  # tasks that accept one term
  if(class(term) != "character") stop("This task only takes a string as input")
  if(length(term) != 1) stop("This task only works on a single string as input")

  if(task == "fetchCode")
  {
    results = rtematres.api(task = "fetchCode", argument = term)
    return(results)
  }

  if(task == "search")
  {
    if(nchar(term) < 2) {
      stop("This task only works for > 2 letters")
    }
    search = rtematres.api(task = "search", argument = term)
    return(search)
  }
  if(task == "fetch")
  {
    if(nchar(term) < 2) {
      stop("This task only works for > 2 letters")
    }
    results = rtematres.api(task = "fetch", argument = term)
    return(results)
  }
  if(task == "searchNotes")
  {
    if(nchar(term) < 2) {
      warning("This task only works for > 2 letters")
    }
    search = rtematres.api(task = "searchNotes", argument = term)
    return(search)
  }
  if(task == "suggest")
  {
    if(nchar(term) < 2) {
      warning("This task only works for > 2 letters")
    }
    results = rtematres.api(task = "suggest", argument = term)
    return(results)
  }
  if(task == "suggestDetails")
  {
    if(nchar(term) < 2) {
      warning("This task only works for > 2 letters")
    }
    results = rtematres.api(task = "suggestDetails", argument = term)
    return(results)
  }
  if(task == "fetchSimilar")
  {
    results = rtematres.api(task = "fetchSimilar", argument = term)
    return(results)
  }
  if(task == "letter")
  {
    if(nchar(term) > 1) {
      warning("This task only works for 1 letter input")
    }
    results = rtematres.api(task = "letter", argument = term)
    return(results)
  }
  if(task == "fetchAlt")
  {
    id = rtematres.api.conversion.term_id(term)
    results = rtematres.api(task = "fetchAlt", argument = id)
    return(results)
  }
  if(task == "fetchTerm")
  {
    id = rtematres.api.conversion.term_id(term)
    results = rtematres.api(task = "fetchTerm", argument = id)
    return(results)
  }
  if(task=="fetchDown")
  {
    id = rtematres.api.conversion.term_id(term)
    results = rtematres.api(task = "fetchDown", argument = id)
    return(results$term)
  }
  if(task=="fetchUp")
  {
    id = rtematres.api.conversion.term_id(term)
    results = rtematres.api(task = "fetchUp", argument = id)
    return(results$term)
  }
  if(task == "fetchRelated")
  {
    id = rtematres.api.conversion.term_id(term)
    results = rtematres.api(task = "fetchRelated", argument = id)
    return(results)
  }
  if(task == "fetchNotes")
  {
    id = rtematres.api.conversion.term_id(term)
    results = rtematres.api(task = "fetchNotes", argument = id)
    results$note_text = html.escape(results$note_text)
    return(results)
  }
  if(task == "fetchDirectTerms")
  {
    id = rtematres.api.conversion.term_id(term)
    results = rtematres.api(task = "fetchDirectTerms", argument = id)
    return(results)
  }
  if(task == "fetchURI")
  {
    id = rtematres.api.conversion.term_id(term)
    results = rtematres.api(task = "fetchURI", argument = id)
    return(results)
  }
  if(task == "fetchTargetTerms")
  {
    if(class(term) != "character") stop("This task only takes a string as input")
    id = rtematres.api.conversion.term_id(term)
    results = rtematres.api(task = "fetchTargetTerms", argument = id)
    return(results)
  }
  if(task == "fetchSourceTerms")
  {
    id = rtematres.api.conversion.term_id(term)
    results = rtematres.api(task = "fetchSourceTerms", argument = id)
    return(results)
  }
}
