\name{rtematres.options}
\alias{rtematres.options}
\title{Set or query otions related to the rtematresdata R package.}
\usage{
  rtematres.options(...)
}
\arguments{
  \item{\dots}{similar to \code{\link{options}}. see
  examples below.}
}
\description{
  This function is used to query and set the options used
  by the rtematres package. For example you can set the
  URLs to your tematres server and the API.
}
\examples{
#Tematres URLs
rtematres.options('tematres_url')
rtematres.options(tematres_url="http://www.example.com")
}

