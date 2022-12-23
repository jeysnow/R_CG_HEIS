#functions for lists

List_Update <- function(LIST_OLD,LIST_NEW,OVERWRITE=TRUE,APPEND=TRUE) {
  if (!is.list(LIST_OLD)|!is.list(LIST_NEW)) {
    print("List update received input that was not a list")
    stop()
  }
  if (length(names(LIST_NEW))!=length(LIST_NEW)) {
    print("New List has elements without a name")
    stop()
  }
  
  
  new_names<-setdiff(names(LIST_NEW),names(LIST_OLD))
  existing_names <-setdiff(names(LIST_NEW),new_names)

  
  if (length(new_names)>0&APPEND) {
    #append the new stuff to the old list    
    for (name in new_names) {
      LIST_OLD<-append(LIST_OLD,LIST_NEW[name])
    }
  }
  if (length(existing_names)>0&OVERWRITE) {
    for (name in existing_names) {
      LIST_OLD[name] <- LIST_NEW[name]
    }
  }
  return(LIST_OLD)
}

