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
#'     rtematres.api(task = "fetchSourceTerm", argument = "measurement")
#'     rtematres.api(task = "fetchTerms", argument = '12,13' )
#'     rtematres.api(task = "fetchRelatedTerms", argument = '12,13' )
#'     rtematres.api(task = "fetchSimilar", argument = "mesur")
#'     rtematres.api(task = "fetchLast")
#'     rtematres.api.conversion.keyword_id(given = "measurement")
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
	task = match.arg(task, c("fetchVocabularyData", "suggest", "suggestDetails", "fetchTopTerms", "search", "fetch", "searchNotes", "fetchCode", "letter", "fetchTerm", "fetchAlt", "fetchDown", "fetchUp", "fetchRelated", "fetchNotes", "fetchDirectTerms", "fetchURI", "fetchTargetTerms", "fetchSourceTerms", "fetchTerms", "fetchRelatedTerms", "fetchLast", "fetchSimilar"))

	tasks_need_no_argument = c("fetchLast", "fetchTopTerms", "fetchVocabularyData")

	needs_api_one_four = c("fetch")

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
	fetchVocabularyData_list = list(vocabulary_id = "//vocabulary_id",
					title = "//title",
					author = "//author",
					language = "//lang",
					scope = "//scope",
					keywords = "//keywords",
					uri = "//uri",
					created_at = "//createDate",
					last_modified_at = "//lastMod",
					contributors = "//contributor",
					publisher = "//publisher",
					rights = "//rights",
					count_of_terms = "//cant_terms",
					status = "//status", 
					server_version = "//version",
					api_version = "//web_service_version")

	fetchTopTerms_list = list(term = "//term/string", 
				  language = "//term/lang",
				  term_id = "//term/term_id",
				  code = "//term/code", 
				  is.meta.term = "//term/isMetaTerm")

	# used in search and search notes (searches complete strings)
	# (usable with 2 letters or more)
	# implement a "to short check"
	search_list = list(term = "//term/string", 
			   term_id = "//term/term_id", 
			   is.meta.term = "//term/isMetaTerm", 
			   no_term_string = "//term/no_term_string",
			   index = "//term/index", 
			   order = "//term/order")

	# this task is for search with exact matching available sind api 1.4
	fetch_list = list(term = "//term/string", 
			  term_id = "//term/term_id", 
			  is.meta.term = "//term/isMetaTerm", 
			  no_term_string = "//term/no_term_string",
			  order = "//term/order")

	# also a search but only from start of string (usable with 2 letters or more) 
	# implement a "to short check"
	suggest_list = list(term = "//result/term") 

	# like the suggest but with more details 
	suggestDetails_list = list(term = "//term/string", 
				   term_id = "//term/term_id", 
				   is.meta.term = "//term/isMetaTerm", 
				   no_term_string = "//term/no_term_string",
				   index = "//term/index", 
				   order = "//term/order")
	
	# a search for terms starting with a letter (only 1 letter) 
	letter_list = list(term = "//term/string", 
			   term_id = "//term/term_id", 
			   is.meta.term = "//term/isMetaTerm", 
			   no_term_string = "//term/no_term_string",
			   relation_type_id = "//term/relation_type_id")

	fetchTerm_list = list(term = "//term/string", 
			      language = "//term/lang",
			      term_id = "//term/term_id",
			      tema_id = "//term/tema_id",
			      code = "//term/code", 
			      is.meta.term = "/term/isMetaTerm",
			      created_at = "//term/date_create",
			      last_modified_at = "//term/date_mod")

	fetchTerms_list = list(term = "//term/string", 
			       term_id = "//term/term_id",
			       is.meta.term = "//term/isMetaTerm")

	fetchAlt_list = list(term = "//term/string", 
			     language = "//term/lang",
			     term_id = "//term/term_id",
			     code = "//term/code",
			     relation_type = "//term/relation_type",
			     relation_code = "//term/relation_code",
			     relation_label = "//terms/relation_label",
			     relation_type_id = "//relation_type_id")

	fetchDown_list = list(term = "//term/string",
			      language = "//term/lang",
			      term_id= "//term/term_id",
			      is.meta.term = "/term/isMetaTerm",
			      relation_type = "//term/relation_type",
			      relation_code = "//term/relation_code",
			      relation_label = "//terms/relation_label",
			      has_narrower_terms = "//term/hasMoreDown")
	
	fetchUp_list = list(term = "//term/string",
			    term_id = "//term/term_id",
			    is.meta.term = "//term/isMetaTerm",
			    relation_type_id = "//term/relation_type_id",
			    order = "//term/order")

	fetchRelated_list = list(term = "//term/string",
				 language = "//term/lang",
				 term_id= "//term/term_id",
				 is.meta.term = "//term/isMetaTerm",
				 code = "//term/code",
				 relation_type = "//term/relation_type",
				 relation_code = "//term/relation_code",
				 relation_label = "//terms/relation_label",
				 relation_type_id = "//relation_type_id")

	fetchNotes_list = list(term = "//term/string", 
			       term_id = "//term/term_id",
			       note_id = "//term/note_id",
			       note_type = "//term/note_type",
			       note_language = "//term/note_lang",
			       note_text = "//term/note_text")

	directTerms_list = list(term = "//term/string",
				language = "//term/lang",
				term_id= "//term/term_id",
				is.meta.term = "//term/isMetaTerm",
				code = "//term/code",
				relation_type = "//term/relation_type",
				relation_code = "//term/relation_code",
				relation_label = "//terms/relation_label",
				relation_type_id = "//relation_type_id")

	fetchURI_list = list(link_type = "//term/link_type",
			     link = "//term/link")

	# fetch target information
	fetchTargetTerms_list = list(term = "//term/string", 
				     term_id = "//term/term_id",
				     term_url = "//term/url", 
				     term_uri = "//term/uri",
				     target_vocabulary_label = "//term/target_vocabulary_label",
				     target_vocabulary_tag = "//term/target_vocabulary_tag",
				     target_vocabulary_title = "//term/target_vocabulary_title")

	fetchRelatedTerms_list = list(term = "//term/string", 
				      term_id = "//term/term_id",
				      is.meta.term = "//term/isMetaTerm")

	fetch_similar_list = list(term = "//result/string")

	fetchTerm_list = list(term = "//term/string", 
			      language = "//term/lang",
			      term_id = "//term/term_id",
			      tema_id = "//term/tema_id",
			      code = "//term/code", 
			      is.meta.term = "/term/isMetaTerm",
			      created_at = "//term/date_create",
			      last_modified_at = "//term/date_mod")

	fetchLast_list = list(term = "//term/string", 
			      language = "//term/lang",
			      term_id = "//term/term_id",
			      code = "//term/code", 
			      is.meta.term = "/term/isMetaTerm",
			      created_at = "//term/date_create",
			      last_modified_at = "//term/date_mod")

	# could not test fetchSourceTerms so it is using the base list
	base_list = list(term = "//term/string")

	sheme = switch(task, fetchVocabularyData = fetchVocabularyData_list,
		       fetchTopTerms = fetchTopTerms_list,
		       fetchCode = base_list,
		       search = search_list,
		       fetch = fetch_list,
		       searchNotes = search_list,
		       suggest = suggest_list,
		       suggestDetails = suggestDetails_list,
		       letter = base_list,
		       fetchAlt = fetchAlt_list,
		       fetchTerm = fetchTerm_list,
		       fetchTerms = fetchTerms_list,
		       fetchAlt = base_list,
		       fetchDown = fetchDown_list,
		       fetchUp = fetchUp_list,
		       fetchRelated = fetchRelated_list,
		       fetchRelatedTerms = fetchRelatedTerms_list,
		       fetchNotes = fetchNotes_list,
		       fetchDirectTerms = directTerms_list,
		       fetchURI =fetchURI_list,
		       fetchTargetTerms = fetchTargetTerms_list,
		       fetchSourceTerms = base_list,
		       fetchSimilar = fetch_similar_list,
		       fetchLast = fetchLast_list
		       )
	if(is.list(sheme)) {
	  rapply(sheme, function(x) xmlNodesValue(path=x, doc=response), how="replace")
	} else {
	  return(response)
	}
}

