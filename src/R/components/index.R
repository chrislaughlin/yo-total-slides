LoadComponents <- function(x){

  cat("\014")

  functionsList <- c(
    'ternary.R',
    'remove-special-characters.R'
  )
  
  # TODO: Add Paralel
  # library(parallel)
  # no_cores <- detectCores() - 1
  # cl <- makeCluster(no_cores)

  directories <- list.dirs(path="components/.", full.names = T)

  LoadFunctions <- function(x) {
    old <- setwd(x)
    # parLapply(
      # cl,
    lapply(
      functionsList,
      function(functionsList) {
        source(functionsList, print.eval=F, encoding = 'UTF-8')
      }
    )
    setwd(old)
  }

  lapply(directories, LoadFunctions)

  # stopCluster(cl)
}

# remove all variables except functions
# rm(list = setdiff(ls(), lsf.str()))
