#import functions

Import_Data <- function(PATHS_VECTOR) {
  for (PATH in PATHS_VECTOR) {
    if(!is.character(PATH)){
      print("PATH given to Import_Data is not a character")
      stop()
    }
    if(!file.exists(PATH)){
      print(paste("Following path does not currently exist"),PATH)
      stop()
    }
  }
  
  DT_List <- list()
  
  for (PATH in PATHS_VECTOR) {
    #this code takes the 4 last characters of file path, except file extension
    n<- nchar(PATH)
    name<- substr(PATH,n-7,n-4)
    DT<-fread(PATH,header = TRUE)
    DT_List[[name]]<- DT
    
  }
  return(DT_List)
}

Import_Directory<-function(DIR_PATH){
  if (!dir.exists(DIR_PATH)) {
    print("Directory Path given to Import Directory doesn't exist")
    stop()
  }
  
  output<- list.files(DIR_PATH,full.names = TRUE)
  output<- Import_Data(output)
  return(output)
  
}


