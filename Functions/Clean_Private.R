Clean_Private <- function(CLEAN_DT){
  if(names(CLEAN_DT)[1]=="HEI_Code"){
    
    #Code for cleaning HEIS
    return(CLEAN_DT[ 
        Administrative_Structure == "Private_for_profit"
        | Administrative_Structure == "Private_nonprofit"])
  }
  
  else if(names(CLEAN_DT)[1]=="Maintainer_Code"){
    
    #Code for cleaning Maintainers
    return(CLEAN_DT[
      HEI_Types=="Private_for_profit, Private_nonprofit"
      |HEI_Types=="Private_for_profit"
      |HEI_Types=="Private_nonprofit"
    ])
  }
  else if(names(CLEAN_DT)[9]=="Student_Code"){
    return(CLEAN_DT[
      Administrative_Structure == "Private_for_profit"
      | Administrative_Structure == "Private_nonprofit"
    ])
  }
  else{
    warning("Clean_Private received Clean DT data with wrong headers. Was it cleaned?")
    stop()
  }
}

Clean_private_List <- function(CLEAN_DT_LIST) {
  output<- list()
  for (i in 1:length(CLEAN_DT_LIST)) {
    output[[names(CLEAN_DT_LIST[i])]]<- 
      Clean_Private(CLEAN_DT_LIST[[i]])
    
  }
  return(output)
}
