`?` <- function(ifTernary, thenTernary)
    eval(
      sapply(
        strsplit(
          deparse(substitute(thenTernary)),
          ":"
      ),
      function(e) parse(text = e)
    )[[2 - as.logical(ifTernary)]])
