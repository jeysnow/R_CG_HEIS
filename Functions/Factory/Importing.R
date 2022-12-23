#import functions
Extract_Path_Year <- function(PATH,NUMERIC=FALSE) {
  n<- nchar(PATH)
  name<- substr(PATH,n-7,n-4)
  year<- as.numeric(name)
  if (year<1000) {
    print(paste("Yar extracted was less than 1000 for path",PATH))
    stop()
  }
  if (NUMERIC) return(year)
  else return(name)
}


Import_Data <- function(PATHS_VECTOR,FACTOR_HEI=FALSE,FACTOR_MAINT=FALSE,FACTOR_STUDENT=FALSE) {
  #Checking paths
  for (PATH in PATHS_VECTOR) {
    if(!is.character(PATH)){
      print("PATH given to Import_Data is not a character")
      stop()
    }
    if(!file.exists(PATH)){
      print(paste("Following path does not currently exist",PATH))
      stop()
    }
  }
  #Checking excessive factoration
  if ((FACTOR_HEI&FACTOR_MAINT)|FACTOR_HEI&FACTOR_STUDENT|FACTOR_MAINT&FACTOR_STUDENT) {
    print("More than one type of factoration chosen for import data")
    stop()
  }
  
  DT_List <- list()
  
  for (PATH in PATHS_VECTOR) {
    #this code takes the 4 last characters of file path, except file extension
    
    name<-Extract_Path_Year(PATH)
    
    DT<-fread(PATH,header = TRUE)
    
    if (FACTOR_HEI) {
      DT<-Factor_HEI(DT)
    }
    
    if (FACTOR_STUDENT) {
      DT<-Factor_Student(DT)
    }
    
    
    
    DT_List[[name]]<- DT
    
  }
  
  
  return(DT_List)
}

Import_Directory<-function(DIR_PATH,FACTOR_HEI=FALSE,FACTOR_MAINT=FALSE,FACTOR_STUDENT=FALSE){
  if (!dir.exists(DIR_PATH)) {
    print("Directory Path given to Import Directory doesn't exist")
    stop()
  }
  
  output<- list.files(DIR_PATH,full.names = TRUE)
  output<- Import_Data(output,FACTOR_HEI,FACTOR_MAINT,FACTOR_STUDENT)
  return(output)
  
}


