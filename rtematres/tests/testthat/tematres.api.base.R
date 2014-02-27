context("Test all base api tasks")

# check tasks
# rtematres.api(task = "availableTasks" )
# rtematres(task="availableTasks")

test_that("We can list the available API tasks", {
	  expect_that(rtematres.api(task = "availableTasks"), is_a('data.frame'))
})

# rtematres.api(task = "fetchVocabularyData")
# rtematres(task="fetchVocabularyData")

test_that("We can fetch information about the vocabulary", {
	  expect_that(rtematres.api(task = "fetchVocabularyData"), is_a('list'))
	  # and
	  expect_that(names(rtematres.api(task = "fetchVocabularyData")), equals(c("vocabulary_id", "title", "author", "language", "scope", "keywords", "uri", "created_at", "last_modified_at", "contributors", "publisher", "rights", "count_of_terms", "status", "server_version", "api_version")))
})

# rtematres.api(task = "fetchTopTerms")
# rtematres(task = "fetchTopTerms")

test_that("We can fetch the top terms", {
	  expect_that(rtematres.api(task = "fetchTopTerms"), is_a('list'))
	  # and
	  expect_that(names(rtematres.api(task = "fetchTopTerms")), equals(c("term", "language", "term_id", "code", "is.meta.term")))
})

# rtematres.api(task = "fetchLast")
# rtematres(task = "fetchLast")

test_that("We can fetch a list of last modified terms", {
	  expect_that(rtematres.api(task = "fetchLast"), is_a('list'))
	  # and
	  expect_that(names(rtematres.api(task = "fetchLast")), equals(c("term", "language", "term_id", "code", "is.meta.term", "created_at", "last_modified_at")))
})

# rtematres.api(task = "fetchCode", argument = 962)
# rtematres(task = "fetchCode", term = "topTerm")

test_that("We can retrieve terms by code", {
	  expect_that(rtematres.api(task = "fetchCode", argument = "19.11.1981"), is_a('list'))
	  # and
	  expect_that(names(rtematres.api(task = "fetchCode", argument = "19.11.1981")), equals(c("term")))
})


# rtematres.api(task = "search", argument = "tree")
# rtematres(task = "search", term = "t")
# rtematres(task = "search", term = "to")

test_that("We can search for terms", {
	  expect_that(rtematres.api(task = "search", argument = "plant organ"), is_a('list'))
	  # and
	  expect_that(names(rtematres.api(task = "search", argument = "plant organ")), equals(c("term", "term_id", "is.meta.term", "no_term_string", "index", "order")))
})

# rtematres.api(task = "fetch", argument = "C")
# rtematres(task = "fetch", term = "C")
# rtematres(task = "fetch", term = "Carbon")

test_that("We can search by exact match", {
	  expect_that(rtematres.api(task = "fetch", argument = "plant organ"), is_a('list'))
	  # and
	  expect_that(names(rtematres.api(task = "fetch", argument = "plant organ")), equals(c("term", "term_id", "is.meta.term", "no_term_string", "order")))
	  # and
	  expect_that(rtematres.api(task = "fetch", argument = "plant organ")$term, equals("plant organ"))
})


# rtematres.api(task = "searchNotes", argument = "tree")
# rtematres(task = "searchNotes", term = "tree")

test_that("We can search in notes", {
	  expect_that(rtematres.api(task = "searchNotes", argument = "plant organ"), is_a('list'))
	  # and
	  expect_that(names(rtematres.api(task = "searchNotes", argument = "plant organ")), equals(c("term", "term_id", "is.meta.term", "no_term_string", "index", "order")))
})

# rtematres.api(task = "suggest", argument = "t")
# rtematres(task = "suggest", term = "tree")

test_that("We can search terms starting with the same letter", {
	  expect_that(rtematres.api(task = "suggest", argument = "a"), is_a('list'))
	  # and
	  expect_that(names(rtematres.api(task = "suggest", argument = "a")), equals(c("term")))
})

# rtematres.api(task = "suggestDetails", argument = "t")
# rtematres(task = "suggestDetails", term = "t")
# rtematres(task = "suggestDetails", term = "tr")

test_that("We can search details of a term", {
	  expect_that(rtematres.api(task = "suggestDetails", argument = "plant organ"), is_a('list'))
	  # and
	  expect_that(names(rtematres.api(task = "suggestDetails", argument = "plant organ")), equals(c("term", "term_id", "is.meta.term", "no_term_string", "index", "order")))
})


# rtematres.api(task = "fetchSimilar", argument = "t")
rtematres(task = "fetchSimilar", term = "ta")

test_that("We can search for similar terms", {
	  expect_that(rtematres.api(task = "fetchSimilar", argument = "plant organ"), is_a('list'))
	  # and
	  expect_that(names(rtematres.api(task = "fetchSimilar", argument = "plant organ")), equals(c("term")))
})

# rtematres.api(task = "letter", argument = "t")
# rtematres(task = "letter", term = "t")

test_that("We can fetch similar terms given a letter", {
	  expect_that(rtematres.api(task = "letter", argument = 'a'), is_a('list'))
	  # and
	  expect_that(names(rtematres(task = "letter", term = 'a')), equals(c('term', 'term_id', 'is.meta.term', 'no_term_string', 'relation_type_id')))
})

# rtematres.api(task = "fetchAlt", argument = 962)
# rtematres(task = "fetchAlt", term = "topMostTerm")

test_that("We can fetch alternative non preferred terms", {
	  expect_that(rtematres.api(task = "fetchAlt", argument = 1), is_a('list'))
	  # and
	  expect_that(names(rtematres.api(task = "fetchAlt", argument = 1)), equals(c("term", "language", "term_id", "code", "relation_type", "relation_code", "relation_label", "relation_type_id")))
})

# rtematres.api(task = "fetchTerm", argument = 962)
# rtematres(task = "fetchTerm", term = "topMostTerm")

test_that("We can retrieve simple term data", {
	  expect_that(rtematres.api(task = "fetchTerm", argument = 1), is_a('list'))
	  # and
	  expect_that(names(rtematres.api(task = "fetchTerm", argument = 1)), equals(c("term", "language", "term_id", "tema_id", "code", "is.meta.term", "created_at", "last_modified_at")))
})


# rtematres.api(task = "fetchTerms", argument = '962, 1')
# rtematres(task = "fetchTerms", term = c("tree", "plant organ"))

test_that("We can retrieve simple term data for comma separated IDs", {
	  expect_that(rtematres.api(task = "fetchTerms", argument = "1,2"), is_a('list'))
	  # and
	  expect_that(names(rtematres.api(task = "fetchTerms", argument = 1)), equals(c("term", "term_id", "is.meta.term")))
})

# rtematres.api(task = "fetchUp", argument = 2)
# rtematres(task = "fetchUp", term = c("tree"))

test_that("We can fetch up the hirarchy", {
	  expect_that(rtematres.api(task = "fetchUp", argument = 1), is_a('list'))
	  # and
	  expect_that(names(rtematres.api(task = "fetchUp", argument = 1)), equals(c("term", "term_id", "is.meta.term", "relation_type_id", "order")))
})


# rtematres.api(task = "fetchDown", argument = 2)
# rtematres(task = "fetchDown", term = c("tree"))

test_that("We can fetch down the hirarchy", {
	  expect_that(rtematres.api(task = "fetchDown", argument = 1), is_a('list'))
	  # and
	  expect_that(names(rtematres.api(task = "fetchDown", argument = 1)), equals(c("term", "language", "term_id", "is.meta.term", "relation_type", "relation_code", "relation_label", "has_narrower_terms")))
})

# rtematres.api(task = "fetchRelated", argument = 962)
# rtematres(task = "fetchRelated", term = c("tree", "plant organ"))
# rtematres(task = "fetchRelated", term = "topMostTerm")

test_that("We can fetch related terms for a id ", {
	  expect_that(rtematres.api(task = "fetchRelated", argument = 1), is_a('list'))
	  # and
	  expect_that(names(rtematres.api(task = "fetchRelated", argument = 1)), equals(c("term", "language", "term_id", "is.meta.term", "code", "relation_type", "relation_code", "relation_label", "relation_type_id")))
})

# rtematres.api(task = "fetchRelatedTerms", argument = 962)
# rtematres(task = "fetchRelatedTerms", term = c("carbon", "topMostTerm"))
# rtematres(task = "fetchRelatedTerms", term = "topMostTerm")

test_that("We can fetch related terms for a id ", {
	  expect_that(rtematres.api(task = "fetchRelatedTerms", argument = 1), is_a('list'))
	  # and
	  expect_that(names(rtematres.api(task = "fetchRelatedTerms", argument = 1)), equals(c("term", "term_id", "is.meta.term")))
})

# rtematres.api(task = "fetchNotes", argument = 962)
# rtematres(task = "fetchNotes", term = c("carbon", "topMostTerm"))
# rtematres(task = "fetchNotes", term = "topMostTerm")

test_that("We can fetch notes or descriptions for a term", {
	  expect_that(rtematres.api(task = "fetchNotes", argument = 1), is_a('list'))
	  # and
	  expect_that(names(rtematres.api(task = "fetchNotes", argument = 1)), equals(c("term", "term_id", "note_id", "note_type", "note_language", "note_text")))
})

# rtematres.api(task = "fetchDirectTerms", argument = 962)
# rtematres(task = "fetchDirectTerms", term = c("carbon", "topMostTerm"))
# rtematres(task = "fetchDirectTerms", term = "topMostTerm")

test_that("We can fetch alternative, related and direct hieraquical terms", {
	  expect_that(rtematres.api(task = "fetchDirectTerms", argument = 1), is_a('list'))
	  # and
	  expect_that(names(rtematres.api(task = "fetchDirectTerms", argument = 1)), equals(c("term", "language", "term_id", "is.meta.term", "code", "relation_type", "relation_code", "relation_label", "relation_type_id")))
})

# rtematres.api(task = "fetchURI", argument = 962)
# rtematres(task = "fetchURI", term = c("carbon", "topMostTerm"))
# rtematres(task = "fetchURI", term = "topMostTerm")

test_that("We can fetch URI information for a term", {
	  expect_that(rtematres.api(task = "fetchURI", argument = "plant organ"), is_a('list'))
	  # and
	  expect_that(names(rtematres.api(task = "fetchURI", argument = "plant organ")), equals(c("link_type", "link")))
})

# rtematres.api(task = "fetchTargetTerms", argument = 962)
# rtematres(task = "fetchTargetTerms", term = c("carbon", "topMostTerm"))
# rtematres(task = "fetchTargetTerms", term = "topMostTerm")

test_that("We can retrieve data about target terms mapped via web services", {
	  expect_that(rtematres.api(task = "fetchTargetTerms", argument = 1), is_a('list'))
	  # and
	  expect_that(names(rtematres.api(task = "fetchTargetTerms", argument = 1)), equals(c("term", "term_id", "term_url", "term_uri", "target_vocabulary_label", "target_vocabulary_tag", "target_vocabulary_title")))
})


# rtematres.api(task = "fetchSourceTerms", argument = 962)
# rtematres(task = "fetchSourceTerms", term = c("carbon", "topMostTerm"))
# rtematres(task = "fetchSourceTerms", term = "topMostTerm")

test_that("We can fetch URI information for a term", {
	  expect_that(rtematres.api(task = "fetchSourceTerms", argument = "plant organ"), is_a('list'))
	  # and
	  expect_that(names(rtematres.api(task = "fetchSourceTerms", argument = "plant organ")), equals(c("term")))
})
