\docType{package}
\name{rtematres}
\alias{rtematres}
\alias{rtematres-package}
\title{rtematres A package to exploit controlled vocabularies from tematres servers}
\usage{
rtematres(task, verbose = F, term, includenotes = F)
}
\arguments{
  \item{task}{The api task you like to execute. Use the the
  "availableTasks" to get an overview about the base api.
  It returns a data frame with descriptions and the
  arguments for the tasks.}

  \item{term}{Is the term(s) you like to execute the task
  for.}

  \item{verbose}{Either true of false and determines the
  ammount of info that is returned by a query.}
}
\value{
The function returns either a dataframe for information or
a list of keywords and ids
}
\description{
rtematres A package to exploit controlled vocabularies from
tematres servers

As some of the task of the base api only take ids the
wrapper does a conversion from a term to the id to
communicate with the server. So you can use terms in all
taks with this function.
}
\examples{
\dontrun{
    rtematres(task = "availableTasks")
    rtematres(task = "fetchVocabularyData")
    rtematres(task = "suggest", term = "measurement")
    rtematres(task = "suggestDetails", term = "measurement")
    rtematres(task = "fetchTopTerms")
    rtematres(task = "search", term = "measurement")
    rtematres(task = "letter", term = "t")
    rtematres(task = "fetchTerm", term = "tree")
    rtematres(task = "fetchTerms", term = c("Context", "tree") )
    rtematres(task = "fetchDown", term = "Context")
    rtematres(task = "fetchUp", term = "measurement")
    rtematres(task = "fetchRelated", term = "tree")
    rtematres(task = "fetchAlt", term = "tree" )
    rtematres(task = "fetchCode", term = "tree")
    rtematres(task = "fetchNotes", term = "Context")
    rtematres(task = "fetchDirectTerms", term = "carbon")
    rtematres(task = "fetchURI", term = "carbon")
    rtematres(task = "fetchTargetTerms", term = "carbon")
    rtematres(task = "fetchSourceTerm", term = "Context")
    rtematres(task = "fetchRelatedTerms", term = c("Context", "tree"))
    rtematres(task = "fetchSimilar", term = "tree")
    rtematres(task = "fetchLast")
  }
}

