# ITSC dataset loading.
#
# This function loads the dataset from the directory containing the cropped signal files into a data frame.
#
# Parameters:
#   - path_root: Path to the directory with the cropped signal files.
# 
# Returns:
#   - A data frame containing the loaded dataset.
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

# Example usage:
db<-load_data_cropped("~/Engines")
ind1<-db$class=="SC_HLT"
ind2<-db$rep==4
tmp<-db$t[ind1&ind2]
pA<-db$A[ind1&ind2]
pB<-db$B[ind1&ind2]
pC<-db$C[ind1&ind2]
nm<-150;
plot(tmp[1:nm], pA[1:nm], type = "l", col = "blue", lwd = 2, main = "ITSC", xlab = "Time", ylab = "Amplitude")
lines(tmp[1:nm], pB[1:nm], col = "red")
lines(tmp[1:nm], pC[1:nm], col = "green")
legend("topright", inset=c(0, 0), legend=c("A","B", "C"), pch=c('-','-','-'),col=c("blue","red","green"), title="Phases")