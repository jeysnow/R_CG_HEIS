#Factor Student
Factor_Student <- function(CLEAN_STUDENT) {
  
  #names
  Adm_Factors <- c("Federally_Owned","State_Owned","Municipally_Owned",
                  "Private_for_profit","Private_nonprofit","Private_strictly",
                  "Special","Comunity_Owned","Confessional")
  
  Enroll_Factor <- c("Active","Suspended","Cancelled","Transferred in same HEI",
                    "Graduated", "Deceased")
  
  Course_Mode_Factor<- c("Classroom","Distance")
  
  #Checking if conversion is needed
  if(is.numeric(CLEAN_STUDENT$Administrative_Structure)){
    
    CLEAN_STUDENT[,Administrative_Structure:=factor(
      as.factor(Administrative_Structure),levels =1:9, labels = Adm_Factors 
    )]
  }
  else{
    CLEAN_STUDENT[,Administrative_Structure:=factor(
      as.factor(Administrative_Structure),levels = Adm_Factors 
    )]
  }
  
  
  
  #Checking if conversion is needed
  if(is.numeric(CLEAN_STUDENT$Student_Enrollment_Situation)){
    
    CLEAN_STUDENT[,Student_Enrollment_Situation:=factor(
      as.factor(Student_Enrollment_Situation),levels =1:6, labels = Enroll_Factor 
    )]
  }
  else{
    CLEAN_STUDENT[,Student_Enrollment_Situation:=factor(
      as.factor(Student_Enrollment_Situation),levels = Enroll_Factor
    )]
  }
  
  
  
  #Checking if conversion is needed
  if(is.numeric(CLEAN_STUDENT$Course_Mode)){
    
    CLEAN_STUDENT[,Course_Mode:=factor(
      as.factor(Course_Mode),levels =1:2, labels = Course_Mode_Factor 
    )]
  }
  else{
    CLEAN_STUDENT[,Course_Mode:=factor(
      as.factor(Course_Mode),levels = Course_Mode_Factor
    )]
  }
  
  #CINE codes do can't be numeric
  if(is.numeric(CLEAN_STUDENT$Course_CINE_Code)){
    
    print("Factor student received numeric CINE code, which is incorrect.")
    stop()
  }
  else{
    CLEAN_STUDENT[,Course_CINE_Code:=factor(Course_CINE_Code)]
  }
  
  
 
  return(CLEAN_STUDENT)
}
