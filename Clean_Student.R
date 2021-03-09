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



CLEAN_STUDENT_2019 <- RAW_STUDENT_2019[,..STUDENT_COL_NAME_RAW]
setnames(CLEAN_STUDENT_2019,old= STUDENT_COL_NAME_RAW,new=STUDENT_COL_NAME_CLEAN)
  