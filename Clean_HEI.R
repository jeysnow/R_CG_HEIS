HEI_COL_NAME_RAW <-c(
  "NU_ANO_CENSO","CO_IES","TP_CATEGORIA_ADMINISTRATIVA","TP_ORGANIZACAO_ACADEMICA",
  "CO_MANTENEDORA","CO_REGIAO","CO_UF","CO_MUNICIPIO","TP_REFERENTE","VL_RECEITA_PROPRIA",
  "VL_RECEITA_TRANSFERENCIA","VL_RECEITA_OUTRA","VL_DESPESA_PESSOAL_DOCENTE",
  "VL_DESPESA_PESSOAL_TECNICO","VL_DESPESA_PESSOAL_ENCARGO","VL_DESPESA_CUSTEIO",
  "VL_DESPESA_INVESTIMENTO","VL_DESPESA_PESQUISA","VL_DESPESA_OUTRA"
)
HEI_COL_NAME_CLEAN <- c(
  "Census_Year","HEI_Code","Administrative_Structure","Academic_Status",
  "Owner_Code","Headquarters_Region","Headquarters_State","Headquarters_City",
  "Institution_Type","Own_Revenue","Transferred_Revenue","Other_Revenue",
  "Faculty_Expenses","Staff_Expenses","Social_Contribution_Expenses",
  "Cost_Expenses","Investment_Expenses","research_Expenses","Other_Expenses"  
)



CLEAN_HEI_2019 <- RAW_HEI_2019[,..HEI_COL_NAME_RAW]
setnames(CLEAN_HEI_2019,old= HEI_COL_NAME_RAW,new=HEI_COL_NAME_CLEAN)

CLEAN_HEI_2019[,Administrative_Structure:=factor(
  as.factor(Administrative_Structure),levels = 1:9,
  labels =  c("Federally_Owned","State_Owned","Municipally_Owned","Private_for_profit",
    "Private_nonprofit","Private_strictly","Special","Comunity_Owned","Confessional")
  )]

CLEAN_HEI_2019[,Academic_Status:=factor(
  as.factor(Academic_Status),levels = 1:5,
  labels =  c("University","University_Center","Faculty",
              "Federal_Institute","Federal_Center")
)]

CLEAN_HEI_2019[,Total_Revenue:= Own_Revenue+Transferred_Revenue+Other_Revenue]

CLEAN_HEI_2019[,Total_Expense:=Faculty_Expenses+Staff_Expenses+research_Expenses
               +Other_Expenses+Social_Contribution_Expenses+Investment_Expenses
               +Cost_Expenses]
CLEAN_HEI_2019[,Profit:=Total_Revenue - Total_Expense]


CLEAN_HEI_2019<-CLEAN_HEI_2019[CLEAN_STUDENT_2019[, .N,HEI_Code],on="HEI_Code"]
setnames(CLEAN_HEI_2019,"N","Students_Total")
