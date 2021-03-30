STUDENT_COL_NAME_RAW <-c(
  "NU_ANO_CENSO","CO_IES","TP_CATEGORIA_ADMINISTRATIVA","TP_ORGANIZACAO_ACADEMICA",
  "CO_CURSO","TP_MODALIDADE_ENSINO","CO_CINE_ROTULO","TP_GRAU_ACADEMICO",
  "ID_ALUNO","CO_ALUNO_CURSO_ORIGEM","TP_SITUACAO","IN_FINANCIAMENTO_ESTUDANTIL"
)
STUDENT_COL_NAME_CLEAN <- c(
  "Census_Year","HEI_Code","Administrative_Structure","Academic_Status","Course_Code",
  "Course_Mode","Course_International_Code","Course_Type", "Student_Code",
  "Student_Course_Origin","Student_Enrollment_Situation","Student_Financial_Aid"
)

Clean_Sudent <- function(RAW_STUDENT){
  if(!is.data.table(RAW_STUDENT)){
    warning("Raw Student input is not a Data.Table")
    stop()
  }
  
  CLEAN_STUDENT <- RAW_STUDENT[TP_NIVEL_ACADEMICO==1,..STUDENT_COL_NAME_RAW]
  setnames(CLEAN_STUDENT,old= STUDENT_COL_NAME_RAW,new=STUDENT_COL_NAME_CLEAN)
  
  
  CLEAN_STUDENT[,Administrative_Structure:=factor(
    as.factor(Administrative_Structure),levels = 1:9,
    labels =  c("Federally_Owned","State_Owned","Municipally_Owned","Private_for_profit",
                "Private_nonprofit","Private_strictly","Special","Comunity_Owned","Confessional")
  )]
  
  CLEAN_STUDENT[,Course_Mode:= 
    factor(as.factor(Course_Mode),1:2,labels = c("Classroom","Distance"))]
  
  return(CLEAN_STUDENT)
}

Clean_Student_List <- function(RAW_STUDENT_VECTOR) {
  output<- list()
  for (i in 1:length(RAW_STUDENT_VECTOR)) {
    output[[names(RAW_STUDENT_VECTOR[i])]]<- 
      Clean_Sudent(RAW_STUDENT_VECTOR[[i]])
    
  }
  return(output)
}
