#' Basic tematres server api
#' 
#' Features the basic tasks of the tematres server api. With no sugar added. 
#' They are the basic building blocks for more convenient user functions.
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
		base_service_url = getURL(rtematres.options("tematres_service_url"))
		base_service_info = xmlTreeParse(base_service_url, useInternalNodes=T)
		tasks_available = trim(xpathSApply(base_service_info, "//task", xmlValue)[-1])
		tasks_description = trim(xpathSApply(base_service_info, "//action", xmlValue))
		tasks_argument =  trim(xpathSApply(base_service_info, "//arg", xmlValue)[-1])
		return(data.frame(tasks_available, tasks_description, tasks_argument))
	}

	# select task
	task = match.arg(task, c("fetchVocabularyData", "suggest", "suggestDetails", "fetchTopTerms", "search", "searchNotes", "fetchCode", "letter", "fetchTerm", "fetchAlt", "fetchDown", "fetchUp", "fetchRelated", "fetchNotes", "fetchDirectTerms", "fetchURI", "fetchTargetTerms", "fetchSourceTerms", "fetchTerms", "fetchRelatedTerms", "fetchLast", "fetchSimilar"))

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
	base_list = list(term = "//term/string")
	
	fetch_similar_list = list(term = "//result/term/string", 
			   id = "//result/term/term_id")

	search_list = list(term = "//term/string", 
			   id = "//term/term_id")

	notes_list = list(term = "//term/string", 
		language = "//term/note_lang",
		description = "//term/note_text")

	fetchVocabularyData_list = list(author = "//author",
		title = "//title",
		language = "//lang",
		uri = "//uri",
		contributor = "//contributor",
		publisher = "//publisher",
		rights = "//rights",
		creation_date = "//createDate",
		last_modified = "//lastMod",
		count_terms = "//cant_terms",
		status = "//status",
		api_version = "//web_service_version")

	fetchTerm_list = list(term = "//term/string", 
			      language = "//term/lang",
			      created_at = "//term/date_create",
			      last_modified = "//term/date_mod")

	fetchTerms_list = list(term = "//term/string", 
			      language = "//term/lang",
			      created_at = "//term/date_create",
			      last_modified = "//term/date_mod")

	fetchTopTerms_list = list(term = "//term/string", 
			     language = "//term/lang")

	directTerms_list = list(term = "//term/string", relation = "//term/relation_type")

	suggest_list = list(term = "//result/term") 

	fetchDown_list = list(term = "//term/string",
			      relation_type = "//term/relation_type",
			      has_narrower_terms = "//term/hasMoreDown")
	
	fetchUp_list = list(term = "//term/string",
			    order = "//term/order")


	sheme = switch(task, fetchVocabularyData = fetchVocabularyData_list,
		       fetchTopTerms = fetchTopTerms_list,
		       fetchCode = base_list,
		       search = search_list,
		       searchNotes = search_list,
		       suggest = suggest_list,
		       suggestDetails = base_list,
		       letter = base_list,
		       fetchAlt = base_list,
		       fetchTerm = fetchTerm_list,
		       fetchAlt = base_list,
		       fetchDown = fetchDown_list,
		       fetchUp = fetchUp_list,
		       fetchRelated = base_list,
		       fetchNotes = notes_list,
		       fetchDirectTerms = directTerms_list,
		       fetchURI = base_list,
		       fetchTargetTerms = base_list,
		       fetchSourceTerms = base_list,
		       fetchTerms = fetchTerms_list,
		       fetchRelatedTerms = base_list,
		       fetchSimilar = fetch_similar_list,
		       fetchLast = base_list
		       )
	if(is.list(sheme)) {
	  rapply(sheme, function(x) xmlNodesValue(path=x, doc=response), how="replace")
	} else {
	  return(response)
	}
}

