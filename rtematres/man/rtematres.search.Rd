% Generated by roxygen2 (4.0.2): do not edit by hand
\name{rtematres.search}
\alias{rtematres.search}
\title{Search for concepts}
\usage{
rtematres.search(term, includenotes = FALSE)
}
\arguments{
\item{term}{The concept you are looking for}

\item{includenotes}{Include definition texts in the search (true, false). Note
that one is only working for searches containing > 2 characters.
otherwise it is just ignored.}
}
\value{
The function returns a vecor or a list of results for the search
}
\description{
Search the thesaurus for concepts. This function is a wrapper and so it
calls the appropriate funtions depending on the search task.
}

