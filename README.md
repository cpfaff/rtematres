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

Search for terms by name. You can also include the notes in your search. This
will provide you with terms mentioning the search term in their definition.  If
you search for one letter it will list all terms that begin with the letter.


```r
rtematres(task = "search", term = "plant")
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



```r
rtematres(task = "search", term = "plant organ", includenotes = T)
```

```
## [1] "plant organ"   "crown"         "tree"          "litter"       
## [5] "plant nursery"
```



```r
rtematres(task = "search", term = "p")
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


* define

Fetches definitions from definition notes of a concept in your thesaurus.


```r
rtematres(task = "define", term = "plant organ")
```

```
## [1] NA
```


* broaden/narrow

Fetches broader or narrower terms for a term you provide


```r
rtematres(task = "broaden", term = "plant organ")
```

```
## [1] NA
```



```r
rtematres(task = "narrow", term = "plant organ")
```

```
## [1] NA
```


#### Helper

* convert a term to the index id of your term in your thesaurus


```r
rtematres.api.conversion.term_id(given = "plant organ")
```

```
## [1] NA
```


## Get information 

This example uses the tematres server of the BEF-China project:

* Display server and vocabulary information:


```r
rtematres.api(task = "fetchVocabularyData")
```

```
## $author
## [1] "Claas-Thido Pfaff"
## 
## $title
## [1] "BEFdata"
## 
## $language
## [1] "en"
## 
## $uri
## [1] "http://tematres.befdata.biow.uni-leipzig.de/vocab/"
## 
## $contributor
## [1] NA
## 
## $publisher
## [1] "BEFdata"
## 
## $rights
## [1] "all rights reserved"
## 
## $creation_date
## [1] "2014-01-01"
## 
## $last_modified
## [1] "2014-02-06 09:30:07"
## 
## $count_terms
## [1] "992"
## 
## $status
## [1] "available"
## 
## $api_version
## [1] "1.3"
```


## Annotate data frames

* Example 


```r
tree <- c(1, 2, 3, 4, 5, 6, 7, 8, 9)
plantorgan <- c("branch", "flower", "fruit", "inflorescence", "leaf", "seed", 
    "twig", "branch", "leaf")
species <- c("acer platanum", "fagus sylvatica", "betula pendula", "acer platanum", 
    "fagus sylvatica", "fagus sylvatica", "fagus sylvatica", "Viburnum sempervirens", 
    "lala pubescens")
myframe <- data.frame(tree = tree, `plant organ` = plantorgan, `species names` = species)
annotate.dataframe(myframe)
```

```
##               column_classes concepts_body definitions_body
## tree          "numeric"      NA            "NA"            
## plant.organ   "factor"       NA            "NA"            
## species.names "factor"       NA            "NA"            
##               concepts_header definitions_header
## tree          NA              "NA"              
## plant.organ   NA              "NA"              
## species.names NA              "NA"
```




[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/cpfaff/rtematres/trend.png)](https://bitdeli.com/free "Bitdeli Badge")

