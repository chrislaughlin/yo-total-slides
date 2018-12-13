# library(data.table)

#* @filter cors
cors <- function(res) {
    res$setHeader("Access-Control-Allow-Origin", "*")
    plumber::forward()
}

foo <- data.frame(replicate(10,sample(0:1,1000,rep=TRUE)))


#' @preempt cors
#' @get /html
#' @html
function(){
  "<html><h1>hello world</h1></html>"
}

  # res$body <- "foo"
  # cors(res)
  # print(res)
