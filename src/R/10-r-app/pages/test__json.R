#* @filter cors
cors <- function(res) {
    res$setHeader("Access-Control-Allow-Origin", "*")
    plumber::forward()
}

#' @preempt cors
#' @get /html
#' @html
function(){
  "<html><h1>hello world</h1></html>"
}

  # res$body <- "foo"
  # cors(res)
  # print(res)
