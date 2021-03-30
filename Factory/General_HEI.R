RAW_HEIS<- Import_Data(c(
  "../Data/SUP_IES_2019.CSV"))

RAW_STUDENT <- Import_Data(c(
  "../Data/SUP_ALUNO_2019.CSV"
))

GENERAL_STUDENTS<- Clean_Student_List(RAW_STUDENT)
GENERAL_HEIS<- Clean_HEI_List(RAW_HEIS,GENERAL_STUDENTS)
GENERAL_MAINTAINERS<- Clean_Maint_List(GENERAL_HEIS)


Export_Data(GENERAL_STUDENTS,"../Data/General/Students/")
Export_Data(GENERAL_HEIS,"../Data/General/HEIs/")
Export_Data(GENERAL_MAINTAINERS,"../Data/General/Maintainers/")


rm(RAW_HEIS,RAW_STUDENT)