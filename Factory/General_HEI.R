


#redesign the factory to save successful parts when mass importing
#Take out the import option

#Importing students
Steps<-list()
Steps[[1]]<- Import_Directory("../Data/Raw_Data/Student/")
Steps[[2]]<- Clean_Student_List(Steps[[1]])
GENERAL_STUDENTS<- List_Update(GENERAL_STUDENTS, Steps[[2]],OVERWRITE = TRUE)
rm(Steps)

#Importing HEIs
Steps<-list()
Steps[[1]]<- Import_Directory("../Data/Raw_Data/HEI/")
Steps[[2]]<- Clean_HEI_List(Steps[[1]],GENERAL_STUDENTS)
GENERAL_HEIS<- List_Update(GENERAL_HEIS,Steps[[2]],OVERWRITE = TRUE)
rm(Steps)



#Importing IGC nOT NECESSARY FOR NOW
Steps<-list()
Steps[[1]]<- Import_Directory("../Data/Raw_Data/IGC/")
Steps[[2]]<- Include_IGC_List(GENERAL_HEIS,Steps[[1]])
GENERAL_HEIS<- List_Update(GENERAL_HEIS,Steps[[2]],OVERWRITE = TRUE)
rm(Steps)


                           
#not for now
GENERAL_MAINTAINERS<- List_Update(GENERAL_MAINTAINERS,
                                  Clean_Maint_List(GENERAL_HEIS))

#Exporting
Export_Data(GENERAL_STUDENTS,"../Data/General/Students/")
Export_Data(GENERAL_HEIS,"../Data/General/HEIs/")
Export_Data(GENERAL_MAINT,"../Data/General/Maintainers/")

#Clean memory
rm(GENERAL_STUDENTS)
rm(GENERAL_HEIS)
rm(GENERAL_MAINT)