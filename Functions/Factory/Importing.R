#import functions
Extract_Path_Year <- function(PATH,NUMERIC=FALSE) {
  #this code takes the 4 last characters of file path, except file extension
  
  n<- nchar(PATH)
  name <- substr(PATH,n-7,n-4)
  year<- as.numeric(name)
  if (year<1000) {
    print(paste("Year extracted was less than 1000 for path",PATH))
    stop()
  }
  if (NUMERIC) return(year)
  else return(name)
}

Import_Data<- function(PATH){
  Check.File(PATH,"Import_Data")
  
  DT <- fread(PATH,header = TRUE)
  
  return(DT)
}


Import_Data_Vector <- function(PATHS_VECTOR,FACTOR_HEI=FALSE,FACTOR_MAINT=FALSE,FACTOR_STUDENT=FALSE) {
  #Checking paths
  for (PATH in PATHS_VECTOR) {
    Check.File(PATH,"Import_Data_Vector")
  }
  #Checking excessive factoration
  if ((FACTOR_HEI&FACTOR_MAINT)|FACTOR_HEI&FACTOR_STUDENT|FACTOR_MAINT&FACTOR_STUDENT) {
    print("More than one type of factoration chosen for import data")
    stop()
  }
  
  DT_List <- list()
  
  for (PATH in PATHS_VECTOR) {
    
    #this code takes the 4 last characters of file path, except file extension
    name  <- Extract_Path_Year(PATH)
    
    
    DT<- Import_Data(PATH)
    
    #Factors require clean data to be given!
    #Redo this code to take this option out
    
    if (FACTOR_HEI) {
      DT<-Factor_HEI(DT)
    }
    
    if (FACTOR_STUDENT) {
      DT<-Factor_Student(DT)
    }
    
    
    DT_List[[paste("Y",name, sep = "")]]<- DT
    
  }
  
  
  return(DT_List)
}

Import_Directory<-function(DIR_PATH,FACTOR_HEI=FALSE,FACTOR_MAINT=FALSE,FACTOR_STUDENT=FALSE){
  
  Check.Dir(DIR_PATH,"Import_Directory")
  output<- list.files(DIR_PATH,full.names = TRUE)
  output<- Import_Data_Vector(output,FACTOR_HEI,FACTOR_MAINT,FACTOR_STUDENT)
  return(output)
  
}


