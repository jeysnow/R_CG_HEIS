#import functions

Import_Data <- function(PATHS_VECTOR) {
  for (PATH in PATHS_VECTOR) {
    if(!is.character(PATH)){
      warning("PATH given to Import_Data is not a character")
      stop()
    }
    if(!file.exists(PATH)){
      warning(paste("Following path does not currently exist"),PATH)
      stop()
    }
  }
  
  DT_Vector <- list()
  
  for (PATH in PATHS_VECTOR) {
    #this code takes the 4 last characters of file path, except file extension
    n<- nchar(PATH)
    name<- substr(PATH,n-7,n-4)
    DT<-fread(PATH,header = TRUE)
    DT_Vector[[name]]<- DT
    
  }
  return(DT_Vector)
}
