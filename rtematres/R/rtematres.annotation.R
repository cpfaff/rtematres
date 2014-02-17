#' This is the annotation features provided by rtematres

#' You can annotate and clean datasets base on a tematres 
#' thesaurus. 

base.find.common.concept <- function(input) {
   if(is.list(input)){
      maximum_length = max(sapply(input, function(x) length(x), USE.NAMES=F))
      input = data.frame(sapply(input, function(x) c(x, rep(NA, maximum_length - length(x)))))
   } 
   for(i in 1:nrow(input)){
      if(length(unique(as.character(unlist(input[i,])))) > 1) {
	 return(unique(as.character(unlist(input[i-1,]))))
   }
}
}

#' @export find.common.concept

find.common.concept <- function(input) {
   if(identical(base.find.common.concept(input),character(0))) warning("Sorry no common concept found here! Check your column for consitency!") else return(base.find.common.concept(input))
}
