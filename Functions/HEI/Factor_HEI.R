#Factor_HEI
Factor_HEI <- function(CLEAN_HEI) {
  setkey(CLEAN_HEI,"HEI_Code")
  
  CLEAN_HEI[,Administrative_Structure:=factor(
    as.factor(Administrative_Structure),levels = 1:9,
    labels =  c("Federally_Owned","State_Owned","Municipally_Owned","Private_for_profit",
                "Private_nonprofit","Private_strictly","Special","Comunity_Owned","Confessional")
  )]
  
  
  CLEAN_HEI[,Academic_Status:=factor(
    as.factor(Academic_Status),levels = 1:5,
    labels =  c("University","University_Center","Faculty",
                "Federal_Institute","Federal_Center")
  )]
}
