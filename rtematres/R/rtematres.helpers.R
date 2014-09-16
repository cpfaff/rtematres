# clean html strings

html.sanitize <- function(string) {
  remove_tags = gsub("<.*?>", "", string)
  remove_newlines = gsub("\\n"," ",remove_tags)
  replace_escaped_quotes = gsub("\"", "'", remove_newlines)
  remove_square_brackets = gsub("\\[.?\\]", "", replace_escaped_quotes)
  remove_empty_brackets = gsub("\\(\\s*\\)", "", remove_square_brackets)
  remove_trailing_ws = gsub("\\s*$", "", remove_empty_brackets)
  remove_leading_ws = gsub("^\\s*", "", remove_trailing_ws)
  remove_unnecessary_ws = gsub("[ ]{2,}", " ", remove_leading_ws)
  remove_nbsp = gsub("&nbsp;", " ", remove_unnecessary_ws)
  cleaned_string = remove_nbsp
  return(cleaned_string)
}

string.trim <- function(input){
  output = gsub("\\s*$", "", input)
  output = gsub("^\\s*", "", output)
  return(output)
}

# a wrapper function to xpathSApply. which will return NA instead of zero-lenght list when nodes not found
xmlNodesValue <- function(doc, path){
  out = xpathSApply(doc, path, xmlValue, trim=T, ignoreComments=T)
  out = Filter(function(x) x!="", out)
  if (length(out) == 0) return(NA)
  out
}

# clean a string from non letteric content
cleanstrings <- function(input) {
   cleaned =  gsub("[^[:alpha:]]" ," ", input)
   return(cleaned)
}

cleanstrings_snake <- function(input) {
   cleaned =  gsub("_" ," ", input)
   return(cleaned)
}

rtematres.api.conversion.term_id <- rtematres.api.conversion.id_term <- function(given, warn = T) {
	if(is.character(given)) {
		response = rtematres.api(task = "search", argument = given)
		the_id_is = response$term_id[which(response$term == given)]
		if(length(the_id_is) == 0 && warn) warning("Sorry no such term available!")
		return(the_id_is)
	} else {
		response = rtematres.api(task = "fetchTerm", argument = given)
		the_term_is = response$term[which(response$term_id == given)]
		if(length(the_term_is) == 0 && warn) warning("Sorry no such id available!")
		return(the_term_is)
	}
}

are.we.competible <- function(package_api_version = rtematres.options("tematres_api_version"), server_api_version = rtematres.api(task = "fetchVocabularyData")$api_version) {
  if(server_api_version != package_api_version) {
    warning(paste0("This version of rtematres is compatible to api version: ", package_api_version))
    warning(paste0("But the server provides API version: ", server_api_version))
    warning(paste0("You can try to change version number of the package with rtematres.options('tematres_api_version' = xy)"))
    warning(paste0("You can try to change version number of the package to fit the server with bef.options('tematres_api_version' = xy)"))
    warning(paste0("But no guaranty that all will work properly!"))
  }
}

task.requires.api.version <- function(task_needs_version, task, server_api_version = rtematres.api(task = "fetchVocabularyData")$api_version) {
  if(server_api_version != task_needs_version) {
    stop(paste0("The task: ", task, "needs api version ", task_needs_version, "but server is at ", server_api_version))
  }
}

as.IsoDate <- function(input, return_format = F){
  if(class(input) != "character") input = as.character(input)
  input = string.empty.to_na(input)
  if(length(input) == 1) {
    dmy = FALSE
    mdy = FALSE
    string = NA

    # matches dd/mm/yyyy or dd.mm.yyyy or dd-mm-yyyy
    if(grepl("^(?:(?:31(\\/|-|\\.)(?:0?[13578]|1[02]))\\1|(?:(?:29|30)(\\/|-|\\.)(?:0?[1,3-9]|1[0-2])\\2))(?:(?:1[6-9]|[2-9]\\d)?\\d{2})$|^(?:29(\\/|-|\\.)0?2\\3(?:(?:(?:1[6-9]|[2-9]\\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))$|^(?:0?[1-9]|1\\d|2[0-8])(\\/|-|\\.)(?:(?:0?[1-9])|(?:1[0-2]))\\4(?:(?:1[6-9]|[2-9]\\d)?\\d{2})$", input)) {
      dmy = TRUE
      if(grepl("/", input)) clean_dmy = strsplit(input, split = "/")
      if(grepl("\\.", input)) clean_dmy = strsplit(input, split = "\\.")
      if(grepl("-", input)) clean_dmy = strsplit(input, split = "-")
      string = paste(unlist(clean_dmy)[c(3,2,1)], collapse = "-")
    }

    # matches mm/dd/yyyy or mm.dd.yyyy or mm-dd-yyyy
    if(grepl("^(?:(?:(?:0?[13578]|1[02])(\\/|-|\\.)31)\\1|(?:(?:0?[1,3-9]|1[0-2])(\\/|-|\\.)(?:29|30)\\2))(?:(?:1[6-9]|[2-9]\\d)?\\d{2})$|^(?:0?2(\\/|-|\\.)29\\3(?:(?:(?:1[6-9]|[2-9]\\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))$|^(?:(?:0?[1-9])|(?:1[0-2]))(\\/|-|\\.)(?:0?[1-9]|1\\d|2[0-8])\\4(?:(?:1[6-9]|[2-9]\\d)?\\d{2})$", input)) {
      mdy = TRUE
      if(grepl("/", input)) clean_mdy = strsplit(input, split = "/")
      if(grepl("\\.", input)) clean_mdy = strsplit(input, split = "\\.")
      if(grepl("-", input)) clean_mdy = strsplit(input, split = "-")
      string = paste(unlist(clean_mdy)[c(3,1,2)], collapse = "-")
    }

    if(mdy == T && dmy == T) return(NA)
    if(mdy == T && return_format == T) return("mdy")
    if(dmy == T && return_format == T) return("dmy")

    if(grepl("^(\\d{4})\\D?(0[1-9]|1[0-2])\\D?([12]\\d|0[1-9]|3[01])$", input)) {
      if(return_format){
	return("ymd")
      }
      if(grepl("/", input)) clean = strsplit(input, split = "/")
      if(grepl("\\.", input)) clean = strsplit(input, split = "\\.")
      if(grepl("-", input)) clean = strsplit(input, split = "-")
      string = paste(unlist(clean), collapse = "-")
    }

    return(string)
  } else {
    unlist(lapply(input, function(x) as.IsoDate(x, return_format = return_format)))
  }
}

is.IsoDate <- function(input) {
  if(class(input) != "character") input = as.character(input)
  if(length(input) == 1) {
    if(grepl("^(\\d{4})\\D?(0[1-9]|1[0-2])\\D?([12]\\d|0[1-9]|3[01])$", input)) {
      return(TRUE)
    } else {
      return(FALSE)
    }
  } else {
    as.logical(lapply(input, function(x) is.IsoDate(x)))
  }
}

# check for valid years
in.range.year <- function(input) {
  if(any(is.na(input))) warning("There is a few values missing in your input. I ignore them!")
  grepl("^[1-9][0-9]{3}$", input[!is.na(input)])
}

# check for valid months range
in.range.month <- function(input) {
  if(any(is.na(input))) warning("There is a few values missing in your input. I ignore them!")
  grepl("(^0?[1-9]$|^[1][0-2]$)", input)
}

# check for valid days range
in.range.day <- function(input) {
  if(any(is.na(input))) warning("There is a few values missing in your input. I ignore them!")
  grepl("(^0?[1-9]$|^[12][0-9]$|^3[01]$)", input)
}

# get year range from character vector containing years
years.to.range <- function(input){
  if(class(input) != "numeric") input = as.numeric(input)
  if(!any(in.range.year(input))) stop("Not all input has format of a valid year")
  range <- max(input) - min(input)
  return(range)
}

## String helpers

# converts empty strings in a vector to NA
string.empty.to_na <- function(input) {
  if(class(input) != "character") input = as.character(input)
  input[input == ""] <- NA
  return(input)
}

string.empty.rm <- function(input){
  if(class(input) != "character") input = as.character(input)
  input[input != ""]
}

unless.input.numeric.stop <- function(input){
  if(class(input) != "numeric") stop("This task only takes a number as input")
}


# find common concepts in character columns
setGeneric("find.common.concept", function(x) {
			  standardGeneric("find.common.concept")
})

setMethod("find.common.concept",
	  c(x = "character"),
	  function(x) {
	     upstream_concepts = sapply(x, function(x) rtematres(task = "fetchUp", term = x)$term, simplify = FALSE, USE.NAMES = TRUE)
	     common_concepts = Reduce(intersect, upstream_concepts)
	     common_concept = common_concepts[length(common_concepts)]
	     if(identical(common_concepts, character(0))) {
		return(NA)
	     } else {
		return(common_concept)
	     }
	  }
	  )

