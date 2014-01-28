context("Test all base api tasks")

# test_that("We are competible with API")
# FIXME: Apis change so make the package work with a certain api version and warn if server and package might not be competible

test_that("We can fetch the available tasks", {
	expect_that(rtematres.api(task = "availableTasks"), is_a('data.frame'))
})

test_that("We can fetch information about the vocabulary", {
	expect_that(rtematres.api(task = "fetchVocabularyData"), is_a('list')) 
	# and
	expect_that(names(rtematres.api(task = "fetchVocabularyData")), equals(c("author", "title", "language", "uri", "lastMod", "count_terms", "status")))
})

test_that("We can fetch a list of last modified terms", {
	expect_that(rtematres.api(task = "fetchLast"), is_a('list'))	 
	# and
	expect_that(names(rtematres.api(task = "fetchLast")), equals('term'))	
})

test_that("We can fetch alternative non preferred terms", {
	expect_that(rtematres.api(task = "fetchAlt", argument = 1), is_a('list'))
	# and
	expect_that(names(rtematres.api(task = "fetchAlt", argument = 1)), equals('term'))	
})

test_that("We can fetch terms based on string matching", {
	expect_that(rtematres.api(task = "suggest", argument = "a"), is_a('list'))
	# and
	expect_that(names(rtematres.api(task = "suggest", argument = "bio")), equals('term'))	
})

test_that("We can fetch alternative, related and direct hieraquical terms", {
	expect_that(rtematres.api(task = "fetchDirectTerms", argument = 1), is_a('list'))
	# and
	expect_that(names(rtematres.api(task = "fetchDirectTerms", argument = 1)), equals(c('term', 'relation')))	
})

test_that("We can fetch down the hirarchy", {
	expect_that(rtematres.api(task = "fetchDown", argument = 1), is_a('list'))	        
	# and
	expect_that(names(rtematres.api(task = "fetchDown", argument = 1)), equals('term'))	
})

test_that("We can fetch up the hirarchy", {
	expect_that(rtematres.api(task = "fetchUp", argument = 1), is_a('list'))	        
	# and
	expect_that(names(rtematres.api(task = "fetchUp", argument = 1)), equals('term'))	
})


test_that("We can fetch notes or descriptions for a term", {
	expect_that(rtematres.api(task = "fetchNotes", argument = 1), is_a('list')) 
	# and
	expect_that(names(rtematres.api(task = "fetchNotes", argument = 1)), equals(c('id', 'term', 'language', 'description')))	
})

test_that("We can fetch related terms for a id ", {
	expect_that(rtematres.api(task = "fetchRelated", argument = 1), is_a('list'))
	# and
	expect_that(names(rtematres.api(task = "fetchRelated", argument = 1)), equals('term'))	
})

# FIXME:
# test_taht("We can fetch related terms for multiple ids")

# NOTE: here the api is not very consistent as the name of the task is letter and the api field for
# 	the task name says fetchSimilar
test_that("We can fetch similar terms given a letter", {
	expect_that(rtematres.api(task = "letter", argument = 'a'), is_a('list'))
	# and
	expect_that(names(rtematres.api(task = "letter", argument = 'a')), equals('term'))	
})

rtematres.api(task = "fetchVocabularyData", argument = 'a')



      # tasks_available                                                                     tasks_description                                    tasks_argument
    # fetchSourceTerms                Search and retrieve terms mapped in target vocabulary for a given term                                     term (string)
    # fetchTargetTerms   Search and retrieve data about target terms mapped via web services for one term_id                              one ID term_id (int)
           # fetchTerm                                                             Retrieve simple term data                                      one ID (int)
          # fetchTerms               Retrieve simple term data for some coma separated IDs (example: 3,6,98) some coma separated IDs (for example: arg=3,6,98)
       # fetchTopTerms                                                         Retrieve vocabulary top terms                                              none
             # fetchUp                                            Retrieve hierarquical structure for one ID                                      one ID (int)
            # fetchURI         Search and retrieve data about URI or internet entities linked to one term_id                              one ID term_id (int)
 # fetchVocabularyData                                                        Retrieve data about vocabulary                                                 1
              # letter                              Search and retrieve terms was beginning with letter $arg                   one letter (for example: arg=a)
              # search                                                             Search and retrieve terms                         search expresion (string)
         # searchNotes                                                     Retrieve terms searching in notes                         search expresion (string)
             # suggest                  Simple search and retrieve terms who start with string (only string)                         search expresion (string)
      # suggestDetails p


# rtematres.api(task = "fetchCode" argument = "bio") # FIXME: I do not understand this one
# fetchCode                                                     Retrieve simple term data by code                                     code (string)
