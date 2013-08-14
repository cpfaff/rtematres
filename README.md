# The R package for tematres 

The `rtematres` package is an api package to exploit formal representations of knowledge 
hosted on any [tematres server](http://www.vocabularyserver.com/) instance.
It gives you access to the base API functions and their documentation and offers convenient
wrapper functions that ease the explotion of the vocabolary.

### Install

#### From CRAN

Find the package and manual on [CRAN](http://cran.r-project.org/web/packages/rtematres/index.html). You 
can simply install the version hosted there issuing the command below:

```
install.packages("rtematres")
```

#### From github 

The installation from Github requires the `devtools` package.

```
# install devtools:
install.packages("devtools")
# install rtematres:
library(devtools)
install_github(username = "cpfaff", repo = "rtematres")
```

### Usage

#### Load the package

After installation load the package: 

```
library(rtematres)
```

#### Options

* List options

`rtematres.options()`

* Set options

`rtematres.options("tematres_url" = "http://url.to/your/tematres/server")`
`rtematres.options("tematres_service_url" = "http://url.to/your/tematres/server/api")`

Note: `tematres_url` is informative only atm but you need to set the url in `tematres_service_ur` 
to the `services.php` of the tematres server. This is the the access to the api.

### Base API tasks

Below you find the base api tasks. As you can see some of them only take ids of terms. As you 
usually not know the id of a term as the term is what you are looking there are convenience 
functions that will be introduce with version 0.2 (see below). 

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

If you like to use these functions you need to convert terms to ids manually using the helper
also included in the `rtematres` package.

```
rtematres.api.conversion.id_term(given = 20 )
```

The option name is `given` as it also handles the reverse case. You can do the following to 
get the id for a term:

```
rtematres.api.conversion.id_term(given = "Contex")
```

This reverse case also has its own alias to the function. This feels semantically
more native when writing and reading your codee.


```
rtematres.api.conversion.term_id(given = "Contex")
```


## Version 0.2

Will offer more convenience but is not on CRAN yet.This functions take strings
as input only for the tasks you like to perform on
them. This makes it easier to exploit the vocabulary as you do not have to
convert the term into an id in dorder to use the base api functions.

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

## Other convenience functions 

These will be remove in the next version of the package as the functions 
above completely cover this stuff.

```
rtematres.api.define(term = "Context")
rtematres.api.search(term = "Location")
rtematres.api.search(term = "Location", task="fetchUp")
rtematres.api.search(term = "Location", task="fetchDown")
```




