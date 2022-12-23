source("Functions/Maintainer/Derive_Maint.R")
source("Functions/Maintainer/Factor_Maint.R")

Maintainer_Fin_Sum<- function(x,INST_TYPE){
  Check.Vector(x,"x in Maintainer_Fin_Sum")
  Check.Vector(INST_TYPE,"INST_TYPE in Maintainer_Fin_Sum")
  
  #If there's nothing to sum, just return
  if(length(x)==1) return(x[1])
  
  #Convert array of Inst_Types, their supposed to be all the same
  
  INST_TYPE <- unique(INST_TYPE)
  if(length(INST_TYPE)>1){
    #print(paste("WARNING: ",toString(INST_TYPE),  "inputed as INST_TYPEs inputed for Maintainer_Fin_Sum from the Maint with the following data:",x,
    #            ". Only the first type was considered"))
    
    return(NULL)
  }
  
  #INST_TYPE <- INST_TYPE[1]
  if(INST_TYPE!=1&INST_TYPE!=2){
    print(paste("wrong institutional type imput to Maintainer_Fin_Sum: ",INST_TYPE))
    stop()
  }
  
  #inst_type 1 means that all values must be the same
  if(INST_TYPE==1){
    #exclude identical numbers in the array
    uniq<- unique(x)
    
    #if there are different numbers, issue a warning
    if(length(uniq)>1) {
      print(paste("WARNING: Maint_Fin_Sum found a maintainer (type 1) with the following diverging numbers: ",toString(x),
                  ". Only the first number was returned"))
    }
    return(uniq[1])
  }
  #Type 2 is gives different values to be summed.
  else return(sum(x))
  
}


Maintainer_Factor_Presence<-function(x){
  Check.Factor(x,"Maintainer_Factor_Presence")
  
  #returns only the factors that are present
  missing_factors <- setdiff(levels(x), x)
  present_factor <- setdiff(levels(x),missing_factors)
  return(toString(paste(present_factor,sep = ",")))
  
}

Maintainer_Sum<- function(x, IGNORE_REPEATED=TRUE, IGNORE_SIMILAR=FALSE, TOLERANCE = 0.01){
  Check.Vector(x,"Maintainer_Sum")
  if(TOLERANCE>1||TOLERANCE<0){
    print(paste(ORIGIN,": tolerance requested is out of range"))
  }
  
  #if there's only NA values, return it
  uniq<- unique(x)
  if(anyNA(uniq)&length(uniq)==1){
    return(uniq[1])
  }
  
  
  else{
    if(IGNORE_REPEATED) x<- uniq
    
    # if(IGNORE_SIMILAR){
    #   MEAN <- mean(x)
    #   for(i in x){
    #     difference <- abs(i-MEAN)/MEAN
    #     if(diference > TOLERANCE){
    #       print(paste(ORIGIN,": had differences above the tolerance"))
    #     }
    #   }
    # }
    
    #return the requested sum
    return(sum(x,TRUE))
  }
  
}

Maintainer_Concat<- function(x){
  Check.Vector(x,"Maintainer_Concat")
  
  #Concatenates texts for maintainer
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
    
    #revenues and profit
    Own_Revenue = Maintainer_Fin_Sum(Own_Revenue, Institution_Type), 
    Transferred_Revenue = Maintainer_Fin_Sum(Transferred_Revenue, Institution_Type),
    Other_Revenue = Maintainer_Fin_Sum(Other_Revenue, Institution_Type),
    Total_Revenue = Maintainer_Fin_Sum(Total_Revenue,Institution_Type),
    Profit = Maintainer_Fin_Sum(Profit,Institution_Type),
    #expenses
    Faculty_Expenses = Maintainer_Fin_Sum(Faculty_Expenses,Institution_Type),
    Staff_Expenses= Maintainer_Fin_Sum(Staff_Expenses,Institution_Type),
    Social_Contribution_Expenses= Maintainer_Fin_Sum(Social_Contribution_Expenses,Institution_Type),
    Cost_Expenses=Maintainer_Fin_Sum(Cost_Expenses,Institution_Type), 
    Investment_Expenses = Maintainer_Fin_Sum(Investment_Expenses,Institution_Type),
    research_Expenses = Maintainer_Fin_Sum(research_Expenses,Institution_Type), 
    Other_Expenses = Maintainer_Fin_Sum(Other_Expenses,Institution_Type),
    Total_Expense = Maintainer_Fin_Sum(Total_Expense,Institution_Type),
    
    #org form and ID
    N_HEIs = .N, HEI_Adm_Structures = Maintainer_Factor_Presence(Administrative_Structure), 
    HEI_Code= Maintainer_Concat(HEI_Code),HEI_Names = Maintainer_Concat(HEI_Name),
    
    #Student data
    Students_Total = Maintainer_Sum(Students_Total,FALSE), Students_Dist = Maintainer_Sum(Students_Dist,FALSE),
    Students_Class = Maintainer_Sum(Students_Class,FALSE), Students_New = Maintainer_Sum(Students_New,FALSE),
    Students_Cancelled = Maintainer_Sum(Students_Cancelled,FALSE)
    
#    ,Cont_IGC_Mean = mean(IGC_Continuous),Cont_IGC_SD = sd(IGC_Continuous),
#    Level_IGC_Mean =mean(IGC_Level),Level_IGC_SD =sd(IGC_Level),
#    Grad_Average_Mean= mean(Grad_Mean),Grad_Average_SD= sd(Grad_Mean),
#    Grad_Alpha_Mean=mean(Grad_Alfa), Grad_Alpha_SD=sd(Grad_Alfa)
    
    
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
