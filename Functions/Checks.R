#Checks

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
}
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

