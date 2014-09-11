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
rtematres.search(term = "plant")
```

```
## $term
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
## 
## $term_id
##  [1] "415" "249" "647" "421" "889" "334" "662" "85"  "654" "975" "446"
## [12] "436" "655" "547" "39"  "131" "664" "248" "2"   "83"  "656" "6"  
## [23] "419"
## 
## $is.meta.term
## [1] NA
## 
## $no_term_string
## [1] NA
## 
## $index
##  [1] "|348|365|415"         "|187|233|241|249"     "|627|647"            
##  [4] "|348|365|415|421"     "|761|806|888|889"     "|187|330|334"        
##  [7] "|627|662"             "|1|84|85"             "|627|649|654"        
## [10] "|348|495|975"         "|348|365|415|436|446" "|348|365|415|436"    
## [13] "|627|649|655"         "|348|546|547"         "|1|950|35|39"        
## [16] "|1|131"               "|627|663|664"         "|187|233|241|248"    
## [19] "|1|2"                 "|1|82|83"             "|627|649|656"        
## [22] "|1|2|6"               "|348|365|415|419"    
## 
## $order
##  [1] "1"  "2"  "3"  "4"  "5"  "6"  "7"  "8"  "9"  "10" "11" "12" "13" "14"
## [15] "15" "16" "17" "18" "19" "20" "21" "22" "23"
```


```r
rtematres.search(term = "p")
```

```
## $term
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
## 
## $term_id
##  [1] "281" "598" "600" "601" "353" "118" "972" "252" "556" "129" "518"
## [12] "500" "909" "624" "238" "634" "421" "79"  "683" "285" "159" "873"
## [23] "697" "748" "80"  "597" "512" "341" "998" "767" "488" "10"  "50" 
## [34] "415" "889" "334" "662" "85"  "654" "975" "446" "436" "655" "547"
## [45] "39"  "131" "664" "248" "2"   "83"  "656" "6"   "863" "859" "698"
## [56] "437" "665" "860" "620" "702" "546" "913" "295" "166" "35"  "736"
## [67] "413" "307" "300" "667" "973" "245" "335" "657" "121" "15"  "687"
## [78] "857" "627" "104" "49"  "357" "699" "369" "344" "914"
## 
## $is.meta.term
##  [1] "0" "0" "0" "0" "0" "0" "0" "0" "0" "0" "0" "0" "0" "0" "0" "0" "0"
## [18] "0" "0" "0" "0" "0" "0" "0" "0" "0" "0" "0" "0" "0" "0" "0" "0" "0"
## [35] "0" "0" "0" "0" "0" "0" "0" "0" "0" "0" "0" "0" "0" "0" "0" "0" "0"
## [52] "0" "0" "0" "0" "0" "0" "0" "0" "0" "0" "0" "0" "0" "0" "0" "0" "0"
## [69] "0" "0" "0" "0" "0" "0" "0" "0" "0" "0" "0" "0" "0" "0" "0" "0" "0"
## [86] "0"
## 
## $no_term_string
## [1] NA
## 
## $relation_type_id
## [1] NA
```

* define

Fetches definitions from definition notes of a concept in your thesaurus.


```r
rtematres.define("plant organ")
```

```
## $term
## [1] "plant organ"
## 
## $term_id
## [1] "446"
## 
## $note_id
## [1] "13"
## 
## $note_type
## [1] "DF"
## 
## $note_language
## [1] "en"
## 
## $note_text
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


```r
rtematres.summary(iris)
```

```
## Error: object 'return_value' not found
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

