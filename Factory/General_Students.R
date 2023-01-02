#Process_Raw_Students----

##Parameters----
path_origin <- list.files("D:/Data/CENSUP/Raw_Data/Student/",full.names = TRUE)[[3]]
dir_dest<- "D:/Data/CENSUP/General/Students/"


##Process----
Check.File(path_origin,"Process_Raw_Students")
Check.Dir(dir_dest,"Process_Raw_Students")



raw_students <- Import_Data(path_origin)

Check.Raw_Student(raw_students)

clean_students <- Clean_Student(raw_students)

rm(raw_students)

gc()

Export_Data(clean_students,Extract_Path_Year(path_origin),dir_dest)

rm(clean_students)
rm(path_origin)
rm(dir_dest)
gc()
