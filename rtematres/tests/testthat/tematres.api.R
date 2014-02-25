context("Test all base api tasks")

test_that("We can fetch the available tasks", {
	expect_that(rtematres.api(task = "availableTasks"), is_a('data.frame'))
})

test_that("We can fetch information about the vocabulary", {
	expect_that(rtematres.api(task = "fetchVocabularyData"), is_a('list'))
	# and
	expect_that(names(rtematres.api(task = "fetchVocabularyData")), equals(c("vocabulary_id", "title", "author", "language", "scope", "keywords", "uri", "created_at", "last_modified_at", "contributors", "publisher", "rights", "count_of_terms", "status", "server_version", "api_version")))
})

test_that("We can fetch a list of last modified terms", {
	expect_that(rtematres.api(task = "fetchLast"), is_a('list'))
	# and
	expect_that(names(rtematres.api(task = "fetchLast")), equals(c("term", "language", "term_id", "code", "is.meta.term", "created_at", "last_modified_at")))
})

test_that("We can fetch alternative non preferred terms", {
	expect_that(rtematres.api(task = "fetchAlt", argument = 1), is_a('list'))
	# and
	expect_that(names(rtematres.api(task = "fetchAlt", argument = 1)), equals(c("term", "language", "term_id", "code", "relation_type", "relation_code", "relation_label", "relation_type_id")))
})

test_that("We can fetch terms based on string matching", {
	expect_that(rtematres.api(task = "suggest", argument = "a"), is_a('list'))
	# and
	expect_that(names(rtematres.api(task = "suggest", argument = "bio")), equals('term'))
})

test_that("We can fetch alternative, related and direct hieraquical terms", {
	expect_that(rtematres.api(task = "fetchDirectTerms", argument = 1), is_a('list'))
	# and
	expect_that(names(rtematres.api(task = "fetchDirectTerms", argument = 1)), equals(c("term", "language", "term_id", "is.meta.term", "code", "relation_type", "relation_code", "relation_label", "relation_type_id")))
})

test_that("We can fetch down the hirarchy", {
	expect_that(rtematres.api(task = "fetchDown", argument = 1), is_a('list'))
	# and
	expect_that(names(rtematres.api(task = "fetchDown", argument = 1)), equals(c("term", "language", "term_id", "is.meta.term", "relation_type", "relation_code", "relation_label", "has_narrower_terms")))
})

test_that("We can fetch up the hirarchy", {
	expect_that(rtematres.api(task = "fetchUp", argument = 1), is_a('list'))
	# and
	expect_that(names(rtematres.api(task = "fetchUp", argument = 1)), equals(c("term", "term_id", "is.meta.term", "relation_type_id", "order")))
})

test_that("We can fetch notes or descriptions for a term", {
	expect_that(rtematres.api(task = "fetchNotes", argument = 1), is_a('list'))
	# and
	expect_that(names(rtematres.api(task = "fetchNotes", argument = 1)), equals(c("term", "term_id", "note_id", "note_type", "note_language", "note_text")))
})

test_that("We can fetch related terms for a id ", {
	expect_that(rtematres.api(task = "fetchRelated", argument = 1), is_a('list'))
	# and
	expect_that(names(rtematres.api(task = "fetchRelated", argument = 1)), equals(c("term", "language", "term_id", "is.meta.term", "code", "relation_type", "relation_code", "relation_label", "relation_type_id")))
})

test_that("We can fetch related terms for a id ", {
	expect_that(rtematres.api(task = "fetchRelatedTerms", argument = 1), is_a('list'))
	# and
	expect_that(names(rtematres.api(task = "fetchRelatedTerms", argument = 1)), equals(c("term", "term_id", "is.meta.term")))
})

test_that("We can fetch similar terms given a letter", {
	  expect_that(rtematres.api(task = "letter", argument = 'a'), is_a('list'))
	  # and
	  expect_that(names(rtematres.api(task = "letter", argument = 'a')), equals('term'))
})

test_that("We can retrieve data about target terms mapped via web services", {
	  expect_that(rtematres.api(task = "fetchTargetTerms", argument = 1), is_a('list'))
	  # and
	  expect_that(names(rtematres.api(task = "fetchTargetTerms", argument = 1)), equals(c("term", "term_id", "term_url", "term_uri", "target_vocabulary_label", "target_vocabulary_tag", "target_vocabulary_title")))
})

test_that("We can retrieve simple term data", {
	  expect_that(rtematres.api(task = "fetchTerm", argument = 1), is_a('list'))
	  # and
	  expect_that(names(rtematres.api(task = "fetchTerm", argument = 1)), equals(c("term", "language", "term_id", "tema_id", "code", "is.meta.term", "created_at", "last_modified_at")))
})

test_that("We can retrieve simple term data for comma separated IDs", {
	  expect_that(rtematres.api(task = "fetchTerms", argument = "1,2"), is_a('list'))
	  # and
	  expect_that(names(rtematres.api(task = "fetchTerms", argument = 1)), equals(c("term", "term_id", "is.meta.term")))
})

test_that("We can retrieve top terms", {
	  expect_that(rtematres.api(task = "fetchTopTerms"), is_a('list'))
	  # and
	  expect_that(names(rtematres.api(task = "fetchTopTerms")), equals(c("term", "language", "term_id", "code", "is.meta.term")))
})

# fixme: I do not understand the task atm so it is using the base list
test_that("We can retrieve terms by code", {
	  expect_that(rtematres.api(task = "fetchCode", argument = "19.11.1981"), is_a('list'))
	  # and
	  expect_that(names(rtematres.api(task = "fetchCode", argument = "19.11.1981")), equals(c("term")))
})

test_that("We can search for terms", {
	  expect_that(rtematres.api(task = "search", argument = "plant organ"), is_a('list'))
	  # and
	  expect_that(names(rtematres.api(task = "search", argument = "plant organ")), equals(c("term", "term_id", "is.meta.term", "no_term_string", "index", "order")))
})

test_that("We can search exact match of term", {
	  expect_that(rtematres.api(task = "fetch", argument = "plant organ"), is_a('list'))
	  # and
	  expect_that(names(rtematres.api(task = "fetch", argument = "plant organ")), equals(c("term", "term_id", "is.meta.term", "no_term_string", "order")))
})

test_that("We can search in notes", {
	  expect_that(rtematres.api(task = "searchNotes", argument = "plant organ"), is_a('list'))
	  # and
	  expect_that(names(rtematres.api(task = "searchNotes", argument = "plant organ")), equals(c("term", "term_id", "is.meta.term", "no_term_string", "index", "order")))
})

test_that("We can search terms starting with the same letter", {
	  expect_that(rtematres.api(task = "suggest", argument = "a"), is_a('list'))
	  # and
	  expect_that(names(rtematres.api(task = "suggest", argument = "a")), equals(c("term")))
})

test_that("We can search details of a term", {
	  expect_that(rtematres.api(task = "suggestDetails", argument = "plant organ"), is_a('list'))
	  # and
	  expect_that(names(rtematres.api(task = "suggestDetails", argument = "plant organ")), equals(c("term", "term_id", "is.meta.term", "no_term_string", "index", "order")))
})

test_that("We can fetch URI information for a term", {
	  expect_that(rtematres.api(task = "fetchURI", argument = "plant organ"), is_a('list'))
	  # and
	  expect_that(names(rtematres.api(task = "fetchURI", argument = "plant organ")), equals(c("link_type", "link")))
})

test_that("We can fetch URI information for a term", {
	  expect_that(rtematres.api(task = "fetchSourceTerms", argument = "plant organ"), is_a('list'))
	  # and
	  expect_that(names(rtematres.api(task = "fetchSourceTerms", argument = "plant organ")), equals(c("term")))
})
