HEI_COL_NAME_RAW <-c(
  "NU_ANO_CENSO","CO_IES","NO_IES","TP_CATEGORIA_ADMINISTRATIVA","TP_ORGANIZACAO_ACADEMICA",
  "CO_MANTENEDORA","CO_REGIAO","CO_UF","CO_MUNICIPIO","TP_REFERENTE","VL_RECEITA_PROPRIA",
  "VL_RECEITA_TRANSFERENCIA","VL_RECEITA_OUTRA","VL_DESPESA_PESSOAL_DOCENTE",
  "VL_DESPESA_PESSOAL_TECNICO","VL_DESPESA_PESSOAL_ENCARGO","VL_DESPESA_CUSTEIO",
  "VL_DESPESA_INVESTIMENTO","VL_DESPESA_PESQUISA","VL_DESPESA_OUTRA"
)
HEI_COL_NAME_CLEAN <- c(
  "Census_Year","HEI_Code","HEI_Name","Administrative_Structure","Academic_Status",
  "Maintainer_Code","Headquarters_Region","Headquarters_State","Headquarters_City",
  "Institution_Type","Own_Revenue","Transferred_Revenue","Other_Revenue",
  "Faculty_Expenses","Staff_Expenses","Social_Contribution_Expenses",
  "Cost_Expenses","Investment_Expenses","research_Expenses","Other_Expenses"  
)


Clean_HEI <- function(RAW_HEI,CLEAN_STUDENT, IMPORT=FALSE){
  if (IMPORT) {
    RAW_HEI<-Import_Data(c(RAW_HEI))[[1]]
  }
  
  if(names(RAW_HEI)[5]!="CO_MANTENEDORA"){
    warning("Clean_HEI received Raw HEI data that is not a Census imported HEI data.table")
    stop()
  }
  if(names(CLEAN_STUDENT)[9]!="Student_Code"){
    warning("Clean_HEI received student data with wrong  headers. Was it cleaned?")
    stop()
  }
  if(RAW_HEI[1,NU_ANO_CENSO]!=CLEAN_STUDENT[1,Census_Year]){
    warning("Student and HEI data census years don't match at Clean_HEI")
    stop()
  }
  
  CLEAN_HEI <- RAW_HEI[,..HEI_COL_NAME_RAW]
  setnames(CLEAN_HEI,old= HEI_COL_NAME_RAW,new=HEI_COL_NAME_CLEAN)
  setkey(CLEAN_HEI,"HEI_Code")
  
  
  CLEAN_HEI<- Derive_HEI(CLEAN_HEI,CLEAN_STUDENT)
  
  CLEAN_HEI<- Factor_HEI(CLEAN_HEI)
  
  rm(RAW_HEI)
  
  return(CLEAN_HEI)
  
}

Clean_HEI_List <- function(RAW_HEI_LIST, CLEAN_STUDENT_LIST,IMPORT=FALSE) {
  if(length(RAW_HEI_LIST)!=length(CLEAN_STUDENT_LIST)){
    warning("Clean HEI List received lists of differing lenghts")
    stop()
  }
  
  output<- list()
  for (i in 1:length(RAW_HEI_LIST)) {
    name<-"blank"
    
    if (IMPORT) {
      n<- nchar(RAW_HEI_LIST[[i]])
      name<- as.character(  substr(RAW_HEI_LIST[[i]],n-7,n-4))
      
    }
    else{
      name <- as.character( RAW_HEI_LIST[[i]][1,Census_Year] )
    }
    
    DT<-Clean_HEI(RAW_HEI_LIST[[i]],CLEAN_STUDENT_LIST[[name]], IMPORT)
    output[[name]]<- DT
    
  }
  return(output)
}
