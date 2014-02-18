#' This is the annotation features provided by rtematres

#' You can semantically annotate datasets base on a tematres 
#' thesaurus. 

base.find.common.concept <- function(input) {
   if(class(input) == "numeric") return("numeric")
   if(class(input) %in% c("factor", "character")) {
      unique_terms = as.character(unique(input))
      broader_terms = sapply(unique_terms, function(x) rtematres(task="broaden", term = x)) 
      if(class(broader_terms) == "list") {
	 maxlen <- max(sapply(broader_terms,length))
	 broader_terms = data.frame(lapply(broader_terms , function(x,len){ x[1:len] } , len=maxlen))
      }
      for(i in 1:nrow(broader_terms)){
	 if(length(unique(as.character(unlist(broader_terms[i,])))) > 1) {
	    decision = (unique(as.character(unlist(broader_terms[i-1,]))))
	 }
      }
      return(decision[1])
   }
}

annotate.dataframe <- function(dataframe) {
   concepts = lapply(dataframe, function(x) base.find.common.concept(x))
   definitions = lapply(concepts, function(x) rtematres(task="define", term=x))
   annotation = list(concecpts=concepts, 
		     definitions=definitions)
   return(do.call(cbind, annotation))
}
