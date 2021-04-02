source("Functions/Maintainer/Derive_Maint.R")
source("Functions/Maintainer/Factor_Maint.R")



Maintainer_Factor_Presence<-function(x){
  Check.Factor(x,"Maintainer_Factor_Presence")
  
  missing_factors <- setdiff(levels(x), x)
  present_factor <- setdiff(levels(x),missing_factors)
  return(toString(paste(present_factor,sep = ",")))
  
}

Maintainer_Sum<- function(x, IGNORE_REPEATED=TRUE){
  Check.Vector(x,"Maintainer_Sum")
  
  uniq<- unique(x)
  if(anyNA(uniq)&length(uniq)==1){
    return(uniq[1])
  }
  else{
    if(IGNORE_REPEATED) x<- uniq
    
    return(sum(x,TRUE))
  }
  
}

Maintainer_Concat<- function(x){
  Check.Vector(x,"Maintainer_Concat")
  
  output<- c()
  for (i in x) {
    output<- paste(c(output,as.character( i)),sep = ",")
  }
  
  return(toString( output))
}

Clean_Maintainer <- function(CLEAN_HEI){
  Check.Clean_HEI(CLEAN_HEI,"Clean_Maintainer")
  
  CLEAN_MAINT <- CLEAN_HEI[,.(
    Census_Year = Census_Year[1], 
    
    Own_Revenue = Maintainer_Sum(Own_Revenue), Transferred_Revenue=Maintainer_Sum(Transferred_Revenue),
    Other_Revenue= Maintainer_Sum(Other_Revenue),Total_Revenue = Maintainer_Sum(Total_Revenue),
    
    Faculty_Expenses=Maintainer_Sum(Faculty_Expenses),
    Staff_Expenses=Maintainer_Sum(Staff_Expenses),Social_Contribution_Expenses=Maintainer_Sum(Social_Contribution_Expenses),
    Cost_Expenses=Maintainer_Sum(Cost_Expenses), Investment_Expenses = Maintainer_Sum(Investment_Expenses),
    research_Expenses = Maintainer_Sum(research_Expenses), Other_Expenses = Maintainer_Sum(Other_Expenses),
    Total_Expense = Maintainer_Sum(Total_Expense),
    
    N_HEIs = .N, HEI_Types = Maintainer_Factor_Presence(Administrative_Structure), 
    HEI_Code= Maintainer_Concat(HEI_Code),
    
    Students_Total = Maintainer_Sum(Students_Total,FALSE), Students_Dist = Maintainer_Sum(Students_Dist,FALSE),
    Students_Class = Maintainer_Sum(Students_Class,FALSE), Students_New = Maintainer_Sum(Students_New,FALSE),
    Students_Cancelled = Maintainer_Sum(Students_Cancelled,FALSE),
    
    Cont_IGC_Mean = mean(IGC_Continuous),Cont_IGC_SD = sd(IGC_Continuous),
    Level_IGC_Mean =mean(IGC_Level),Level_IGC_SD =sd(IGC_Level),
    Grad_Average_Mean= mean(Grad_Mean),Grad_Average_SD= sd(Grad_Mean),
    Grad_Alpha_Mean=mean(Grad_Alfa), Grad_Alpha_SD=sd(Grad_Alfa)
    
    
  ),by=Maintainer_Code ]
  
  
  Derive_Maint(CLEAN_MAINT)
  
  
  CLEAN_MAINT<- Factor_Maint(CLEAN_MAINT)
  
  return(CLEAN_MAINT)
}

Clean_Maint_List <- function(CLEAN_HEI_LIST) {
  output<- list()
  for (i in 1:length(CLEAN_HEI_LIST)) {
    output[[names(CLEAN_HEI_LIST[i])]]<- 
      Clean_Maintainer(CLEAN_HEI_LIST[[i]])
    
  }
  return(output)
}
