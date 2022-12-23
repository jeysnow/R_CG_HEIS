source("Functions/Student/Factor_Student.R")
source("Functions/Student/Normalize_Names_Student.R")

Clean_Student <- function(RAW_STUDENT,IMPORT=FALSE){
  if (IMPORT) {
    RAW_STUDENT<-Import_Data(c(RAW_STUDENT))[[1]]
  }
  Check.Raw_Student(RAW_STUDENT,"Clean_Student")
  
  NAMES_RAW <-c(
    "NU_ANO_CENSO","CO_IES","TP_CATEGORIA_ADMINISTRATIVA","TP_ORGANIZACAO_ACADEMICA",
    "CO_CURSO", "CO_CINE_ROTULO",  "TP_MODALIDADE_ENSINO","TP_GRAU_ACADEMICO","ID_ALUNO",
    "CO_ALUNO_CURSO_ORIGEM","TP_SITUACAO","IN_FINANCIAMENTO_ESTUDANTIL",
    "IN_INGRESSO_TOTAL"
    
  )
  NAMES_CLEAN <- c(
    "Census_Year","HEI_Code","Administrative_Structure","Academic_Status","Course_Code",
    "Course_CINE_Code", "Course_Mode","Course_Type", "Student_Code","Student_Course_Origin",
    "Student_Enrollment_Situation","Student_Financial_Aid","Student_New"
  )

  setnames(RAW_STUDENT, Normalize_Names_Student(names(RAW_STUDENT),NAMES_RAW))
  
  CLEAN_STUDENT <- RAW_STUDENT[TP_NIVEL_ACADEMICO==1,..NAMES_RAW]
  setnames(CLEAN_STUDENT,NAMES_CLEAN)
  
  
  CLEAN_STUDENT<-Factor_Student(CLEAN_STUDENT)
  
  rm(RAW_STUDENT)
  
  return(CLEAN_STUDENT)
}

Clean_Student_List <- function(RAW_STUDENT_LIST,IMPORT=FALSE) {
  output<- list()
  
  for (i in 1:length(RAW_STUDENT_LIST)) {
    
    DT<-Clean_Student(RAW_STUDENT_LIST[[i]],IMPORT)
    output[[as.character(DT[1,Census_Year])]]<-DT 
    
  }
  return(output)
}
