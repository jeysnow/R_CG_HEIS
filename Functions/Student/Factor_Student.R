#Factor Student
Factor_Student <- function(CLEAN_STUDENT) {
  CLEAN_STUDENT[,Administrative_Structure:=factor(
    as.factor(Administrative_Structure),levels = 1:9,
    labels =  c("Federally_Owned","State_Owned","Municipally_Owned","Private_for_profit",
                "Private_nonprofit","Private_strictly","Special","Comunity_Owned","Confessional")
  )]
  
  CLEAN_STUDENT[,Course_Mode:= 
                  factor(as.factor(Course_Mode),1:2,labels = c("Classroom","Distance"))]
  
  CLEAN_STUDENT[,Student_Enrollment_Situation:=
                  factor(as.factor(Student_Enrollment_Situation),2:7,labels = 
                           c("Active","Suspended","Cancelled","Transferred in same HEI",
                             "Graduated", "Deceased"))
  ]
  return(CLEAN_STUDENT)
}
