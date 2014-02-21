# clean html strings 

clean_html_string <- function(string) {
  remove_tags = gsub("<.*?>", "", string)
  remove_newlines = gsub("\\n"," ",remove_tags)
  replace_escaped_quotes = gsub("\"", "'", remove_newlines)
  remove_square_brackets = gsub("\\[.?\\]", "", replace_escaped_quotes)
  remove_empty_brackets = gsub("\\(\\s*\\)", "", remove_square_brackets)
  remove_trailing_ws = gsub("\\s*$", "", remove_empty_brackets)
  remove_leading_ws = gsub("^\\s*", "", remove_trailing_ws)
  remove_unnecessary_ws = gsub("[ ]{2,}", " ", remove_leading_ws)
  cleaned_string = remove_unnecessary_ws
  return(cleaned_string)
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


rtematres.api.conversion.term_id <- rtematres.api.conversion.id_term <- function(given) {
  if(is.character(given)) {
    the_id_is = rtematres.api(task = "fetch", argument = given)$term_id
    return(the_id_is)
  } else {
    the_term_is = rtematres.api(task = "fetchTerms", argument = given)$term
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

