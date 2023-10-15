# ITSC dataset loading.
#
# This function loads the dataset from the directory containing the raw signal files into a data frame.
#
# Parameters:
#   - path_root: Path to the directory with the raw signal files.
# 
# Returns:
#   - A data frame containing the loaded dataset.
load_data_raw <- function(path_root){
  tmp<-seq(from = 0, by=1e-3, length.out=5000)
  path_bd <- paste(path_root, "RAW_Signals", sep='/')
  fl_nm <- list.files(path_bd, pattern='csv')
  nfiles = length(fl_nm)
  for(i1 in 1:nfiles){
    path_fl <- paste(path_bd, fl_nm[i1], sep='/')
    if(i1==1){
      db <- read.csv(path_fl,header=FALSE)
      nm <- nrow(db)
      str_cls = substr(fl_nm[i1],1,6)
      if(str_cls!="SC_HLT") str_cls = substr(fl_nm[i1],1,11)
      cls <- matrix(str_cls,nrow=nm)
      str_rep = substr(fl_nm[i1],8,10)
      if(str_cls!="SC_HLT") str_rep = substr(fl_nm[i1],13,15)
      rep <- as.double(str_rep)
      rep <- matrix(rep, nrow=nm)
      if(str_cls=="SC_HLT"){
        fA<-matrix(0, nrow=nm)
        fB<-matrix(0, nrow=nm)
        fC<-matrix(0, nrow=nm)
      }
      else{
        fA<-substr(str_cls,5,5)
        fA<-matrix(as.double(fA)*10, nrow=nm)
        fB<-substr(str_cls,8,8)
        fB<-matrix(as.double(fB)*10, nrow=nm)
        fC<-substr(str_cls,11,11)
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
      str_cls = substr(fl_nm[i1],1,6)
      if(str_cls!="SC_HLT") str_cls = substr(fl_nm[i1],1,11)
      cls <- matrix(str_cls,nrow=nm)
      str_rep = substr(fl_nm[i1],8,10)
      if(str_cls!="SC_HLT") str_rep = substr(fl_nm[i1],13,15)
      rep <- as.double(str_rep)
      rep <- matrix(rep, nrow=nm)
      if(str_cls=="SC_HLT"){
        fA<-matrix(0, nrow=nm)
        fB<-matrix(0, nrow=nm)
        fC<-matrix(0, nrow=nm)
      }
      else{
        fA<-substr(str_cls,5,5)
        fA<-matrix(as.double(fA)*10, nrow=nm)
        fB<-substr(str_cls,8,8)
        fB<-matrix(as.double(fB)*10, nrow=nm)
        fC<-substr(str_cls,11,11)
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
  return(db)
}

# Example usage:
db<-load_data_raw("~/Dropbox/Investigacion (1)/Motores/dataset")
ind1<-db$class=="SC_A0_B1_C0"
ind2<-db$rep==2
tmp<-db$t[ind1&ind2]
pA<-db$A[ind1&ind2]
pB<-db$B[ind1&ind2]
pC<-db$C[ind1&ind2]
nmi<-1000
nmf<-1150
plot(tmp[nmi:nmf], pA[nmi:nmf], type = "l", col = "blue", lwd = 2, main = "ITSC", xlab = "Time", ylab = "Amplitude")
lines(tmp[nmi:nmf], pB[nmi:nmf], col = "red")
lines(tmp[nmi:nmf], pC[nmi:nmf], col = "green")
legend("topright", inset=c(0, 0), legend=c("A","B", "C"), pch=c('-','-','-'),col=c("blue","red","green"), title="Phases")