# This is the annotation features provided by rtematres

content.find.concept <- function(input) {
   # handles data frame in a loop
   if(class(input) %in% c("list", "data.frame")) {
      return(sapply(input, function(x) content.find.concept(x)))
   }

   # as we do not handle numeric content return NA 
   if(class(input) %in% c("numeric", "integer")) return(NA)
   
   # rest handles single column input  
   if(class(input) == "factor") {
      input = as.character(input)
   }
   
   # if input non numeric 
   if(class(input) == "character") {

      unique_terms = as.character(unique(input))
      broader_terms = sapply(unique_terms, function(x) rtematres(task="broaden", term = x)) 
   
      # fixme: not properly handled atm
      if(class(broader_terms) == "logical") {
	 return(NA)
      }

      if(class(broader_terms) == "list") {
	 maxlen <- max(sapply(broader_terms,length))
	 broader_terms = data.frame(lapply(broader_terms , function(x,len){ x[1:len] } , len=maxlen))
      }
      
      # remove all na only columns
      broader_terms = broader_terms[ , ! apply( broader_terms , 2 , function(x) all(is.na(x)) ) ]

      for(i in 1:nrow(broader_terms)) {
	 if(length(unique(as.character(unlist(broader_terms[i,])))) > 1) {
	    decision = (unique(as.character(unlist(broader_terms[i-1,]))))
	 }
      }
      return(decision[1])
   } 
}

header.find.concept <- function(input) {
   if(class(input) %in% c("list", "data.frame")) {
      input = names(input)
   }
   if(!is.character(input)) {
      input = as.character(input) 
   }
   input = tolower(input)
   input = cleanstrings(input)
   broader_terms = lapply(input, function(x) rtematres(task="broaden", term=x))
   return(unlist(lapply(broader_terms, function(x) x[1])))
}

#' This is the annotation features provided by rtematres

#' @param input to be annotated 

#' You can semantically annotate data frames base on a tematres 
#' thesaurus. 

#' @export annotate.dataframe 
annotate.dataframe <- function(input) {
   if(class(input) == "list") {
    input = as.data.frame(input)
   }

   column_classes = sapply(input, class)
   concepts_body = content.find.concept(input)
   definitions_body = lapply(concepts_body, function(x) rtematres(task="define", term=x))
   concepts_header = header.find.concept(input)
   definitions_header = lapply(names(input), function(x) rtematres(task="define", term=x))

   annotation = list("column_classes" = column_classes,
		     "concepts_body" = concepts_body, 
		     "definitions_body" = definitions_body,
		     "concepts_header" = concepts_header,
		     "definitions_header" = definitions_header)
   annotation = do.call(cbind, annotation)
   # class(annotation) <- "annotation"
   return(annotation)
}


#' @export annotate.dataframe 
annotate.dataframe.clean <- function(input) {
   if(class(input) == "list") {
    input = as.data.frame(input)
   }
   column_classes = sapply(input, class)
   
   input = as.data.frame(lapply(input, cleanstrings_snake))

   concepts_body = content.find.concept(input)
   definitions_body = lapply(concepts_body, function(x) rtematres(task="define", term=x))
   concepts_header = header.find.concept(input)
   definitions_header = lapply(names(input), function(x) rtematres(task="define", term=x))

   annotation = list("column_classes" = column_classes,
		     "concepts_body" = concepts_body, 
		     "definitions_body" = definitions_body,
		     "concepts_header" = concepts_header,
		     "definitions_header" = definitions_header)
   annotation = do.call(cbind, annotation)
   # class(annotation) <- "annotation"
   return(annotation)
}


