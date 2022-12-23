#Factor_HEI
Factor_HEI <- function(CLEAN_HEI) {
  setkey(CLEAN_HEI,"HEI_Code")
  
  #names
  Adm_Factors <- c("Federally_Owned","State_Owned","Municipally_Owned",
                  "Private_for_profit","Private_nonprofit","Private_strictly",
                  "Special","Comunity_Owned","Confessional")
  
  Academic_Factors <- c("University","University_Center","Faculty",
                       "Federal_Institute","Federal_Center")
  
  #Checking if conversion is needed
  if(is.numeric(CLEAN_HEI$Administrative_Structure)){
    
    CLEAN_HEI[,Administrative_Structure:=factor(
      as.factor(Administrative_Structure),levels =1:9, labels = Adm_Factors 
    )]
  }
  else{
    CLEAN_HEI[,Administrative_Structure:=factor(
      as.factor(Administrative_Structure),levels = Adm_Factors 
    )]
  }
  
  #Checking if conversion is needed
  if(is.numeric(CLEAN_HEI$Academic_Status)){
    CLEAN_HEI[,Academic_Status:=factor(
      as.factor(Academic_Status),levels =1:5, labels = Academic_Factors 
    )]
  }
  else{
    CLEAN_HEI[,Academic_Status:=factor(
      as.factor(Academic_Status),levels = Academic_Factors
    )]
  }
  
  
}
