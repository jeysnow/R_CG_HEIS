#create the GENERAL_CODES DT

#Not yet generalized for use

GENERAL_CODES <- list(
  HEI_CODE = GENERAL_HEIS$`2019`[,.(Maintainer_Code, HEI_Code,HEI_Name)],
  PROG_cODE = fread("../Data/Cods_Cine_Brasil.csv",header = TRUE)
  )
GENERAL_CODES


  
DT<- 0


