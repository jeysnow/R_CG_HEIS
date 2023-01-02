Read.as_vector<- function(STRING, SEP=", "){
  Check.String(STRING,"Read.as_vector")
  
  strsplit(STRING,SEP) %>% return()
}