# InstallAndLoadPackages function: install and load multiple R packages.
# Check to see if packages are installed. Install them if they are not, then load them into the R session.
# New Packages can be added in components/packages.R

# InstallAndLoadPackages <- function(package){
#   print('install and load packages')
# }

InstallAndLoadPackages <- function(package){
  new.package <- package[!(package %in% installed.packages()[, "Package"])]
  if (length(new.package))
    install.packages(new.package, dependencies = TRUE)
    sapply(package, require, character.only = TRUE)
}
