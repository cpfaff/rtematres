\name{rtematres.api.conversion.term_id}
\alias{rtematres.api.conversion.term_id}
\title{An tematres api helper that converts ids to strings and vise versa}
\usage{
  rtematres.api.conversion.term_id(given, warn = T)
}
\arguments{
  \item{given}{Either a term or an integer id for a term}

  \item{warn}{Give a waring when the term/id is not found.
  Defaults to TRUE.}
}
\value{
  Either a string or id
}
\description{
  As the tematres api accepts ids of terms only on most of
  its tasks this is a small helper that converts them into
  each other. It has two function names tha you can use
  depending on what you are converting. But both function
  names do the same so they can be exchanged.
  (rtematres.api.conversion.[term_id/id_term])
}

