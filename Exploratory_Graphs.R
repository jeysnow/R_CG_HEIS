ggplot(data = CLEAN_HEI_2019)+
  geom_bar(mapping = aes(
    x=Administrative_Structure,
    fill=Academic_Status))
           
ggplot(data = SUMM_HEI_2019_ADM_STR)+
  geom_col(mapping = aes(
    x=Administrative_Structure,
    y=c(Mean_Revenue,SD_Revenue)))
