CLEAN_P_HEI_2019 <- CLEAN_HEI_2019[ 
  Administrative_Structure == "Private_for_profit"
  | Administrative_Structure == "Private_nonprofit"
]

CLEAN_P_OWNERS_2019 <-CLEAN_OWNER_2019[
  HEI_Types=="Private_for_profit, Private_nonprofit"
  |HEI_Types=="Private_for_profit"
  |HEI_Types=="Private_nonprofit"
  ]

Clean_Private <- function(CLEAN_DT){
  if(names(CLEAN_DT)[1]=="HEI_Code"){
    
    #Code for cleaning HEIS
    return(CLEAN_DT[ 
        Administrative_Structure == "Private_for_profit"
        | Administrative_Structure == "Private_nonprofit"])
  }
  
  else if(names(CLEAN_DT)[1]=="Maintainer_Code"){
    
    #Code for cleaning Maintainers
    return(CLEAN_DT[
      HEI_Types=="Private_for_profit, Private_nonprofit"
      |HEI_Types=="Private_for_profit"
      |HEI_Types=="Private_nonprofit"
    ])
  }
  else{
    warning("Clean_Private received Clean DT data with wrong headers. Was it cleaned?")
    stop()
  }
}
