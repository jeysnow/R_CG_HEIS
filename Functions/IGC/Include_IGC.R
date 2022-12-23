Include_IGC <- function(CLEAN_HEI,IGC,IMPORT=FALSE) {
  if (!is.data.table(CLEAN_HEI)) {
    print("Include_IGC received CLEAN_HEI data that was not a data.table")
    stop()
  }
  Check.Clean_HEI(CLEAN_HEI)
  
  if (IMPORT) {
    if (!file.exists(IGC)) {
      print("Include_IGC received an inexistent file path to import")
      stop()
    }
    IGC<-fread(IGC,header = TRUE,dec = ",")
  }
  if (names(IGC)[1]!="Ano") {
    print("Include_IGC received IGC data with wrong header")
    stop()
  }
  
  #Clean IGC
  NAMES_RAW <- c("Ano", "Código da IES","Nº de Cursos com CPC no triênio",
                 "Alfa (Proporção de Graduação)", "Conceito Médio de Graduação",
                 "IGC (Contínuo)", "IGC (Faixa)")
  
  NAMES_CLEAN<- c("Evaluation_Year","HEI_Code","N_Courses_Eval","Grad_Alfa",
                  "Grad_Mean","IGC_Continuous","IGC_Level")
  
  IGC<-IGC[,..NAMES_RAW]
  setnames(IGC,NAMES_CLEAN)
  setkey(IGC,"HEI_Code")
  
  IGC[,IGC_Level:=as.numeric(IGC_Level) ]
  
  #merge
  CLEAN_HEI<-IGC[CLEAN_HEI,on="HEI_Code"]
  
  
  return(CLEAN_HEI)
}

Include_IGC_List <- function(CLEAN_HEI_LIST,IGC_LIST,IMPORT=FALSE) {
  if (!is.list(CLEAN_HEI_LIST)) {
    print("Include_IGC_List received HEI data that is not a list")
    stop()
  }
  if (IMPORT) {
    for (PATH in IGC_LIST) {
      if (!file.exists(PATH)) {
        print(paste("the following path provided to Include_IGC_List 
                    doesn't exist",PATH))
        stop()
      }
      print(paste("Checked IGC file for the year",Extract_Path_Year(PATH)))
    }  
  }
  if (length(CLEAN_HEI_LIST)!=length(IGC_LIST)) {
    print("Include IGC List received two lists of differing sizes")
    stop()
  }  
  #create names for import list
  
  if (IMPORT) {
    named_list<- list()
    
    for (PATH in IGC_LIST) {
      named_list[Extract_Path_Year(PATH)]<-PATH
    }
    IGC_LIST<-named_list
  }
  
  output<- list()
  
  for (NAME in names(CLEAN_HEI_LIST)) {
    
    output[[NAME]]<- Include_IGC(CLEAN_HEI_LIST[[NAME]],
                                         IGC_LIST[[NAME]],IMPORT)
  }
  
  return(output)
}
