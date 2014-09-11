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

#### Base functionality

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
## [10] "plant nursery"                                
## [11] "plant organ"                                  
## [12] "plant part"                                   
## [13] "plant pollinator interaction"                 
## [14] "plant population"                             
## [15] "plant position"                               
## [16] "plant related characteristics"                
## [17] "plant secretion"                              
## [18] "plant species abundance"                      
## [19] "plant species name"                           
## [20] "plant species occurrence"                     
## [21] "plant-soil interaction"                       
## [22] "plantago lanceolata"                          
## [23] "vascular plant"
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
##  [5] "parasite"                          
##  [6] "parasitical"                       
##  [7] "parasitism"                        
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
## [29] "phylum"                            
## [30] "phytometer"                        
## [31] "phytosymbiosis"                    
## [32] "pine"                              
## [33] "planar curvature"                  
## [34] "plant"                             
## [35] "plant determination"               
## [36] "plant diversity"                   
## [37] "plant growth"                      
## [38] "plant growth state"                
## [39] "plant insect interaction"          
## [40] "plant nursery"                     
## [41] "plant organ"                       
## [42] "plant part"                        
## [43] "plant pollinator interaction"      
## [44] "plant population"                  
## [45] "plant position"                    
## [46] "plant related characteristics"     
## [47] "plant secretion"                   
## [48] "plant species abundance"           
## [49] "plant species name"                
## [50] "plant species occurrence"          
## [51] "plant-soil interaction"            
## [52] "plantago lanceolata"               
## [53] "plot"                              
## [54] "plot charts"                       
## [55] "po4"                               
## [56] "pollen"                            
## [57] "pollination"                       
## [58] "polygon"                           
## [59] "polymorphic nuclear microsatellite"
## [60] "polyphenols"                       
## [61] "population"                        
## [62] "population genetics"               
## [63] "pore volume"                       
## [64] "porosity"                          
## [65] "position"                          
## [66] "potassium"                         
## [67] "powdery mildew"                    
## [68] "precipitation"                     
## [69] "precision"                         
## [70] "predation"                         
## [71] "predation"                         
## [72] "predator abundance"                
## [73] "predator diversity"                
## [74] "predator-prey interactions"        
## [75] "predatoric"                        
## [76] "present"                           
## [77] "primary metabolites"               
## [78] "principal component analysis"      
## [79] "process"                           
## [80] "productivity"                      
## [81] "profile curvature"                 
## [82] "prokaryotes"                       
## [83] "protein"                           
## [84] "protist"                           
## [85] "protist diversity"                 
## [86] "pyrosequencing"
```

It also offers a suggestion mechanism


```r
rtematres.search("siol")
```

```
## Warning: Sorry no results for your query! Do you mean: soil
```

```
## [1] "soil"
```

* Define

Fetch definitions from definition notes of a concept in your thesaurus.


```r
rtematres.define("plant organ")
```

```
## [1] "plant organ - a functional and structural unit of a plant"
```

* Locate

Helps you locate a certain term in the hierarchy provided by the vocabulary.



```r
rtematres.hierarchy("plant organ")
```

```
##  [1] "entity"        "eukaryotes"    "plant"         "plant part"   
##  [5] "plant organ"   "branch"        "flower"        "fruit"        
##  [9] "inflorescence" "leaf"          "seed"          "twig"
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

[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/cpfaff/rtematres/trend.png)](https://bitdeli.com/free "Bitdeli Badge")
