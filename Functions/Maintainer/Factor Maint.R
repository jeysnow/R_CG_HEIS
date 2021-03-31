#factor Maint
Factor_Maint <- function(CLEAN_MAINT) {
  if(names(CLEAN_MAINT)[1]!="Maintainer_Code"){
    print("Factor_Maint received Clean Maint data with wrong headers. Was it cleaned?")
    stop()
  }
  
  setkey(CLEAN_MAINT,"Maintainer_Code")
  
  CLEAN_MAINT[,Revenue_Category := 
                factor( sapply(Total_Revenue, function(x){
                  if(x<360000){
                    return("Micro")
                    
                  }
                  if(x<4800000){
                    return("Small")
                  }
                  if(x<300000000){
                    return("Medium")
                  }
                  else return("Large")
                }
                )
                )
  ]
  
  return(CLEAN_MAINT)
  
}
