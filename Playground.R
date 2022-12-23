#old stuf------------

IGC_16_18<- fread("../Data/Raw_Data/IGC/IGC_2017.csv",header = TRUE,dec = ",")

PRIVATE_HEIS$`2019`

lala <- sample(PRIVATE_HEIS$`2019`$HEI_Code,4)
lala
PRIVATE_HEIS$`2019`[sample(1:length(HEI_Code),4)]

sum(unique(test),na.rm = TRUE)


to_Print <- PRIVATE_MAINTAINERS$`2019`[,.(Maintainer_Code,HEI_NAME)]
fwrite(to_Print,"/Data/Maintainer_List.csv", sep = "|")

to_Print <- PRIVATE_HEIS$`2019`[sample(1:length(HEI_Code),400)]
fwrite(to_Print,"/Data/Private_HEIs_Sample.csv", sep = "|")


#games stuff ---------------------------------------

test <- setorder(GAMES_GENERAL$Students_By_HEI,Administrative_Structure)
test$

GAMES_GENERAL$Students_By_HEI[Administrative_Structure=='']

test[1:9]
GENERAL_CODES$HEI_CODE

a <- test[GENERAL_CODES$HEI_CODE, on= .(HEI_Code = HEI_Code)]
a <- a[Students>0]
a <- setorder(a,Administrative_Structure)

Games_Pub_HEIs_Names <- a[1:9]
Games_Pub_HEIs_Names





#exploratory HEIs tables---------
GENERAL_HEIS$`2019`[,
                    .(Mean_Students = mean(Students_Total),SD_Students = sd(Students_Total),
                      Mean_Rev = mean(Total_Revenue), SD_Rev = sd(Total_Revenue),
                      Mean_Exp = mean(Total_Expense), SD_Exp = sd(Total_Expense)),
                    by = .(Administrative_Structure)]
GENERAL_HEIS$`2019`[,
                    .(Mean_Students = mean(Students_Total),
                      SD = sd(Students_Total),
                      min = min(Students_Total),
                      max = max(Students_Total)
                    ),
                    by = .(Administrative_Structure)]
Large_HEIs <- setorder(GENERAL_HEIS$`2019`[Students_Total>100000,
                                           .(HEI_Name,Administrative_Structure,Students_Total)],
                       cols = "Students_Total")
Large_HEIs

GENERAL_HEIS$`2019`[Students_Total<10,
                    .(HEI_Name,Administrative_Structure,Students_Total)]

#GGPlot test---------------
plot_test <- GENERAL_HEIS$`2019`[,.(Administrative_Structure,Students_Total)]
ggplot(plot_test, aes(Students_Total, colour = Administrative_Structure
                       ))+ geom_density()+scale_x_continuous(trans = 'log')

plot_test <- GENERAL_HEIS$`2019`[,.(Administrative_Structure,Total_Revenue)]
ggplot(plot_test, aes(Total_Revenue,
                      colour = Administrative_Structure))+ geom_density()+scale_x_continuous(trans = "log")

#maint codes-------
lala <- fread("../Data/Maint codes.csv",header = TRUE)

GENERAL_CODES <- list(MAINTS = lala,
               HEIS = GENERAL_CODES$HEI_CODE,
               PROGRAM = GENERAL_CODES$PROG_cODE
               )

#importing programs
temp_students <- Import_Data("D:/Data/CENSUP/Raw_Data/Student/SUP_ALUNO_2019.CSV")
temp_students <- Clean_Student(temp_students[[1]])

temp_students[,Courses_CINE := Derive_HEI.concat(levels(Course_CINE_Code)), by= HEI_Code]

temp_students[1,Courses_CINE]



temp_HEIs <- Import_Data("D:/Data/CENSUP/Raw_Data/HEI/SUP_IES_2019.CSV")



test <- Clean_HEI(temp_HEIs[[1]], temp_students)

#The codes in the student census are the unique codes for each program, 
#not the general code found in GENERAL_CODE$PROG_cODE

GENERAL_CODES$PROG_cODE[codigo %in% test]



#Current fun -----------


