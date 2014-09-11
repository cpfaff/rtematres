.onLoad = function(lib, pkg) {
  .rtematres.env$.rtematres.opts = list(
    tematres_service_url = "http://tematres.befdata.biow.uni-leipzig.de/vocab/services.php",
    package_api_version = "1.4",
    server_api_version = tryCatch(rtematres(task="fetchVocabularyData"), error = function(e) {return(NA)})
  )
}
