# games programs

GAMES_GENERAL



#Active Students by HEI #1
GAMES_GENERAL['Students_By_HEI'] <- list( GENERAL_STUDENTS$`2019`[Course_International_Code == '0613J01' &
  Student_Enrollment_Situation  == 'Active',
  .(Students = .N),by= .(Administrative_Structure, HEI_Code)])

#Active HEIs by Type 
GAMES_GENERAL$HEIs_By_Type <- list(
  GENERAL_STUDENTS$`2019`[
  Course_International_Code == '0613J01' &
    Student_Enrollment_Situation  =='Active',
    .(Students = .N),
    by= .(Administrative_Structure, HEI_Code)][
      ,.(HEIs = .N),by = Administrative_Structure
    ]
  )

#Active programs
GAMES_GENERAL$Progs_all <- list(
  GENERAL_STUDENTS$`2019`[Course_International_Code == '0613J01' &
    Student_Enrollment_Situation  =='Active',
    .(Students = .N), by= .(Administrative_Structure, Course_Code)]
  )


#Programs by HEI type
GAMES_GENERAL$Progs_By_Type <- list(
  GENERAL_STUDENTS$`2019`[
  Course_International_Code == '0613J01' &
  Student_Enrollment_Situation  =='Active',.(Students = .N), 
  by= .(Administrative_Structure, Course_Code)][,.N, 
                                                by = Administrative_Structure]
  )




