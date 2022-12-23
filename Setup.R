Cleaning<- function(){
  rm(Setup_Requirements)
  
  rm(Temp_Source_Functions)
  rm(Setup_Functions)
  
  rm(Setup)
  rm(Cleaning)
}


Setup_Requirements <- function(){
  source("Requirements.R")
}

Setup_Functions<- function(Func_Group){
  source("./Functions/Functions_Setup.R")
  switch (Func_Group,
    "all" = for(x in Temp_Source_Functions) source(x),
    "cleaning" = for(x in Temp_Source_Functions[1:9]) source(x),
    "graphs" = for(x in Temp_Source_Functions[1:3]) source(x)
  )
}


Setup<- function(){
  
  Setup_Requirements()
  
  input <- readline("What do you want to work with? \n
           1: Everything!\n
           2: Cleaning.\n
           3: Graphs n stuff")
  
  switch (input,
    "1" = Setup_Functions("all"), 
    "2" = Setup_Functions("cleaning"), 
    "3" = Setup_Functions("graphs"),
    print("wrong input, try again")
  )
  
}
Setup()