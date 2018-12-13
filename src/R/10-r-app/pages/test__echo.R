#* @filter cors
cors <- function(res) {
  res$setHeader("Access-Control-Allow-Origin", "*")
  plumber::forward()
}

res <- "foo"

res$body <-
  list(
    status = "SUCCESS",
    code = "200",
    output =
      list(
        studentid = "1001",
        name = "Kevin"))
farp <- cors(res)
head(farp) 
