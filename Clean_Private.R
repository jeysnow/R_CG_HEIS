CLEAN_P_HEI_2019 <- CLEAN_HEI_2019[ 
  Administrative_Structure == "Private_for_profit"
  | Administrative_Structure == "Private_nonprofit"
]

CLEAN_P_OWNERS_2019 <-CLEAN_OWNER_2019[
  HEI_Types=="Private_for_profit, Private_nonprofit"
  |HEI_Types=="Private_for_profit"
  |HEI_Types=="Private_nonprofit"
  ]
