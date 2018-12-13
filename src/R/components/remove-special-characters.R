# Not used yet
# Remove special characters from Column title
RemoveSpecial <- function(x) {
  x %<>%
  gsub("[[:punct:]]", "", .) %>% # removes punctuation
  gsub("\\d", "", .) # removes numbers
}
