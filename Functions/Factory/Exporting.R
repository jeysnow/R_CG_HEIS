Export_Data <- function(DATA_VECTOR,DIR_PATH) {
  if(!dir.exists(DIR_PATH)){
    warning(paste("Following path does no exist",DIR_PATH))
    stop()
  }
  for (DATA in DATA_VECTOR) {
    if (!is.data.table(DATA)) {
      warning("not all data sent to Export Data is on the Data.table format")
      stop()
    }
  }
  
  for (i in 1:length(DATA_VECTOR)) {
    
    file_path<- paste(DIR_PATH,names(DATA_VECTOR[i]),".csv",sep = "")
    fwrite(DATA_VECTOR[[i]],file = file_path)
  }
  
}
