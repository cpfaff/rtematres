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
install_github(username = "cpfaff", repo = "rtematres", subdir = "rtematres")
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


#### Exploit the knowledge

You can get a list of tasks their descriptions and arguments they take using
the command below.

```
rtematres.api.do(task = "availableTasks")
```

To exploit the vocabulary you can issue one of the tasks in the list below. If
the task takes multiple terms you need to concatenate the strings in R typical
manner with `c("term one", "term two")`.

```
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

#### Helper

```
rtematres.api.conversion.id_term(given = 20 )
```

The option name is `given` as it also handles the reverse case. You can do the
following to get the id for a term:

```
rtematres.api.conversion.id_term(given = "Contex")
```

This reverse case also has its own alias to the function. This feels
semantically more native when writing and reading code.

```
rtematres.api.conversion.term_id(given = "Contex")
```


[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/cpfaff/rtematres/trend.png)](https://bitdeli.com/free "Bitdeli Badge")

