#' Basic tematres server api
#'
#' @param task The api task you like to execute. Use the the "availableTasks"
#' 	  to get an overview about the base api. It returns a data frame with
#'        descriptions and the arguments for the tasks.
#'
#' @param argument Is the argument for the api task. You find the information
#'        about the arguments when you call the task "availableTasks".
#'
#' @return The function returns either a dataframe for information or a list
#'         of keywords and ids
#' @examples \dontrun{
#'     rtematres.api(task = "availableTasks")
#'     rtematres.api(task = "fetchVocabularyData")
#'     rtematres.api(task = "fetchTopTerms")
#'     rtematres.api(task = "search", argument = "measurement")
#'     rtematres.api(task = "letter", argument = "t")
#'     rtematres.api(task = "fetchTerm", argument = 12)
#'     rtematres.api(task = "fetchDown", argument = 4 )
#'     rtematres.api(task = "fetchUp", argument = 4)
#'     rtematres.api(task = "fetchRelated", argument = 4)
#'     rtematres.api(task = "fetchAlt", argument = 12 )
#'     rtematres.api(task = "fetchCode", argument = "tree")
#'     rtematres.api(task = "fetchNotes", argument = 5 )
#'     rtematres.api(task = "fetchDirectTerms", argument = 12)
#'     rtematres.api(task = "fetchURI", argument = 12)
#'     rtematres.api(task = "fetchTargetTerms", argument = 12 )
#'     rtematres.api(task = "fetchSourceTerm", argument = 12)
#'     rtematres.api(task = "fetchTerms", argument = '12,13' )
#'     rtematres.api(task = "fetchRelatedTerms", argument = '12,13' )
#'     rtematres.api(task = "fetchSimilar", argument = 12)
#'     rtematres.api(task = "fetchLast")
#'     rtematres.api.conversion.keyword_id(given = "Measurement")
#'     rtematres.api.conversion.keyword_id(given = 8)
#'  }
#'
#' @import RCurl
#' @import XML
#' @import gdata
#' @export

rtematres.api <- function(task = "availableTasks", argument) {
	if(task == "availableTasks") {
		base_service_url = getURL("tematres.befdata.biow.uni-leipzig.de/vocab/services.php")
		base_service_info = xmlTreeParse(base_service_url, useInternalNodes=T)
		tasks_available = trim(xpathSApply(base_service_info, "//task", xmlValue)[-1])
		tasks_description = trim(xpathSApply(base_service_info, "//action", xmlValue))
		tasks_argument =  trim(xpathSApply(base_service_info, "//arg", xmlValue)[-1])
		return(data.frame(tasks_available, tasks_description, tasks_argument))
	}

	# select task
	task = match.arg(task, c("fetchVocabularyData", "suggest", "suggestDetails", "fetchTopTerms", "search", "fetchCode", "letter", "fetchTerm", "fetchAlt", "fetchDown", "fetchUp", "fetchRelated", "fetchNotes", "fetchDirectTerms", "fetchURI", "fetchTargetTerms", "fetchSourceTerms", "fetchTerms", "fetchRelatedTerms", "letter", "fetchLast", "fetchSimilar"))

	tasks_need_no_argument = c("fetchLast", "fetchTopTerms", "fetchVocabularyData")

	if(any(task == tasks_need_no_argument)) {
	  url_param_sep = "?"
	  param_sep = "&"
	  task_trigger_name = "task"
	  assignment = "="
	  service_url = paste0(rtematres.options("tematres_service_url"), url_param_sep, task_trigger_name, assignment, task)
	} else {
	  url_param_sep = "?"
	  param_sep = "&"
	  task_trigger_name = "task"
	  arg_trigger_name = "arg"
	  assignment = "="
	  service_url = paste0(rtematres.options("tematres_service_url"), url_param_sep, task_trigger_name, assignment, task, param_sep, arg_trigger_name, assignment, argument )
	}

	response = xmlTreeParse(service_url, useInternalNodes = T)


	# scheme to use
	base_list = list(id = "//term/term_id",
		term = "//term/string")

	notes_list = list(id = "//term/term_id",
		term = "//term/string",
		language = "//term/note_lang",
		description = "//term/note_text")

	fetchVocabularyData_list = list(author = "//author",
		title = "//title",
		language = "//lang",
		uri = "//uri",
		lastMod = "//lastMod",
		count_terms = "//cant_terms",
		status = "//status")

	suggest_list = list(term = "//result/term")

	sheme = switch(task, fetchVocabularyData = fetchVocabularyData_list,
				fetchTopTerms = base_list,
				fetchCode = base_list,
				search = base_list,
				suggest = suggest_list,
				suggestDetails = base_list,
				letter = base_list,
				fetchAlt = base_list,
				fetchTerm = base_list,
				fetchAlt = base_list,
				fetchDown = base_list,
				fetchUp = base_list,
				fetchRelated = base_list,
				fetchNotes = notes_list,
				fetchDirectTerms = base_list,
				fetchURI = base_list,
				fetchTargetTerms = base_list,
				fetchSourceTerms = base_list,
				fetchTerms = base_list,
				fetchRelatedTerms = base_list,
				fetchSimilar = base_list,
				fetchLast = base_list
				)
	if(is.list(sheme)) {
	  rapply(sheme, function(x) xmlNodesValue(path=x, doc=response), how="replace")
	} else {
	  return(response)
	}
}

#' An tematres api helper that converts ids to strings and vise versa
#'
#' As the tematres api accepts ids of terms only on most of its tasks this is a small
#' helper that converts them into each other. It has two function names tha you can
#' use depending on what you are converting. But both function names do the same so
#' they can be exchanged. (rtematres.api.conversion.[key_id/id_key])
#'
#' @param given Either a keyword string or an integer id for a term
#' @param warn Give a waring when the term/id is not found. Defaults to TRUE.
#'
#' @return Either a string or id
#' @export rtematres.api.conversion.key_id

rtematres.api.conversion.key_id <- bef.tematres.api.conversion.id_key <- function(given, warn = T) {
	if(is.character(given)) {
		response = rtematres.api(task = "search", argument = given)
		the_id_is = response$id[which(response$term == given)]
		if(length(the_id_is) == 0 && warn) warning("Sorry no such term available!")
		return(the_id_is)
	} else {
		response = rtematres.api(task = "fetchTerm", argument = given)
		the_key_is = response$term[which(response$id == given)]
		if(length(the_key_is) == 0 && warn) warning("Sorry no such id available!")
		return(the_key_is)
	}
}

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
  id = rtematres.api.conversion.key_id(term, warn = F)
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
  if (task=="fetchUp")
    {
      id = rtematres.api.conversion.key_id(term, warn = F)
      results = rtematres.api(task = "fetchUp", argument = id)
      return(results)
    }
  if (task=="fetchDown")
    {
      id = rtematres.api.conversion.key_id(term, warn = F)
      results = rtematres.api(task = "fetchDown", argument = id)
      return(results)
    }
}
