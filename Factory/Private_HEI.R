#clean Private HEI Factory

teste<- Clean_HEI_List(RAW_HEIS,Clean_Student_List(RAW_STUDENT))

Export_Data(teste,"../Data/Private/HEIs/")

Export_Data(
  Clean_Private(Clean_HEI(RAW_HEIS$`2019`,Clean_Sudent(RAW_STUDENT$`2019`))),
  "../Data/Private/HEIs/"
)
