# The R package for tematres



The `rtematres` package is an api package to exploit vocabulary or formal 
representations of knowledge on any [tematres server](http://www.vocabularyserver.com/)
instance. It gives you access to the base API functions and their
documentation and offers convenient wrapper functions that ease the explotion
of the vocabolary.

### Development note:

The package is still in an early state and currently under improvement. This
might reseult in changing of function names and a high possiblity of finding an
unusable package in the master branch. If you are interested to get a currently
stable version please install from Cran.

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


#### Exploit the vocabulary 

You have access to a few convenient functions to exploit the vocabulary hosted
on your tematres vocabulary server.

* search

Search for terms by name. If you search for one letter it will list all terms
that begin with the letter. 


```r
rtematres.search("plant")
```

```
## Error: $ operator is invalid for atomic vectors
```


```r
rtematres.search("p")
```

```
## Error: $ operator is invalid for atomic vectors
```

* define

Fetches definitions from definition notes of a concept in your thesaurus.


```r
rtematres.define("plant organ")
```

```
## [1] "plant organ - a functional and structural unit of a plant"
```

* locate

To locate a certain term in its hierarchy



```r
rtematres.hierarchy("plant organ")
```

```
##  [1] "entity"        "eukaryotes"    "plant"         "plant part"   
##  [5] "plant organ"   "branch"        "flower"        "fruit"        
##  [9] "inflorescence" "leaf"          "seed"          "twig"
```

* find common concepts of factorial vectors


```r
rtematres.common(c("carbon", "nitrogen"))
```

```
## [1] "element substance"
```

* summarize vectors to concepts or create summary for
  numerics


```r
lapply(iris, function(x) rtematres.summary(x))
```

```
## $Sepal.Length
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##    4.30    5.10    5.80    5.84    6.40    7.90 
## 
## $Sepal.Width
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##    2.00    2.80    3.00    3.06    3.30    4.40 
## 
## $Petal.Length
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##    1.00    1.60    4.35    3.76    5.10    6.90 
## 
## $Petal.Width
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##     0.1     0.3     1.3     1.2     1.8     2.5 
## 
## $Species
## [1] NA
```

* broaden/narrow

Fetches broader or narrower terms for a term you provide


```r
rtematres(task = "fetchUp", term = "plant organ")
```

```
## $term
## [1] "entity"      "eukaryotes"  "plant"       "plant part"  "plant organ"
## 
## $term_id
## [1] "348" "365" "415" "436" "446"
## 
## $is.meta.term
## [1] "0" "0" "0" "0" "0"
## 
## $relation_type_id
## [1] NA
## 
## $order
## [1] "1" "2" "3" "4" "5"
```


```r
rtematres(task = "fetchDown", term = "plant organ")
```

```
## $term
## [1] "branch"        "flower"        "fruit"         "inflorescence"
## [5] "leaf"          "seed"          "twig"         
## 
## $language
## [1] NA
## 
## $term_id
## [1] "456" "447" "449" "450" "451" "454" "457"
## 
## $is.meta.term
## [1] NA
## 
## $relation_type
## [1] "NT" "NT" "NT" "NT" "NT" "NT" "NT"
## 
## $relation_code
## [1] NA
## 
## $relation_label
## [1] NA
## 
## $has_narrower_terms
## [1] "0" "1" "0" "0" "1" "0" "0"
```

## Get information 

This example uses the tematres server of the BEF-China project:

* Display server and vocabulary information:


```r
rtematres(task = "fetchVocabularyData")
```

```
## $vocabulary_id
## [1] "1"
## 
## $title
## [1] "BEFdata"
## 
## $author
## [1] "Claas-Thido Pfaff"
## 
## $language
## [1] "en"
## 
## $scope
## [1] "biology"
## 
## $keywords
## [1] "biology, ecosystem functioning, ecosystem service,"
## 
## $uri
## [1] "http://tematres.befdata.biow.uni-leipzig.de/vocab/"
## 
## $created_at
## [1] "2014-01-01"
## 
## $last_modified_at
## [1] "2014-02-06 09:30:07"
## 
## $contributors
## [1] NA
## 
## $publisher
## [1] "BEFdata"
## 
## $rights
## [1] "all rights reserved"
## 
## $count_of_terms
## [1] "1019"
## 
## $status
## [1] "available"
## 
## $server_version
## [1] "TemaTres 1.72"
## 
## $api_version
## [1] "1.4"
```

[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/cpfaff/rtematres/trend.png)](https://bitdeli.com/free "Bitdeli Badge")

