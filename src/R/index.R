rm(list = ls()) # clear everything
# setwd(./.)
# you might need to customise this directory:
setwd("~/code/data-science/melbourne-datathon/R")
source('01-load-packages/install-and-load-packages.R', print.eval = F, encoding = 'UTF-8')
source('01-load-packages/packages.R', print.eval=F, encoding = 'UTF-8')
source('02-import-data/code_headers.R', print.eval = F, encoding = 'UTF-8')
LoadComponents(functionsList)
InstallAndLoadPackages(packages)

source('02-import-data/code_headers.R', print.eval = F, encoding = 'UTF-8')

# Setup our router
r <- plumb('10-r-app/pages/demo-api__json.R')
r$run(port = 8888, host = '127.0.0.1')
