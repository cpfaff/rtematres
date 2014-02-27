context("Test all base api tasks")

# check tasks
# rtematres(task = "availableTasks" )
# rtematres(task="availableTasks")

test_that("We can list the available API tasks", {
	  expect_that(rtematres(task = "availableTasks"), is_a('data.frame'))
})

# rtematres(task = "fetchVocabularyData")
# rtematres(task="fetchVocabularyData")

test_that("We can fetch information about the vocabulary", {
	  expect_that(rtematres(task = "fetchVocabularyData"), is_a('list'))
	  # and
	  expect_that(names(rtematres(task = "fetchVocabularyData")), equals(c("vocabulary_id", "title", "author", "language", "scope", "keywords", "uri", "created_at", "last_modified_at", "contributors", "publisher", "rights", "count_of_terms", "status", "server_version", "api_version")))
})

# rtematres(task = "fetchTopTerms")
# rtematres(task = "fetchTopTerms")

test_that("We can fetch the top terms", {
	  expect_that(rtematres(task = "fetchTopTerms"), is_a('list'))
	  # and
	  expect_that(names(rtematres(task = "fetchTopTerms")), equals(c("term", "language", "term_id", "code", "is.meta.term")))
})

# rtematres(task = "fetchLast")
# rtematres(task = "fetchLast")

test_that("We can fetch a list of last modified terms", {
	  expect_that(rtematres(task = "fetchLast"), is_a('list'))
	  # and
	  expect_that(names(rtematres(task = "fetchLast")), equals(c("term", "language", "term_id", "code", "is.meta.term", "created_at", "last_modified_at")))
})

# rtematres(task = "fetchCode", term = 962)
# rtematres(task = "fetchCode", term = "topTerm")

test_that("We can retrieve terms by code", {
	  expect_that(rtematres(task = "fetchCode", term = "19.11.1981"), is_a('list'))
	  # and
	  expect_that(names(rtematres(task = "fetchCode", term = "19.11.1981")), equals(c("term")))
})

# rtematres(task = "search", term = "tree")
# rtematres(task = "search", term = "t")
# rtematres(task = "search", term = "to")

test_that("We can search for terms", {
	  expect_that(rtematres(task = "search", term = "plant organ"), is_a('list'))
	  # and
	  expect_that(names(rtematres(task = "search", term = "plant organ")), equals(c("term", "term_id", "is.meta.term", "no_term_string", "index", "order")))
})

# rtematres(task = "fetch", term = "C")
# rtematres(task = "fetch", term = "C")
# rtematres(task = "fetch", term = "Carbon")

test_that("We can search by exact match", {
	  expect_that(rtematres(task = "fetch", term = "plant organ"), is_a('list'))
	  # and
	  expect_that(names(rtematres(task = "fetch", term = "plant organ")), equals(c("term", "term_id", "is.meta.term", "no_term_string", "order")))
	  # and
	  expect_that(rtematres(task = "fetch", term = "plant organ")$term, equals("plant organ"))
})

# rtematres(task = "searchNotes", term = "tree")
# rtematres(task = "searchNotes", term = "tree")

test_that("We can search in notes", {
	  expect_that(rtematres(task = "searchNotes", term = "plant organ"), is_a('list'))
	  # and
	  expect_that(names(rtematres(task = "searchNotes", term = "plant organ")), equals(c("term", "term_id", "is.meta.term", "no_term_string", "index", "order")))
})

# rtematres(task = "suggest", term = "t")
# rtematres(task = "suggest", term = "tree")

test_that("We can search terms starting with the same letter", {
	  expect_that(rtematres(task = "suggest", term = "ab"), is_a('list'))
	  # and
	  expect_that(names(rtematres(task = "suggest", term = "ab")), equals(c("term")))
})

# rtematres(task = "suggestDetails", term = "t")
# rtematres(task = "suggestDetails", term = "t")
# rtematres(task = "suggestDetails", term = "tr")

test_that("We can search details of a term", {
	  expect_that(rtematres(task = "suggestDetails", term = "plant organ"), is_a('list'))
	  # and
	  expect_that(names(rtematres(task = "suggestDetails", term = "plant organ")), equals(c("term", "term_id", "is.meta.term", "no_term_string", "index", "order")))
})


# rtematres(task = "fetchSimilar", term = "t")
# rtematres(task = "fetchSimilar", term = "ta")

test_that("We can search for similar terms", {
	  expect_that(rtematres(task = "fetchSimilar", term = "plant organ"), is_a('list'))
	  # and
	  expect_that(names(rtematres(task = "fetchSimilar", term = "plant organ")), equals(c("term")))
})

# rtematres(task = "letter", term = "t")
# rtematres(task = "letter", term = "t")

test_that("We can fetch similar terms given a letter", {
	  expect_that(rtematres(task = "letter", term = 'a'), is_a('list'))
	  # and
	  expect_that(names(rtematres(task = "letter", term = 'a')), equals(c('term', 'term_id', 'is.meta.term', 'no_term_string', 'relation_type_id')))
})

# rtematres(task = "fetchAlt", term = 962)
# rtematres(task = "fetchAlt", term = "topMostTerm")

test_that("We can fetch alternative non preferred terms", {
	  expect_that(rtematres(task = "fetchAlt", term = "tree"), is_a('list'))
	  # and
	  expect_that(names(rtematres(task = "fetchAlt", term = "tree")), equals(c("term", "language", "term_id", "code", "relation_type", "relation_code", "relation_label", "relation_type_id")))
})

# rtematres(task = "fetchTerm", term = 962)
# rtematres(task = "fetchTerm", term = "topMostTerm")

test_that("We can retrieve simple term data", {
	  expect_that(rtematres(task = "fetchTerm", term = "tree"), is_a('list'))
	  # and
	  expect_that(names(rtematres(task = "fetchTerm", term = "tree")), equals(c("term", "language", "term_id", "tema_id", "code", "is.meta.term", "created_at", "last_modified_at")))
})

# rtematres(task = "fetchTerms", term = '962, 1')
# rtematres(task = "fetchTerms", term = c("tree", "plant organ"))

test_that("We can retrieve simple term data for comma separated IDs", {
	  expect_that(rtematres(task = "fetchTerms", term = c("carbon", "tree")), is_a('list'))
	  # and
	  expect_that(names(rtematres(task = "fetchTerms", term = c("carbon", "tree"))), equals(c("term", "term_id", "is.meta.term")))
})

# rtematres(task = "fetchUp", term = 2)
# rtematres(task = "fetchUp", term = c("tree"))

test_that("We can fetch up the hirarchy", {
	  expect_that(rtematres(task = "fetchUp", term = "carbon"), is_a('character'))
})

# rtematres(task = "fetchDown", term = 2)
# rtematres(task = "fetchDown", term = c("tree"))

test_that("We can fetch down the hirarchy", {
	  expect_that(rtematres(task = "fetchDown", term = "carbon"), is_a('character'))
})

# rtematres(task = "fetchRelated", term = 962)
# rtematres(task = "fetchRelated", term = c("tree", "plant organ"))
# rtematres(task = "fetchRelated", term = "topMostTerm")

test_that("We can fetch related terms for a id ", {
	  expect_that(rtematres(task = "fetchRelated", term = "tree"), is_a('list'))
	  # and
	  expect_that(names(rtematres(task = "fetchRelated", term = "tree")), equals(c("term", "language", "term_id", "is.meta.term", "code", "relation_type", "relation_code", "relation_label", "relation_type_id")))
})

# rtematres(task = "fetchRelatedTerms", term = 962)
# rtematres(task = "fetchRelatedTerms", term = c("carbon", "topMostTerm"))
# rtematres(task = "fetchRelatedTerms", term = "topMostTerm")

test_that("We can fetch related terms for a id ", {
	  expect_that(rtematres(task = "fetchRelatedTerms", term = "tree"), is_a('list'))
	  # and
	  expect_that(names(rtematres(task = "fetchRelatedTerms", term = "tree")), equals(c("term", "term_id", "is.meta.term")))
})

# rtematres(task = "fetchNotes", term = 962)
# rtematres(task = "fetchNotes", term = c("carbon", "topMostTerm"))
# rtematres(task = "fetchNotes", term = "topMostTerm")

test_that("We can fetch notes or descriptions for a term", {
	  expect_that(rtematres(task = "fetchNotes", term = "tree"), is_a('list'))
	  # and
	  expect_that(names(rtematres(task = "fetchNotes", term = "tree")), equals(c("term", "term_id", "note_id", "note_type", "note_language", "note_text")))
})

# rtematres(task = "fetchDirectTerms", term = 962)
# rtematres(task = "fetchDirectTerms", term = c("carbon", "topMostTerm"))
# rtematres(task = "fetchDirectTerms", term = "topMostTerm")

test_that("We can fetch alternative, related and direct hieraquical terms", {
	  expect_that(rtematres(task = "fetchDirectTerms", term = "tree"), is_a('list'))
	  # and
	  expect_that(names(rtematres(task = "fetchDirectTerms", term = "tree")), equals(c("term", "language", "term_id", "is.meta.term", "code", "relation_type", "relation_code", "relation_label", "relation_type_id")))
})

# rtematres(task = "fetchURI", term = 962)
# rtematres(task = "fetchURI", term = c("carbon", "topMostTerm"))
# rtematres(task = "fetchURI", term = "topMostTerm")

test_that("We can fetch URI information for a term", {
	  expect_that(rtematres(task = "fetchURI", term = "plant organ"), is_a('list'))
	  # and
	  expect_that(names(rtematres(task = "fetchURI", term = "plant organ")), equals(c("link_type", "link")))
})

# rtematres(task = "fetchTargetTerms", term = 962)
# rtematres(task = "fetchTargetTerms", term = c("carbon", "topMostTerm"))
# rtematres(task = "fetchTargetTerms", term = "topMostTerm")

test_that("We can retrieve data about target terms mapped via web services", {
	  expect_that(rtematres(task = "fetchTargetTerms", term = "tree"), is_a('list'))
	  # and
	  expect_that(names(rtematres(task = "fetchTargetTerms", term = "tree")), equals(c("term", "term_id", "term_url", "term_uri", "target_vocabulary_label", "target_vocabulary_tag", "target_vocabulary_title")))
})

# rtematres(task = "fetchSourceTerms", term = 962)
# rtematres(task = "fetchSourceTerms", term = c("carbon", "topMostTerm"))
# rtematres(task = "fetchSourceTerms", term = "topMostTerm")

test_that("We can fetch URI information for a term", {
	  expect_that(rtematres(task = "fetchSourceTerms", term = "plant organ"), is_a('list'))
	  # and
	  expect_that(names(rtematres(task = "fetchSourceTerms", term = "plant organ")), equals(c("term")))
})
