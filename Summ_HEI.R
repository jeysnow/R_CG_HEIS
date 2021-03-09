SUMM_HEI_2019_ADM_STR <- CLEAN_HEI_2019[
  Total_Revenue>10000,
  .(
    Mean_Revenue = mean(Total_Revenue), SD_Revenue = sd(Total_Revenue),
    Mean_Expense = mean(Total_Expense), SD_Expense = sd(Total_Expense),
    Mean_Profit = mean(Profit), SD_Profit = sd(Profit)
  ),
  by= Administrative_Structure
  ]

SUMM_HEI_2019_ADM_STR <- SUMM_HEI_2019_ADM_STR[CLEAN_HEI_2019[,
  .(
    Mean_Students = mean(Students_Total), SD_Students = sd(Students_Total)
  ),
  by= Administrative_Structure],on="Administrative_Structure"]
