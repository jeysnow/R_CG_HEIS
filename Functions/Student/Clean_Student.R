STUDENT_COL_NAME_RAW <-c(
  "NU_ANO_CENSO","CO_IES","TP_CATEGORIA_ADMINISTRATIVA","TP_ORGANIZACAO_ACADEMICA",
  "CO_CURSO","TP_MODALIDADE_ENSINO","CO_CINE_ROTULO","TP_GRAU_ACADEMICO",
  "ID_ALUNO","CO_ALUNO_CURSO_ORIGEM","TP_SITUACAO","IN_FINANCIAMENTO_ESTUDANTIL",
  "IN_INGRESSO_TOTAL"
  
)
STUDENT_COL_NAME_CLEAN <- c(
  "Census_Year","HEI_Code","Administrative_Structure","Academic_Status","Course_Code",
  "Course_Mode","Course_International_Code","Course_Type", "Student_Code",
  "Student_Course_Origin","Student_Enrollment_Situation","Student_Financial_Aid",
  "Student_New"
)

Clean_Sudent <- function(RAW_STUDENT,IMPORT=FALSE){
  if (IMPORT) {
    RAW_STUDENT<-Import_Data(c(RAW_STUDENT))[[1]]
  }
  if(!is.data.table(RAW_STUDENT)){
    print("Raw Student input is not a Data.Table")
    stop()
  }
  
  CLEAN_STUDENT <- RAW_STUDENT[TP_NIVEL_ACADEMICO==1,..STUDENT_COL_NAME_RAW]
  setnames(CLEAN_STUDENT,old= STUDENT_COL_NAME_RAW,new=STUDENT_COL_NAME_CLEAN)
  
  
  CLEAN_STUDENT<-Factor_Student(CLEAN_STUDENT)
  
  rm(RAW_STUDENT)
  
  return(CLEAN_STUDENT)
}

Clean_Student_List <- function(RAW_STUDENT_LIST,IMPORT=FALSE) {
  output<- list()
  
  for (i in 1:length(RAW_STUDENT_LIST)) {
    
    DT<-Clean_Sudent(RAW_STUDENT_LIST[[i]],IMPORT)
    output[[as.character(DT[1,Census_Year])]]<-DT 
    
  }
  return(output)
}
