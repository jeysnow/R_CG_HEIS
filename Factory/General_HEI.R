
#Process_Raw_HEIs-----

##Parameters----
path_origin <- list.files("D:/Data/CENSUP/Raw_Data/HEI/",full.names = TRUE)[[3]]
dir_dest<- "D:/Data/CENSUP/General/HEIs/"
path_origin_student <- list.files("D:/Data/CENSUP/General/Students/",full.names = TRUE)[[3]]

##Process----
Check.File(path_origin,"Process_Raw_HEIs")
Check.File(path_origin_student,"Process_Raw_HEIs")
Check.Dir(dir_dest,"Process_Raw_HEIs")


clean_student <- Import_Data(path_origin_student) %>% Factor_Student()

raw_HEI <- Import_Data(path_origin)

clean_HEI <- Clean_HEI(raw_HEI,clean_student)

rm(raw_HEI)
rm(clean_student)
gc()

Export_Data(clean_HEI,Extract_Path_Year(path_origin),dir_dest)

rm(clean_HEI)



#redesign the factory to save successful parts when mass importing
#Take out the import option

#processing students-----
importing_paths <- list.files("D:/Data/CENSUP/Raw_Data/Student/",full.names = TRUE)


##to be tested------
for (i in 1:length(importing_paths)) {
  #print(importing_paths[[i]])
  clean_student <- Clean_Student(importing_paths[[i]], TRUE)
  importing_results[i]<- clean_student
}

##previous functioning-----
Steps<-list()
Steps[[1]]<- Import_Directory("D:/Data/CENSUP/Raw_Data/Student/")
Steps[[2]]<- Clean_Student_List(Steps[[1]])
GENERAL_STUDENTS<- List_Update(GENERAL_STUDENTS, Steps[[2]],OVERWRITE = TRUE)
rm(Steps)

#Importing HEIs-----
Steps<-list()
Steps[[1]]<- Import_Directory("D:/Data/CENSUP/Raw_Data/HEI/")
Steps[[2]]<- Clean_HEI_List(Steps[[1]],GENERAL_STUDENTS)
GENERAL_HEIS<- List_Update(GENERAL_HEIS,Steps[[2]],OVERWRITE = TRUE)
rm(Steps)



#Importing IGC nOT NECESSARY FOR NOW
Steps<-list()
Steps[[1]]<- Import_Directory("D:/Data/CENSUP/Raw_Data/IGC/")
Steps[[2]]<- Include_IGC_List(GENERAL_HEIS,Steps[[1]])
GENERAL_HEIS<- List_Update(GENERAL_HEIS,Steps[[2]],OVERWRITE = TRUE)
rm(Steps)


                           
#not for now
GENERAL_MAINTAINERS<- List_Update(GENERAL_MAINTAINERS,
                                  Clean_Maint_List(GENERAL_HEIS))

#Exporting
Export_Data(GENERAL_STUDENTS,"D:/Data/CENSUP/General/Students/")
Export_Data(GENERAL_HEIS,"D:/Data/CENSUP/General/HEIs/")
Export_Data(GENERAL_MAINT,"D:/Data/CENSUP/General/Maintainers/")

#Clean memory
rm(GENERAL_STUDENTS)
rm(GENERAL_HEIS)
rm(GENERAL_MAINT)