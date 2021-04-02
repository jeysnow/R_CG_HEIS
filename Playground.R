IGC_16_18<- fread("../Data/Raw_Data/IGC/IGC_2017.csv",header = TRUE,dec = ",")

teste<- Clean_Maintainer(GENERAL_HEIS[[3]])



GENERAL_MAINTAINERS<- List_Update(GENERAL_MAINTAINERS, Clean_Maint_List(GENERAL_HEIS[-1]))
is.na<-1
test<-c(3,3,3,3,3,3,3,3,3 )
is.na(test)<-c(1:10)
test2<-na.exclude(test)
test2

sum(unique(test),na.rm = TRUE)
