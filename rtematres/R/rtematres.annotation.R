#' This is the annotation features provided by rtematres

#' You can semantically annotate datasets base on a tematres 
#' thesaurus. 

content.find.common.concept <- function(input, showbroader = F) {
   # handles data frame in a loop
   if(class(input) %in% c("list", "data.frame")) {
      return(sapply(input, function(x) content.find.common.concept(x)))
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
   broader_terms = lapply(input, function(x) rtematres(task="broaden", term=x))
   return(unlist(lapply(broader_terms, function(x) x[1])))
}

#' @export annotate.dataframe
annotate.dataframe <- function(input) {
   concepts = content.find.common.concept(input)
   definitions = lapply(concepts, function(x) rtematres(task="define", term=x))
   classes = lapply(input, class)
   annotation = list(class = classes,
		     concecpts = concepts, 
		     definitions = definitions)
   annotation = do.call(cbind, annotation)
   # class(annotation) <- "annotation"
   return(annotation)
}
