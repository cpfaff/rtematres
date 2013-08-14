\name{rtematres.api.do}
\alias{rtematres.api.do}
\title{A convenient wrapper to all tasks of the base api.}
\usage{
  rtematres.api.do(task = "availableTasks", term)
}
\arguments{
  \item{task}{The api task you like to execute. Use the the
  "availableTasks" to get an overview about the base api.
  It returns a data frame with descriptions and the
  arguments for the tasks.}

  \item{term}{Is the term(s) you like to execute the task
  for.}
}
\value{
  The function returns either a dataframe for information
  or a list of keywords and ids
}
\description{
  As some of the task of the base api only take ids the
  wrapper does a conversion from a term to the id to
  communicate with the server. So you can use terms in all
  taks with this function.
}
\examples{
\dontrun{
    rtematres.api.do(task = "availableTasks")
    rtematres.api.do(task = "fetchVocabularyData")
    rtematres.api.do(task = "suggest", term = "measurement")
    rtematres.api.do(task = "suggestDetails", term = "measurement")
    rtematres.api.do(task = "fetchTopTerms")
    rtematres.api.do(task = "search", term = "measurement")
    rtematres.api.do(task = "letter", term = "t")
    rtematres.api.do(task = "fetchTerm", term = "tree")
    rtematres.api.do(task = "fetchTerms", term = c("Context", "tree") )
    rtematres.api.do(task = "fetchDown", term = "Context")
    rtematres.api.do(task = "fetchUp", term = "measurement")
    rtematres.api.do(task = "fetchRelated", term = "tree")
    rtematres.api.do(task = "fetchAlt", term = "tree" )
    rtematres.api.do(task = "fetchCode", term = "tree")
    rtematres.api.do(task = "fetchNotes", term = "Context")
    rtematres.api.do(task = "fetchDirectTerms", term = "carbon")
    rtematres.api.do(task = "fetchURI", term = "carbon")
    rtematres.api.do(task = "fetchTargetTerms", term = "carbon")
    rtematres.api.do(task = "fetchSourceTerm", term = "Context")
    rtematres.api.do(task = "fetchRelatedTerms", term = c("Context", "tree"))
    rtematres.api.do(task = "fetchSimilar", term = "tree")
    rtematres.api.do(task = "fetchLast")
  }
}

