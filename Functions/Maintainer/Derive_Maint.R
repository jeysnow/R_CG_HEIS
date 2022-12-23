Derive_Maint <- function(CLEAN_MAINT) {
  CLEAN_MAINT[,Rate_Attraction:=Students_New/Students_Total]
  CLEAN_MAINT[,Rate_Retention:=Students_Cancelled/Students_Total]
  return(CLEAN_MAINT)
}
