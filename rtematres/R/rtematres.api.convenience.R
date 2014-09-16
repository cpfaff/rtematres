#' Convenient functions for various tasks
#'
#' Define a concepts
#'
#' The function retrieves the definition of a term. This works of course only given
#' the case it has been described in the vocuabulary you query.
#'
#' @param term The concept you are looking for
#'
#' @return It returns a text string describing the concept of interest
#' @export rtematres.define

rtematres.define <- function(term) {
  id = rtematres.api.conversion.term_id(term)
  term_notes = rtematres.api(task = "fetchNotes", argument = id)
  term_notes$note_text = html.sanitize(term_notes$note_text)
  if(is.na(term_notes$note_text)) {
    warning("Sorry no definition for your term found!")
  } else {
    return(term_notes$note_text)
  }
}

#' Search for concepts
#'
#' Search the thesaurus for concepts. This function is a wrapper and so it
#' calls the appropriate funtions depending on the search task.
#'
#' @param term The concept you are looking for
#' @param includenotes Include definition texts in the search (true, false). Note
#' 	  that one is only working for searches containing > 2 characters.
#'	  otherwise it is just ignored.
#' @return The function returns a vecor or a list of results for the search
#' @export rtematres.search

rtematres.search <- function(term, includenotes = FALSE) {
  if(nchar(term) == 1)
  {
    results = suppressWarnings(rtematres(task = "letter", term = term))
  } else {
    results = suppressWarnings(rtematres(task = "search", term = term))

    if(includenotes) {
      notes_results = suppressWarnings(rtematres(task = "searchNotes", term = term))
      results = list(in_terms = results, in_notes_of = notes_results, unique_terms = unique(results, notes_results))
    }
  }
  if(length(results) == 1 && all(is.na(results)) || is.null(results)){
    suggestion = rtematres(task = "fetchSimilar", term = term)
    warning(paste("Sorry no results for your query!", "Do you mean:", suggestion))
    return(suggestion)
  } else {
    return(results)
  }
}

#' Locate concepts in hierarchy
#'
#' Search the thesaurus for concepts and extract their hirarchy.
#' This envolves higher order and lower order terms.
#'
#' @param term The concept you are looking for
#' @return The function returns a character vector of concepts
#' @examples \dontrun{
#' 	rtematres.hierarchy("carbon")
#'  }
#' @export rtematres.hierarchy

rtematres.hierarchy <- function(term) {
   terms_above = rtematres(task = "fetchUp", term = term)
   terms_below = rtematres(task = "fetchDown", term = term)
   return(c(terms_above, terms_below))
}

#' Find common concept for categorial columns
#'
#' Search the thesaurus for concepts and extract their hirarchy.
#' Then return the common concept if any.
#'
#' @param input A categorial vector
#' @return The function returns the common concept
#' @examples \dontrun{
#' 	rtematres.common(c("carbon", "nitrogen", "organic carbon"))
#'  }
#' @export rtematres.common

rtematres.common <- function(input) {
  upstream_concepts = sapply(input, function(x) suppressWarnings(rtematres(task = "fetchUp", term = x)), simplify = FALSE, USE.NAMES = TRUE)
  common_concepts = Reduce(intersect, upstream_concepts)
  common_concept = common_concepts[length(common_concepts)]
  if(identical(common_concepts, character(0)) || is.null(common_concept)) {
    return(NA)
  } else {
    return(common_concept)
  }
}

#' Create a summary for a vector
#'
#' Search the thesaurus for concepts in case of categorical textual vector.
#' Create a five value summary for numerical columns.
#'
#' @param input A categorial vector
#' @return The function returns a summary
#' @examples \dontrun{
#'     rtematres.summary(input = iris$Species)
#'     lapply(iris, function(x) rtematres.summary(input = x))
#'  }
#'
#' @export rtematres.summary

rtematres.summary <- function(input) {
   if(is.factor(input)) {
     return_value = suppressWarnings(rtematres.common(as.character(input)))
   }
   if(is.character(input)) {
     return_value = suppressWarnings(rtematres.common(input))
   }
   if(is.numeric(input)) {
     return_value = summary(input)
   }
   return(return_value)
}

#' Summarize information for a concept
#'
#' Summarizes information for a concept in one convenient function
#' call. Currently it provides the definition, upstream and down
#' stream concepts for the term you querry for and related concepts
#'
#' @param input A concept name as string
#' @return The function returns a list containing the information
#' @examples \dontrun{
#'     rtematres.illuminate(input = "carbon")
#'  }
#'
#' @export rtematres.illuminate


rtematres.illuminate <- function(input) {
  concept_definition = suppressWarnings(rtematres(task = "fetchNotes", term = input))
  if(is.null(concept_definition))
    concept_definition = NA

  list(concept_definition = concept_definition,
       upstream_concepts = suppressWarnings(rtematres(task = "fetchUp", term = input)),
       downstream_concepts = suppressWarnings(rtematres(task = "fetchDown", term = input)),
       direct_related_concepts = suppressWarnings(rtematres(task = "fetchRelated", term = input))
       )
}
