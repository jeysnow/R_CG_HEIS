source("Functions/HEI/Derive_HEI.R")
source("Functions/HEI/Factor_HEI.R")

Clean_HEI <- function(RAW_HEI,CLEAN_STUDENT, IMPORT=FALSE){
  if (IMPORT) {
    RAW_HEI<-Import_Data(c(RAW_HEI))[[1]]
  }
  
  if(!"CO_MANTENEDORA"%in%names(RAW_HEI)){
    print("Clean_HEI received Raw HEI data that is not a Census imported HEI data.table")
    stop()
  }
  if(!"Student_Code"%in%names(CLEAN_STUDENT)){
    print("Clean_HEI received student data with wrong  headers. Was it cleaned?")
    stop()
  }
  if(RAW_HEI[1,NU_ANO_CENSO]!=CLEAN_STUDENT[1,Census_Year]){
    print("Student and HEI data census years don't match at Clean_HEI")
    stop()
  }
  

  NAMES_RAW <-c(
    "NU_ANO_CENSO","CO_IES","NO_IES","TP_CATEGORIA_ADMINISTRATIVA","TP_ORGANIZACAO_ACADEMICA",
    "CO_MANTENEDORA","CO_REGIAO","CO_UF","CO_MUNICIPIO","TP_REFERENTE","VL_RECEITA_PROPRIA",
    "VL_RECEITA_TRANSFERENCIA","VL_RECEITA_OUTRA","VL_DESPESA_PESSOAL_DOCENTE",
    "VL_DESPESA_PESSOAL_TECNICO","VL_DESPESA_PESSOAL_ENCARGO","VL_DESPESA_CUSTEIO",
    "VL_DESPESA_INVESTIMENTO","VL_DESPESA_PESQUISA","VL_DESPESA_OUTRA"
  )
  
  NAMES_CLEAN <-  c(
    "Census_Year","HEI_Code","HEI_Name","Administrative_Structure","Academic_Status",
    "Maintainer_Code","Headquarters_Region","Headquarters_State","Headquarters_City",
    "Institution_Type","Own_Revenue","Transferred_Revenue","Other_Revenue",
    "Faculty_Expenses","Staff_Expenses","Social_Contribution_Expenses",
    "Cost_Expenses","Investment_Expenses","research_Expenses","Other_Expenses"  
  )



  CLEAN_HEI <- RAW_HEI[,..NAMES_RAW]
  setnames(CLEAN_HEI,old= NAMES_RAW,new=NAMES_CLEAN)
  setkey(CLEAN_HEI,"HEI_Code")
  
  
  CLEAN_HEI<- Derive_HEI(CLEAN_HEI,CLEAN_STUDENT)
  
  CLEAN_HEI<- Factor_HEI(CLEAN_HEI)
  
  return(CLEAN_HEI)
  
}

Clean_HEI_List <- function(RAW_HEI_LIST, CLEAN_STUDENT_LIST,IMPORT=FALSE) {
  if(length(RAW_HEI_LIST)!=length(CLEAN_STUDENT_LIST)){
    warning("Clean HEI List received lists of differing lengths")
    stop()
  }
  
  output<- list()
  for (i in 1:length(RAW_HEI_LIST)) {
    name<-"blank"
    
    if (IMPORT) {
      name<- Extract_Path_Year(RAW_HEI_LIST[[i]])
      
    }
    else{
      name <- as.character( RAW_HEI_LIST[[i]][1,NU_ANO_CENSO] )
    }
    
    DT<-Clean_HEI(RAW_HEI_LIST[[i]],CLEAN_STUDENT_LIST[[name]], IMPORT)
    output[[name]]<- DT
    
  }
  return(output)
}
