#Checks

#Path checks----
Check.Path<-function(PATH,ORIGIN=""){
  if(!is.character(PATH)){
    print(paste(ORIGIN ," received a PATH that is not a character: ",PATH))
    stop()
  }
  return(TRUE)
}

Check.File<- function(PATH,ORIGIN=""){
  Check.Path(PATH,ORIGIN)
  
  if(!file.exists(PATH)){
    print(paste(ORIGIN, ": received a PATH to an inexistent file: ",PATH))
    stop()
  }
  return(TRUE)
}

Check.Dir<- function(PATH,ORIGIN=""){
  Check.Path(PATH,ORIGIN)
  
  if(!dir.exists(PATH)){
    print(paste(ORIGIN, ": received a PATH to an inexistent directory: ",PATH))
    stop()
  }
  return(TRUE)
}

#Census checks-----

Check.Clean_HEI<- function(DT,ORIGIN=""){
  Check.DT(DT,ORIGIN)
  if(!"HEI_Code"%in%names(DT))
  {
    print(paste(ORIGIN,": Headers of DT do not match Clean HEI data"))
    stop()
  }
}


Check.Raw_Student<- function(DT,ORIGIN=""){
  Check.DT(DT,ORIGIN)
  if(!"CO_CURSO"%in%names(DT))
  {
    print(paste(ORIGIN,": Headers of DT do not match raw student data"))
    stop()
  }
  return(TRUE)
}

#data type checks-----
Check.DT<-function(DT,ORIGIN=""){
  if(is.data.table(DT)) return(TRUE)
  else{
    print(paste(ORIGIN,": Data received was not a Data.Table"))
    stop()
  }
}

Check.Factor<- function(X,ORIGIN=""){
  if(!is.factor(X)){
    print(paste(ORIGIN,": Data received was not a factor"))
    stop()
  }
}

Check.Vector<- function(X,ORIGIN=""){
  if(!is.vector(X)){
    print(paste(ORIGIN,": Data received was not a vector"))
    stop()
  }
  return(TRUE)
}
Check.NA<- function(X,ORIGIN=""){
  if(!anyNA(X)){
    print(paste(ORIGIN,": Data received has NA values"))
    stop()
  }
}

Check.Number <- function(x,ORIGIN){
  if(!is.numeric(x)){
    print(paste(ORIGIN,": Data received was not numeric"))
    stop()
  }
}

Check.String <-function(STRING,ORIGIN=""){
  if(!is.character(STRING)){
    print(paste(ORIGIN ," received a value that is not a character: ",STRING))
    stop()
  }
  return(TRUE)
}

