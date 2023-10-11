load_data_cropped <- function(path_root){

  tmp<-seq(from = 0, by=1e-3, length.out=1000)
  path_bd <- paste(path_root, "dataset", "Cropped_Signals_SF", sep='/')
  
  folders <- list.files(path_bd)
  nfolders = length(folders)
  for(i1 in 1:nfolders){
    path_dir <- paste(path_bd, folders[i1], sep='/')
    fl_nm <- list.files(path_dir, pattern='csv')
    nfl_m <- length(fl_nm)
    for(i2 in 1:nfl_m){
      path_fl <- paste(path_dir, fl_nm[i2], sep='/')
      if(i1==1&i2==1){
        db <- read.csv(path_fl,header=FALSE)
        nm <- nrow(db)
        cls <- matrix(folders[i1],nrow=nm)
        rep <- matrix(i2, nrow=nm)
        if(folders[i1]=="SC_HLT"){
          fA<-matrix(0, nrow=nm)
          fB<-matrix(0, nrow=nm)
          fC<-matrix(0, nrow=nm)
        }
        else{
          fA<-substr(folders[i1],5,5)
          fA<-matrix(as.double(fA)*10, nrow=nm)
          fB<-substr(folders[i1],8,8)
          fB<-matrix(as.double(fB)*10, nrow=nm)
          fC<-substr(folders[i1],11,11)
          fC<-matrix(as.double(fC)*10, nrow=nm)
        }
        db <- cbind(tmp, db)
        db <- cbind(fC, db)
        db <- cbind(fB, db)
        db <- cbind(fA, db)
        db <- cbind(rep, db)
        db <- cbind(cls, db)
        colnames(db) = c('class','rep','fA','fB','fC','t','A','B','C')
      }
      else{
        data <- read.csv(path_fl,header=FALSE)
        nm <- nrow(data)
        cls <- matrix(folders[i1],nrow=nm)
        rep <- matrix(i2, nrow=nm)
        if(folders[i1]=="SC_HLT"){
          fA<-matrix(0, nrow=nm)
          fB<-matrix(0, nrow=nm)
          fC<-matrix(0, nrow=nm)
        }
        else{
          fA<-substr(folders[i1],5,5)
          fA<-matrix(as.double(fA)*10, nrow=nm)
          fB<-substr(folders[i1],8,8)
          fB<-matrix(as.double(fB)*10, nrow=nm)
          fC<-substr(folders[i1],11,11)
          fC<-matrix(as.double(fC)*10, nrow=nm)
        }
        data <- cbind(tmp, data)
        data <- cbind(fC, data)
        data <- cbind(fB, data)
        data <- cbind(fA, data)
        data <- cbind(rep, data)
        data <- cbind(cls, data)
        colnames(data) = c('class','rep','fA','fB','fC','t','A','B','C')      
        db <- rbind(db,data)
      }
    }
  }
  return(db)
}