Export_Data<- function(DT,FILE_NAME, DIR_PATH){
  Check.DT(DT,"Export_Data")
  Check.Dir(DIR_PATH,"Export_Data")
  
  
  file_path<- paste(DIR_PATH,FILE_NAME,".csv",sep = "")
  fwrite(DT,file = file_path)
  
}

Export_Data_Vector <- function(DATA_VECTOR,DIR_PATH) {
  Check.Dir(DIR_PATH,"Export_Data_Vector")
  
  for (DATA in DATA_VECTOR) {
    if (!is.data.table(DATA)) {
      warning("not all data sent to Export Data is on the Data.table format")
      stop()
    }
  }
  
  for (i in 1:length(DATA_VECTOR)) {
    Export_Data(DATA_VECTOR[[i]],names(DATA_VECTOR[i]),DIR_PATH)
  }
  
}
