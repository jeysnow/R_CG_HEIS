#normalize_names_Student
Normalize_Names_Student <- function(NAMES_VECTOR,NAMES_NORMAL) {
  if (!is.vector(NAMES_VECTOR)) {
    print("Normalize_Names_Student received names that are not a vector")
    stop()
  }
  
  
  target_names <- setdiff(NAMES_NORMAL,NAMES_VECTOR)
  if(length(target_names)==0){
    return(NAMES_VECTOR)
  }
  
  substituted<-0
  for (name in target_names) {
    
    switch (name,
      "ID_ALUNO" = {
        found<-FALSE
        for (i in 1: length(NAMES_VECTOR)) {
          if (NAMES_VECTOR[i]=="CO_ALUNO") {
            NAMES_VECTOR[i]<- "ID_ALUNO"
            found<-TRUE
            substituted<-substituted+1
            break
          }
        }
        if(!found){
          print("Could not find suitable substitute for ID_ALUNO")
          stop()
        }
        
      }
    )
    
    
  }
  if(substituted==length(target_names)){
    return(NAMES_VECTOR)
  }
  else{
    print("Not all required names were matched by Normalize_Names_Student ")
    stop()
  }
}
