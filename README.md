# The R package for TemaTres



The `rtematres` package allows to exploit vocabularies hosted on any instance
of the [TemaTres vocabulary server](http://www.vocabularyserver.com/). It gives
you access to the base API functions of the server and their documentation as
well as it offers convenient wrapper functions that ease the access to the
vocabulary.

### Development note:

The package is in an active development state. This might result in changes of
function names and you might also find the source in master in an unusable
state. If you are interested in a stable version please install the package
using the CRAN repository.

### Install

#### From CRAN

Find the package including manual on
[CRAN](http://cran.r-project.org/web/packages/rtematres/index.html). You can
simply install the version hosted there issuing the command below:

```
install.packages("rtematres")
```

#### From github

The installation from GitHub requires the `devtools` package.

```
# install devtools:
install.packages("devtools")
# install rtematres:
require(devtools)
install_github("cpfaff/rtematres", subdir = "rtematres") 
require(rtematres)
```

### Usage

#### Load the package

After installation load the package:

```
library(rtematres)
```

#### Options

* List options


```r
rtematres.options()
```

```
## $tematres_service_url
## [1] "http://tematres.befdata.biow.uni-leipzig.de/vocab/services.php"
## 
## $package_api_version
## [1] "1.4"
## 
## $server_api_version
## [1] NA
```

As you can see there is various fields in the list you can change these simply
calling the function with the field names to change assigning new values.

* Set options



You need to set the `tematres_service_url` to point to the `service.php` as the
this is the access point to the API.

`rtematres.options("tematres_service_url" = "http://url.to/your/tematres/server/api/service.php")`


#### Get information 

This example uses the TemaTres server of the BEF-China project:

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
## [1] NA
## 
## $keywords
## [1] NA
## 
## $uri
## [1] "http://tematres.befdata.biow.uni-leipzig.de/vocab/"
## 
## $created_at
## [1] "2014-09-16"
## 
## $last_modified_at
## [1] "2014-09-16 21:50:52"
## 
## $contributors
## [1] NA
## 
## $publisher
## [1] NA
## 
## $rights
## [1] NA
## 
## $count_of_terms
## [1] "946"
## 
## $status
## [1] "available"
## 
## $server_version
## [1] "TemaTres 1.8"
## 
## $api_version
## [1] "1.5"
```

#### Base functionality

* broaden/narrow

Fetches broader or narrower terms for a term you provide


```r
rtematres(task = "fetchUp", term = "plant organ")
```

```
## [1] "entity"      "eukaryotes"  "plant"       "plant part"  "plant organ"
```


```r
rtematres(task = "fetchDown", term = "plant organ")
```

```
## [1] "branch"        "flower"        "fruit"         "inflorescence"
## [5] "leaf"          "root"          "seed"          "stem"         
## [9] "twig"
```

And many more tasks are supported....




```
##  [1] "fetchVocabularyData" "fetchTopTerms"       "search"             
##  [4] "fetch"               "searchNotes"         "suggest"            
##  [7] "suggestDetails"      "fetchCode"           "letter"             
## [10] "fetchTerm"           "fetchAlt"            "fetchDown"          
## [13] "fetchUp"             "fetchRelated"        "fetchNotes"         
## [16] "fetchDirectTerms"    "fetchURI"            "fetchTargetTerms"   
## [19] "fetchSourceTerms"    "fetchTerms"          "fetchRelatedTerms"  
## [22] "fetchSimilar"        "fetchLast"
```

#### Higher order functions 

You have access to a few convenient functions to exploit the vocabulary hosted
on your TemaTres vocabulary server.

* Search

Search for terms by name. 


```r
rtematres.search("plant")
```

```
##  [1] "plant"                                        
##  [2] "herbal plant species abundance in late summer"
##  [3] "host plant finding"                           
##  [4] "perennial plant"                              
##  [5] "plant determination"                          
##  [6] "plant diversity"                              
##  [7] "plant growth"                                 
##  [8] "plant growth state"                           
##  [9] "plant insect interaction"                     
## [10] "plant organ"                                  
## [11] "plant part"                                   
## [12] "plant pollinator interaction"                 
## [13] "plant population"                             
## [14] "plant position"                               
## [15] "plant related characteristics"                
## [16] "plant secretion"                              
## [17] "plant species abundance"                      
## [18] "plant species name"                           
## [19] "plant species occurrence"                     
## [20] "plant-soil interaction"                       
## [21] "plantago lanceolata"                          
## [22] "vascular plant"
```

If you search for one letter only it will list all terms that begin with the
letter.


```r
rtematres.search("p")
```

```
##  [1] "p fraction"                        
##  [2] "P: biotop"                         
##  [3] "P: ecoregion"                      
##  [4] "P: habitat"                        
##  [5] "P: subplots"                       
##  [6] "parasite"                          
##  [7] "parasitical"                       
##  [8] "parasitoid abundance"              
##  [9] "parasitoids olfactory orientation" 
## [10] "parent"                            
## [11] "pastures"                          
## [12] "pathogen"                          
## [13] "pcr"                               
## [14] "peat"                              
## [15] "pellet counting"                   
## [16] "pellet decay"                      
## [17] "perennial plant"                   
## [18] "performance"                       
## [19] "peroxidase"                        
## [20] "pH"                                
## [21] "phase or state of matter"          
## [22] "phenology"                         
## [23] "phosphate"                         
## [24] "phosphorous"                       
## [25] "photosynthetic performance"        
## [26] "phyllosphere"                      
## [27] "phylogenetic distinctness"         
## [28] "phylogenetic diversity"            
## [29] "phytometer"                        
## [30] "phytosymbiosis"                    
## [31] "pine"                              
## [32] "planar curvature"                  
## [33] "plant"                             
## [34] "plant determination"               
## [35] "plant diversity"                   
## [36] "plant growth"                      
## [37] "plant growth state"                
## [38] "plant insect interaction"          
## [39] "plant organ"                       
## [40] "plant part"                        
## [41] "plant pollinator interaction"      
## [42] "plant population"                  
## [43] "plant position"                    
## [44] "plant related characteristics"     
## [45] "plant secretion"                   
## [46] "plant species abundance"           
## [47] "plant species name"                
## [48] "plant species occurrence"          
## [49] "plant-soil interaction"            
## [50] "plantago lanceolata"               
## [51] "plot"                              
## [52] "plot charts"                       
## [53] "po4"                               
## [54] "pollen"                            
## [55] "pollination"                       
## [56] "polygon"                           
## [57] "polymorphic nuclear microsatellite"
## [58] "polyphenols"                       
## [59] "population"                        
## [60] "population genetics"               
## [61] "pore volume"                       
## [62] "porosity"                          
## [63] "position"                          
## [64] "potassium"                         
## [65] "powdery mildew"                    
## [66] "precipitation"                     
## [67] "precision"                         
## [68] "predation"                         
## [69] "predator abundance"                
## [70] "predator diversity"                
## [71] "predator-prey interactions"        
## [72] "predatoric"                        
## [73] "present"                           
## [74] "primary metabolites"               
## [75] "principal component analysis"      
## [76] "process"                           
## [77] "productivity"                      
## [78] "profile curvature"                 
## [79] "prokaryotes"                       
## [80] "protein"                           
## [81] "protist"                           
## [82] "protist diversity"                 
## [83] "pyrosequencing"
```

It also offers a suggestion mechanism


```r
rtematres.search("siol")
```

```
## Warning: Sorry no results for your query! Do you mean: diel
```

```
## [1] "diel"
```

* Define

Fetch definitions from definition notes of a concept in your thesaurus.


```r
rtematres.define("plant organ")
```

```
## Warning: Sorry no definition for your term found!
```

* Locate

Helps you locate a certain term in the hierarchy provided by the vocabulary.



```r
rtematres.hierarchy("plant organ")
```

```
##  [1] "entity"        "eukaryotes"    "plant"         "plant part"   
##  [5] "plant organ"   "branch"        "flower"        "fruit"        
##  [9] "inflorescence" "leaf"          "root"          "seed"         
## [13] "stem"          "twig"
```

* Find common concepts

It takes factorial vectors and queries the vocabulary for their hierarchy.
Then it displays the common concept of the both therms if there is any.


```r
rtematres.common(c("carbon", "nitrogen"))
```

```
## [1] "element substance"
```

* Summarize vectors 
  
If you provide this function with a numeric vector it will calculate a 5 value
summary and for categorical, character vectors find the common concept.

> This is the first step towards a higher order annotation and metadata creation
> feature.


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

* Information summary 

A wrapper to aggregate multiple calls for information on a single term 



```r
rtematres.illuminate("nitrogen fixation")
```

```
## $concept_definition
## [1] NA
## 
## $upstream_concepts
## [1] "entity"            "process"           "nitrogen fixation"
## 
## $downstream_concepts
## NULL
## 
## $direct_related_concepts
## NULL
```


[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/cpfaff/rtematres/trend.png)](https://bitdeli.com/free "Bitdeli Badge")
