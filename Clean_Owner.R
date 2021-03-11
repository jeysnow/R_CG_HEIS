OWNER_FIN_SUMM<- function(x){
  if(!is.vector(x)){
    warning("input for OWNER_FIN_SUMM is not a vector")
    stop()
  }
  if(mean(x)==x[1]){
    
    return(x[1])
  }
  else{
    return(sum(x))
  }
}

OWNER_CHAR_CONCAT<- function(x){
  if(!is.vector(x)){
    warning("input for OWNER_CHAR_CONCAT is not a vector")
    stop()
  }
  output<- c()
  for (i in x) {
    output<- paste(c(output,as.character( i)),sep = ",")
  }
  
  return(toString( output))
}
# 
# ,Administrative_Structure,Academic_Status,
# Owner_Code,Headquarters_Region,Headquarters_State,Headquarters_City,
# Institution_Type,Own_Revenue,Transferred_Revenue,Other_Revenue,
# Faculty_Expenses,Staff_Expenses,Social_Contribution_Expenses,
# Cost_Expenses,Investment_Expenses,research_Expenses,Other_Expenses

CLEAN_OWNER_2019 <-CLEAN_HEI_2019[,.(
  
  
  
  Census_Year = Census_Year[1], Own_Revenue = OWNER_FIN_SUMM(Own_Revenue), 
  Transferred_Revenue=OWNER_FIN_SUMM(Transferred_Revenue), Other_Revenue= OWNER_FIN_SUMM(Other_Revenue),
  Total_Revenue = OWNER_FIN_SUMM(Total_Revenue),Faculty_Expenses=OWNER_FIN_SUMM(Faculty_Expenses),
  Staff_Expenses=OWNER_FIN_SUMM(Staff_Expenses),Social_Contribution_Expenses=OWNER_FIN_SUMM(Social_Contribution_Expenses),
  Cost_Expenses=OWNER_FIN_SUMM(Cost_Expenses), Investment_Expenses = OWNER_FIN_SUMM(Investment_Expenses),
  research_Expenses = OWNER_FIN_SUMM(research_Expenses), Other_Expenses = OWNER_FIN_SUMM(Other_Expenses),
  Total_Expense = OWNER_FIN_SUMM(Total_Expense),
  N_HEIs = .N, HEI_Code= OWNER_CHAR_CONCAT(HEI_Code)
  ),by=Owner_Code ]
