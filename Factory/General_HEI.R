RAW_HEIS<- list.files("../Data/Raw_Data/HEI/",full.names = TRUE)

RAW_STUDENT <- list.files("../Data/Raw_Data/Student/",full.names = TRUE)

GENERAL_STUDENTS<- List_Update(GENERAL_STUDENTS,
                               Clean_Student_List(RAW_STUDENT,TRUE))

GENERAL_HEIS<- List_Update(GENERAL_HEIS,
                           Clean_HEI_List(RAW_HEIS,
                            Clean_Student_List(RAW_STUDENT)))

GENERAL_MAINTAINERS<- List_Update(GENERAL_MAINTAINERS,
                                  Clean_Maint_List(GENERAL_HEIS))


Export_Data(GENERAL_STUDENTS,"../Data/General/Students/")
Export_Data(GENERAL_HEIS,"../Data/General/HEIs/")
Export_Data(GENERAL_MAINTAINERS,"../Data/General/Maintainers/")


rm(RAW_HEIS,RAW_STUDENT)