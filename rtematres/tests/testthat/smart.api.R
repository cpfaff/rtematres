context("Test all convenient api tasks")

test_that("We can search for terms", {
      expect_that(rtematres(task="search", term="tree"), is_a('character'))
      expect_that(rtematres(task="search", term="t"), is_a('character'))
})

test_that("We can search for terms including notes", {
      expect_that(rtematres(task="search", term="tree", includenotes=T), is_a('character'))
})

test_that("We can broaden terms", {
      expect_that(rtematres(task="broaden", term="plant organ"), is_a('character'))
})

test_that("We can narrow terms", {
      expect_that(rtematres(task="narrow", term="plant organ"), is_a('character'))
})

test_that("We can define terms", {
      expect_that(rtematres(task="define", term="plant organ"), is_a('character'))
})
