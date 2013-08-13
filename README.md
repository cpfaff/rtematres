# rtematres

An API package to exploit vocabularies managed via a [tematres thesaurus](http://www.vocabularyserver.com/).
It gives you access to the base API functions and their documentation. Next to the base API functions
there are some convenience functions that foster exploiting the vocabulary.

## Install

### From CRAN (pending)

```
install.packages("rtematres")
```

### From github (attention may be in unstable state!)

```
# install devtools package if you don't have it.
install.packages("devtools")
# install rtematres package from github
library(devtools)
install_github(username = "cpfaff", repo = "rtematres")
```

## Set or querry options

* List options

`rtematres.options()`

* Set tematres url

`rtematres.options("tematres_url" = "http://url.to/your/tematres/server")`
`rtematres.options("tematres_service_url" = "http://url.to/your/tematres/server/api")`

## base API tasks

```
rtematres.api(task = "availableTasks")
rtematres.api(task = "suggest", argument = "measurement")
rtematres.api(task = "suggestDetails", argument = "measurement")
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
```

## helper

```
rtematres.api.conversion.key_id(given = 12)
rtematres.api.conversion.id_key(given = "Location")
```

## Convenience functions

```
rtematres.api.define(term = "Context")
rtematres.api.search(term = "Location")
rtematres.api.search(term = "Location", task="fetchUp")
rtematres.api.search(term = "Location", task="fetchDown")
```




