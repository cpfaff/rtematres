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

## since version 0.2 these convenience functions are available (not on cran yet)

This functions take strings as input only for the tasks you like to perform on
them. This makes it easier to exploit the vocabulary as you do not have to
convert the term into an id indorder to use the base api functions.

```
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




