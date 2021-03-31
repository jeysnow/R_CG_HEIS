IGC_16_18<- fread("../Data/IGC_16_18.csv")

teste<-Clean_HEI(RAW_HEIS$`2018`,GENERAL_STUDENTS$`2018`)

is.factor(teste$Administrative_Structure)

is.factor(GENERAL_STUDENTS$`2019`$Administrative_Structure)
