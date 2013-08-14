\name{rtematres.api}
\alias{rtematres.api}
\title{Basic tematres server api}
\usage{
  rtematres.api(task = "availableTasks", argument)
}
\arguments{
  \item{task}{The api task you like to execute. Use the the
  "availableTasks" to get an overview about the base api.
  It returns a data frame with descriptions and the
  arguments for the tasks.}

  \item{argument}{Is the argument for the api task. You
  find the information about the arguments when you call
  the task "availableTasks".}
}
\value{
  The function returns either a dataframe for information
  or a list of keywords and ids
}
\description{
  Basic tematres server api
}
\examples{
\dontrun{
    rtematres.api(task = "availableTasks")
    rtematres.api(task = "fetchVocabularyData")
    rtematres.api(task = "fetchTopTerms")
    rtematres.api(task = "search", argument = "measurement")
    rtematres.api(task = "letter", argument = "t")
    rtematres.api(task = "fetchTerm", argument = 12)
    rtematres.api(task = "fetchDown", argument = 4 )
    rtematres.api(task = "fetchUp", argument = 4)
    rtematres.api(task = "fetchRelated", argument = 4)
    rtematres.api(task = "fetchAlt", argument = 12 )
    rtematres.api(task = "fetchCode", argument = "tree")
    rtematres.api(task = "fetchNotes", argument = 5 )
    rtematres.api(task = "fetchDirectTerms", argument = 12)
    rtematres.api(task = "fetchURI", argument = 12)
    rtematres.api(task = "fetchTargetTerms", argument = 12 )
    rtematres.api(task = "fetchSourceTerm", argument = 12)
    rtematres.api(task = "fetchTerms", argument = '12,13' )
    rtematres.api(task = "fetchRelatedTerms", argument = '12,13' )
    rtematres.api(task = "fetchSimilar", argument = 12)
    rtematres.api(task = "fetchLast")
    rtematres.api.conversion.keyword_id(given = "Measurement")
    rtematres.api.conversion.keyword_id(given = 8)
 }
}

