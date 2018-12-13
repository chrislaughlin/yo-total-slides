
#' @get /demo
#' @serializer unboxedJSON
function(res){
  res$setHeader("Access-Control-Allow-Origin", "*")
    res$body <-
      list(
        status = "SUCCESS",
        code = "200",
        output = "foobar"
          )
}
