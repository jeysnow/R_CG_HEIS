Derive_HEI.concat <- function(x){
  Check.Vector(x,"Derive_HEI.concat_unique")
  
  #Concatenates texts
  output<- c()
  for (i in x) {
    output<- paste(c(output,as.character( i)),sep = ",")
  }
  
  return(toString( output))
}

Derive_HEI <-function(CLEAN_HEI,CLEAN_STUDENT){
  
  if(!"HEI_Code"%in%names(CLEAN_HEI)){
    warning("Derive_HEI received Clean HEI data with wrong  headers. Was it cleaned?")
    stop()
  }
  if(!"Student_Code"%in%names(CLEAN_STUDENT)){
    print("Clean_HEI received student data with wrong  headers. Was it cleaned?")
    stop()
  }
  if(CLEAN_HEI[1,Census_Year]!=CLEAN_STUDENT[1,Census_Year]){
    warning("Student and HEi data census years don't match at Derive_HEI")
    stop()
  }
  
  #Own Clean HEI data
  CLEAN_HEI[,Total_Revenue:= Own_Revenue+Transferred_Revenue+Other_Revenue]
  
  CLEAN_HEI[,Total_Expense:=Faculty_Expenses+Staff_Expenses+research_Expenses
                 +Other_Expenses+Social_Contribution_Expenses+Investment_Expenses
                 +Cost_Expenses]
  CLEAN_HEI[,Profit:=Total_Revenue - Total_Expense]
  
  
  #Clean Student data
  
  
  CLEAN_HEI<- CLEAN_STUDENT[, .N,HEI_Code][CLEAN_HEI,on="HEI_Code"]
  setnames(CLEAN_HEI,"N","Students_Total")
  
  CLEAN_HEI<- CLEAN_STUDENT[,sum(Student_New),HEI_Code][CLEAN_HEI,on="HEI_Code"]
  setnames(CLEAN_HEI,"V1","Students_New")
  
  
  CLEAN_HEI[,Rate_Attraction:=Students_New/Students_Total]
  
  CLEAN_HEI<-CLEAN_STUDENT[Student_Enrollment_Situation=="Cancelled",
                           .N,HEI_Code][CLEAN_HEI,on="HEI_Code"]
  setnames(CLEAN_HEI,"N","Students_Cancelled")
  
  CLEAN_HEI[,Students_Cancelled:=nafill(Students_Cancelled,fill = 0)]
  
  CLEAN_HEI[,Rate_Retention:=Students_Cancelled/Students_Total]
  
  CLEAN_HEI<- CLEAN_STUDENT[Course_Mode=="Distance",.N,HEI_Code][CLEAN_HEI,on="HEI_Code"]
  setnames(CLEAN_HEI,"N","Students_Dist")
  CLEAN_HEI[,Students_Dist:=nafill(Students_Dist,fill = 0)]
  
  CLEAN_HEI<- CLEAN_STUDENT[Course_Mode=="Classroom",.N,HEI_Code][CLEAN_HEI,on="HEI_Code"]
  setnames(CLEAN_HEI,"N","Students_Class")
  CLEAN_HEI[,Students_Class:=nafill(Students_Class,fill = 0)]
  
  #listing all the course codes
  
  CLEAN_HEI<- CLEAN_STUDENT[Course_Mode=="Classroom",Derive_HEI.concat(levels(Course_CINE_Code)),+
                              HEI_Code][CLEAN_HEI,on="HEI_Code"]
  setnames(CLEAN_HEI,"V1","Courses_CINE_Classroom")
  
  CLEAN_HEI<- CLEAN_STUDENT[Course_Mode=="Distance",Derive_HEI.concat(levels(Course_CINE_Code)),+
                              HEI_Code][CLEAN_HEI,on="HEI_Code"]
  setnames(CLEAN_HEI,"V1","Courses_CINE_Distance")
  
  
  return(CLEAN_HEI)
}
