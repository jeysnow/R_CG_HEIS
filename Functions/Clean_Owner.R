OWNER_FACTOR_PRESENCE<-function(x){
  if(!is.factor(x)){
    warning("input for OWNER_FACTOR_PRESENCE is not a factor")
    stop()
  }
  missing_factors <- setdiff(levels(x), x)
  present_factor <- setdiff(levels(x),missing_factors)
  return(toString(paste(present_factor,sep = ",")))
  
}

OWNER_FIN_SUMM<- function(x){
  if(!is.vector(x)){
    warning("input for OWNER_FIN_SUMM is not a vector")
    stop()
  }
  if(anyNA(x)){
    warning(c(names(x)," has at least one NA"))
    stop()
  }
  
  
  if(mean(x)==x[1] ){
    
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

Check_Owner_Code <- function(x){RAW_HEI_2019[CO_MANTENEDORA==x,NO_MANTENEDORA]}

Clean_Maintainer <- function(CLEAN_HEI){
  if(names(CLEAN_HEI)[1]!="HEI_Code"){
    warning("Clean_Maintainer received Clean HEI data with wrong headers. Was it cleaned?")
    stop()
  }
  
  CLEAN_MAINT <- CLEAN_HEI[,.(
    Census_Year = Census_Year[1], 
    
    Own_Revenue = OWNER_FIN_SUMM(Own_Revenue), Transferred_Revenue=OWNER_FIN_SUMM(Transferred_Revenue),
    Other_Revenue= OWNER_FIN_SUMM(Other_Revenue),Total_Revenue = OWNER_FIN_SUMM(Total_Revenue),
    
    Faculty_Expenses=OWNER_FIN_SUMM(Faculty_Expenses),
    Staff_Expenses=OWNER_FIN_SUMM(Staff_Expenses),Social_Contribution_Expenses=OWNER_FIN_SUMM(Social_Contribution_Expenses),
    Cost_Expenses=OWNER_FIN_SUMM(Cost_Expenses), Investment_Expenses = OWNER_FIN_SUMM(Investment_Expenses),
    research_Expenses = OWNER_FIN_SUMM(research_Expenses), Other_Expenses = OWNER_FIN_SUMM(Other_Expenses),
    Total_Expense = OWNER_FIN_SUMM(Total_Expense),
    
    N_HEIs = .N, HEI_Types = OWNER_FACTOR_PRESENCE(Administrative_Structure), 
    HEI_Code= OWNER_CHAR_CONCAT(HEI_Code),
    
    Students_Total = OWNER_FIN_SUMM(Students_Total), Students_Dist = OWNER_FIN_SUMM(Students_Dist),
    Students_Class = OWNER_FIN_SUMM(Students_Class)
    
    
    
  ),by=Maintainer_Code ]
  
  CLEAN_MAINT[,Revenue_Category := 
     factor( sapply(Total_Revenue, function(x){
       if(x<360000){
         return("Micro")
         
       }
       if(x<4800000){
         return("Small")
       }
       if(x<300000000){
         return("Medium")
       }
       else return("Large")
     }
     )
     )
  ]
  
  return(CLEAN_MAINT)
}