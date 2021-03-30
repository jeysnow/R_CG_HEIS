#clean Private HEI Factory
RAW_HEIS<- Import_Data(c(
  "../Data/SUP_IES_2019.CSV"))

RAW_STUDENT <- Import_Data(c(
  "../Data/SUP_ALUNO_2019.CSV"
))

PRIVATE_STUDENTS<- Clean_private_List(Clean_Student_List(RAW_STUDENT))
PRIVATE_HEIS<- Clean_private_List(Clean_HEI_List(RAW_HEIS,PRIVATE_STUDENTS))
PRIVATE_MAINTAINERS<- Clean_private_List(Clean_Maint_List(PRIVATE_HEIS))


Export_Data(PRIVATE_STUDENTS,"../Data/Private/Students/")
Export_Data(PRIVATE_HEIS,"../Data/Private/HEIs/")
Export_Data(PRIVATE_MAINTAINERS,"../Data/Private/Maintainers/")


rm(RAW_HEIS,RAW_STUDENT)
