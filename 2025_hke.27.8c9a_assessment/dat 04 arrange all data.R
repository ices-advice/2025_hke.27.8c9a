#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# SHAKE Catch, Survey and LFDs data  #
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Francisco Izquierdo #
# Marta Cousido       #
# Santiago Cervino    #
#~~~~~~~~~~~~~~~~~~~~~~
# 31/01/2022          #
#~~~~~~~~~~~~~~~~~~~~~~

## To see the outline press: Ctrl + shift + O

## This is the "dirty" script to reshape all shake available data
## Data is separated by fleets
## Data from 1928 to 2024 is included
## Note that LFD data has no zeros, so a loop transformation is applied to arrange it
## Types of data are divided in: 1) Catch, 2) Indices (surveys & CPUES) and 3) LFDs
## In the end of the script we save the 3 main csv files and the all data.RDATA 

# Clean env --------------------------------------------------------------------

## Clean environment
rm(list=ls())

library(dplyr)
library(readr)
library(plyr)
library(openxlsx)
library(conflicted)
conflicts_prefer(dplyr::filter)
conflicts_prefer(dplyr::mutate)

## Set directory
dir<-paste(getwd(), "/", sep="") # dir

# 1) Catch ---------------------------------------------------------------------

## 1948-1981 -----------------------------------------------------------------

## historical fleets (1948-1981)
#load(file=paste(dir,"input/catch/fleets ratio/output/catch historical fleets seasonal 1948-1981.RData",sep=""))

Catch_1948_1981=read.csv(file=paste(dir,"boot/data/Historical catch/catch 1948-1981.csv",sep=""), header=T)
Catch_1948_1981=Catch_1948_1981[,-1]

flt="trawlers"
c_hist_trawlers=subset(Catch_1948_1981,fleet==flt)
flt="volpal"  
c_hist_volpal=subset(Catch_1948_1981,fleet==flt)


# * save -----------------------------------------------------------------------

Catch_1948_1981<-rbind(c_hist_trawlers,c_hist_volpal)
write.csv(Catch_1948_1981, paste(dir, "data/catch/catch 1948-1981.csv", sep=""))

## 1982 - 1993 -----------------------------------------------------------------

catch_1982_1993=read.csv(file=paste(dir,"boot/data/Historical catch/catch 1982-1993.csv",sep=""), header=T)[,-1]


## ptArt ------------------------------------------------------------------------

flt<-"ptArt"
c_old_ptArt=subset(catch_1982_1993,fleet==flt)



## ptTrw ------------------------------------------------------------------------


flt<-"ptTrw"
c_old_ptTrw<-subset(catch_1982_1993,fleet==flt)

## spArt ------------------------------------------------------------------------


flt<-"spArt"

c_old_spArt<-subset(catch_1982_1993,fleet==flt)

## spTrw ------------------------------------------------------------------------


flt<-"spTrw"
c_old_spTrw<-subset(catch_1982_1993,fleet==flt)

## cdTrw ------------------------------------------------------------------------


flt<-"cdTrw"

c_old_cdTrw<-subset(catch_1982_1993,fleet==flt)[1:12,]

## volanta  ------------------------------------------------------------------------

flt<-"vol"

c_old_vol<-subset(catch_1982_1993,fleet==flt)

## palangre  ------------------------------------------------------------------------


flt<-"pal"


c_old_pal<-subset(catch_1982_1993,fleet==flt)

## seasonal  ---------------------------------------------------------------

# seasonal 

c_seas_1982_1993_trawlers=subset(catch_1982_1993,fleet=="trawlers")
c_seas_1982_1993_volpal=subset(catch_1982_1993,fleet=="volpal")
c_seas_1982_1993_art=subset(catch_1982_1993,fleet=="artisanal")
c_seas_1982_1993_cdTrw=subset(catch_1982_1993,fleet=="cdTrw")[-c(1:12),]


## * Save  ---------------------------------------------------------------------

Catch_1982_1993<-rbind(c_old_spArt, c_old_spTrw,c_old_cdTrw, c_old_vol, c_old_pal, c_old_ptArt, c_old_ptTrw, 
                       c_seas_1982_1993_trawlers, c_seas_1982_1993_volpal,c_seas_1982_1993_art,c_seas_1982_1993_cdTrw)

write.csv(Catch_1982_1993, paste(dir,"data/catch/catch 1982-1993.csv",sep=""))

## 1994 - 2024 ----------------------------------------------------------------------

## we have already arranged the 1994-2024 data from last year, so we take only the csv
library(dplyr)
c_all<-read.csv(file=paste(dir,"boot/data/Historical catch/catch 1994-2023.csv",sep=""), header=T)[,-1]

### 2024 NEW data --------------------------------------------------------------

c_2024<-read.csv(file=paste(dir,"data/catch/catchData24.csv",sep=""), header=T)
head(c_2024)

## volanta -------------------------------------------------------------------------

c_volanta<-c_all%>%filter(fleet=="volanta")
c_2024_volanta=c_2024%>%filter(fleet=="volanta")
c_volanta=rbind(c_volanta,c_2024_volanta)

tail(c_volanta)

## palangre ------------------------------------------------------------------------

c_palangre<-c_all%>%filter(fleet=="palangre")
c_2024_palangre=c_2024%>%filter(fleet=="palangre")
c_palangre=rbind(c_palangre,c_2024_palangre)
tail(c_palangre)

## baka -----------------------------------------------------------------------------

c_baka<-c_all%>%filter(fleet=="baka")
c_2024_baka=c_2024%>%filter(fleet=="baka")
c_baka=rbind(c_baka,c_2024_baka)
head(c_baka);tail(c_baka)

## cdTrw -----------------------------------------------------------------------------

c_cdTrw<-c_all%>%filter(fleet=="cdTrw")
c_2024_cdTrw=c_2024%>%filter(fleet=="cdTrw")
c_cdTrw=rbind(c_cdTrw,c_2024_cdTrw)
head(c_cdTrw);tail(c_cdTrw)

## pairTrw ---------------------------------------------------------------------------

c_pairTrw<-c_all%>%filter(fleet=="pairTrw")
c_2024_pairTrw=c_2024%>%filter(fleet=="pairTrw")
c_pairTrw=rbind(c_pairTrw,c_2024_pairTrw)
tail(c_pairTrw)

## ptTrw ---------------------------------------------------------------------------

c_ptTrw<-c_all%>%filter(fleet=="ptTrw")
c_2024_ptTrw=c_2024%>%filter(fleet=="ptTrw")
c_ptTrw=rbind(c_ptTrw,c_2024_ptTrw)
tail(c_ptTrw)

## Art ---------------------------------------------------------------------------

c_Art<-c_all%>%filter(fleet=="Art")
c_2024_Art=c_2024%>%filter(fleet=="Art")
c_Art=rbind(c_Art,c_2024_Art)
tail(c_Art)

## ptArt ---------------------------------------------------------------------------

c_ptArt<-c_all%>%filter(fleet=="ptArt")
c_2024_ptArt=c_2024%>%filter(fleet=="ptArt")
c_ptArt=rbind(c_ptArt,c_2024_ptArt)



## discards ---------------------------------------------------------------------------


c_disc<-c_all%>%filter(fleet=="disc")
tail(c_disc)
#c_disc<-c_disc[-(105:108),] # remove discards 2020 to estimate

c_2024_spDisc=c_2024%>%filter(fleet=="spDisc")
c_2024_ptDisc=c_2024%>%filter(fleet=="ptDisc")

c_2024_Disc=c_2024_ptDisc
c_2024_Disc$amount=c_2024_Disc$amount+c_2024_spDisc$amount
c_2024_Disc$fleet=rep("disc",4)

c_disc=rbind(c_disc,c_2024_Disc)

## * save  ---------------------------------------------------------------------

Catch_1994_2024<-rbind(c_Art,c_baka,c_cdTrw,c_disc,c_pairTrw,c_palangre,
                       c_ptArt,c_ptTrw,c_volanta)

write.csv(Catch_1994_2024, paste(dir,"data/catch/catch 1994-2024.csv",sep=""))



# 2) Indices --------------------------------------------------------------------------

## 1982 - 2024 -----------------------------------------------------------------

ind_all<-read.csv(file=paste(dir,"boot/data/Historical indices/indices 1982-2023.csv", sep=""))[,-1]


## SpGFS ---------------------------------------------------------------------------

ind_SpGFS<-ind_all%>%filter(index=="SpGFS") 
tail(ind_SpGFS)

### New 2024 data

library(readxl)
ind_SpGFS_2024<- read_excel(paste(dir,"boot/data/Surveys/SpGFS-WIBTS-Q4 (G2784).xlsx",sep=""),sheet="Abundance indices")

ind_SpGFS_2024=ind_SpGFS_2024[,c(1,8,9)]

ind=which(ind_SpGFS_2024[,1]==2024)

ind_SpGFS=rbind(ind_SpGFS,ind_SpGFS[1,])
ind_SpGFS[dim(ind_SpGFS)[1],1]=2024
ind_SpGFS[dim(ind_SpGFS)[1],]$obs=as.numeric(ind_SpGFS_2024[ind,][1,2])
ind_SpGFS[dim(ind_SpGFS)[1],]$se=as.numeric(ind_SpGFS_2024[ind,][1,3])

## bioCdSurv ---------------------------------------------------------------------------
ind_CdSurv<-ind_all%>%filter(index=="bioCdSurv")
tail(ind_CdSurv)

ind_CdSurv_2024<- read_excel(paste(dir,"boot/data/Surveys/SPGFScaut-WIBTS-Q4 (G4309).xlsx",sep=""),sheet="tabla años ARSA noviembre")

ind_CdSurv_2024=ind_CdSurv_2024[,c(1,4,5)]

ind=which(ind_CdSurv_2024[,1]==2024)

ind_CdSurv=rbind(ind_CdSurv,ind_CdSurv[1,])
ind_CdSurv[dim(ind_CdSurv)[1],1]=2024
ind_CdSurv[dim(ind_CdSurv)[1],]$obs=as.numeric(ind_CdSurv_2024[ind,][1,2])
ind_CdSurv[dim(ind_CdSurv)[1],]$se=as.numeric(ind_CdSurv_2024[ind,][1,3])


## PtGFS ---------------------------------------------------------------------------


ind_PtGFS<-ind_all%>%filter(index  =="PtGFS")
tail(ind_PtGFS)

### New 2024 data (no available)

# ind_PtGFS_2023<- read_excel(paste(dir,"boot/data/Surveys/ptGFS-WIBTS-Q4 (G8899).xlsx",sep=""),sheet="PT PGFS index")
# 
# ind_PtGFS_2023=ind_PtGFS_2023[,c(1,2,3)]
# 
# ind=which(ind_PtGFS_2023[,1]==2023)
# 
# value=as.numeric(ind_PtGFS_2023[ind,2:3])
# 
# ind_PtGFS=rbind(ind_PtGFS,ind_PtGFS[1,])
# ind_PtGFS[dim(ind_PtGFS)[1],1]=2023
# ind_PtGFS[dim(ind_PtGFS)[1],]$obs=value[1]
# ind_PtGFS[dim(ind_PtGFS)[1],]$se=value[2]


## SpCPUEs ---------------------------------------------------------------------------

load(paste(dir,"data/indices/ind CPUEs combined 2003-2024.RData",sep=""))

ind_SpCPUE_trawlers

ind_SpCPUE_volpal

## PtCPUE ---------------------------------------------------------------------------

# Actually not include in the model!

# ind_PtCPUE<-read.csv(paste(dir,"input/indices/new PtCPUE 2022.csv",sep=""))[,c(1,2,5)]
# ind_PtCPUE$seas<-rep(6)
# ind_PtCPUE$index<-rep("PtCPUE")
# ind_PtCPUE<-ind_PtCPUE[,c(1,4,5,2,3)]#  year, season (month), index, obs, se
# colnames(ind_PtCPUE)<-c("year","seas","index","obs","se")
# tail(ind_PtCPUE)

### * save ---------------------------------------------------------------------

Indices_1982_2024<-rbind(ind_SpGFS, ind_CdSurv, ind_PtGFS, ind_SpCPUE_trawlers, ind_SpCPUE_volpal)
write.csv(Indices_1982_2024, paste(dir,"data/indices/indices 1982-2024.csv",sep=""))

# 3) LFDs  --------------------------------------------------------------------

## 1982-1993 -------------------------------------------------------------------

LD_all <- read.csv(paste(dir,"boot/data/Historical LFDs/LFDs 1982-1993.csv",sep=""))[-1]
names(LD_all)

## spTrw ----------------------------------------------------------------------
l_o_spTrw=LD_all%>%filter(fleet=="SpTrawl")

## spArt ----------------------------------------------------------------------
l_o_spArt=LD_all%>%filter(fleet=="SpBeta")

## volanta ----------------------------------------------------------------------
l_o_vol=LD_all%>%filter(fleet=="SpVol")

## palangre ----------------------------------------------------------------------

l_o_pal=LD_all%>%filter(fleet=="SpPal")

## ptTrw ----------------------------------------------------------------------
l_o_ptTrw=LD_all%>%filter(fleet=="PtTrawl")

## ptArt ----------------------------------------------------------------------
l_o_ptArt=LD_all%>%filter(fleet=="PtArt")

##* save ----------------------------------------------------------------------

LFDs_1982_1993<-rbind(l_o_pal,l_o_ptArt,l_o_ptTrw,l_o_spArt,l_o_spTrw,l_o_vol)

write.csv(LFDs_1982_1993, paste(dir,"data/LFDs/LFDs 1982-1993.csv",sep=""))


## 1994-2024 -------------------------------------------------------------------

LFDs_all<-read.csv(file=paste(dir,"boot/data/Historical LFDs/LFDs 1994-2023.csv",sep=""), header=T)[,-1]
library(dplyr)
table(LFDs_all$fleet)

### New 2024 data --------------------------------------------------------------
LFDs_2024<-read.csv(file=paste(dir,"data/LFDs/lenDistData24.csv",sep=""), header=T)

## volanta --------------------------------------------------------------------

l_volanta<-LFDs_all%>%filter(fleet  =="vol")


### * Important check before using the arrange
l_volanta_2024<-LFDs_2024%>%filter(fleet  =="volanta")
all(diff(l_volanta_2024$step) >= 0)

#### Arrange data ----------------------------------------------------------------

library(dplyr)
nam1="vol"
nam2<-"volanta"  
tot<-LFDs_2024%>%select(year,length, fleet,number)%>%filter(fleet==nam2)

f1<-tot[,-3]
colnames(f1)<-c("year","len","number")
uyear=unique(f1[,1])
f1$len=as.numeric(f1$len)
f1$number=as.numeric(f1$number)
l_m=length(uyear);X=list()

for(l in 1:l_m){
  
  f_aux<- f1 %>%  filter(year==uyear[l])
  f2=f_aux[,c(2,3)]
  
  # we need to know how many times the incomplete sequence repeats from 0 to 130
  # calculate how many times the vector repeats
  l_aux=0
  dim1=dim(f2)[1]
  ss=1
  for(i in 1:(dim1-1)){
    if(f2$len[i+1]<f2$len[i]){
      l_aux=c(l_aux,length(f2$len[ss:i]))
      ss=i+1}
  }
  
  
  l_aux=c(l_aux[-1],dim(f2)[1]-sum(l_aux[-1]))
  l_aux
  
  new_aux=0
  len_aux=length(l_aux)
  for(i in 1:len_aux){
    new_aux=c(new_aux,rep(i,l_aux[i]))
  }
  
  new_aux=new_aux[-1]
  f2$new=new_aux# index for len aux
  
  
  f3 <- data.frame(len=rep(1:129,1))# structure we want 0-129
  library(dplyr)
  
  # LOOP for JOIN AND MATCH 0-130 l_aux times
  dat=f2[1,c(1,2)]
  dat[1,]=c(0,0)
  for(i in 1:len_aux){
    f3$len=as.numeric(f3$len)
    f2_1=subset(f2,f2$new==i)[,c(1,2)]
    f2_1$len=as.numeric(f2_1$len)
    dat1=left_join(f3, f2_1, by = "len")
    dat=rbind(dat,dat1)
  }
  
  dat=dat[-1,]
  
  # change NAs (not matches) for ZEROS
  dat
  ind<-is.na(dat$number)
  dat[ind,2]<-0
  dat$step<-sort(rep(1:4,dim(dat)[1]/4))
  dat$age<-paste("len", dat[,1], sep="")
  dat$fleet<-rep(nam1, times=length(dat[,1]))
  dat$area<-rep("area1", times=length(dat[,1]))
  dat$length<-rep("allages", times=length(dat[,1]))
  dat$year<-rep(uyear[l], times=length(dat[,1]))
  X[[l]]=dat
}

f1=rbind(X[[1]])


fleet<-f1
fleet$len_cm<-sub('len', '', fleet$age)
fleet$len_cm<-as.numeric(fleet$len_cm)
fleet$len_cm<-as.factor(fleet$len_cm)

l_volanta_2024<-fleet[ ,c(8,3,6,7,4,2,5)]


l_volanta=rbind(l_volanta,l_volanta_2024)
head(l_volanta);tail(l_volanta)

## palangre ------------------------------------------------------------------------

l_palangre<-LFDs_all%>%filter(fleet  =="palangre")
tail(l_palangre)

### * Important check before using the arrange
l_palangre_2024<-LFDs_2024%>%filter(fleet  =="palangre")
all(diff(l_palangre_2024$step) >= 0)

#### Arrange data ----------------------------------------------------------------

library(dplyr)
nam1="palangre"
nam2<-"palangre"  
tot<-LFDs_2024%>%select(year,length, fleet,number)%>%filter(fleet==nam2)

f1<-tot[,-3]
colnames(f1)<-c("year","len","number")
uyear=unique(f1[,1])
f1$len=as.numeric(f1$len)
f1$number=as.numeric(f1$number)
l_m=length(uyear);X=list()

for(l in 1:l_m){
  
  f_aux<- f1 %>%  filter(year==uyear[l])
  f2=f_aux[,c(2,3)]
  
  # necesitamos saber cuantas veces se repite de 0 a 130 la secuencia incompleta
  # calcular cuantas veces se repite el vector
  l_aux=0
  dim1=dim(f2)[1]
  ss=1
  for(i in 1:(dim1-1)){
    if(f2$len[i+1]<f2$len[i]){
      l_aux=c(l_aux,length(f2$len[ss:i]))
      ss=i+1}
  }
  
  
  l_aux=c(l_aux[-1],dim(f2)[1]-sum(l_aux[-1]))
  l_aux
  
  new_aux=0
  len_aux=length(l_aux)
  for(i in 1:len_aux){
    new_aux=c(new_aux,rep(i,l_aux[i]))
  }
  
  new_aux=new_aux[-1]
  f2$new=new_aux# index for len aux
  
  
  f3 <- data.frame(len=rep(1:129,1))# structure we want 0-129
  library(dplyr)
  
  # LOOP for JOIN AND MATCH 0-130 l_aux times
  dat=f2[1,c(1,2)]
  dat[1,]=c(0,0)
  for(i in 1:len_aux){
    f3$len=as.numeric(f3$len)
    f2_1=subset(f2,f2$new==i)[,c(1,2)]
    f2_1$len=as.numeric(f2_1$len)
    dat1=left_join(f3, f2_1, by = "len")
    dat=rbind(dat,dat1)
  }
  
  dat=dat[-1,]
  
  # change NAs (not matches) for ZEROS
  dat
  ind<-is.na(dat$number)
  dat[ind,2]<-0
  dat$step<-sort(rep(1:4,dim(dat)[1]/4))
  dat$age<-paste("len", dat[,1], sep="")
  dat$fleet<-rep(nam1, times=length(dat[,1]))
  dat$area<-rep("area1", times=length(dat[,1]))
  dat$length<-rep("allages", times=length(dat[,1]))
  dat$year<-rep(uyear[l], times=length(dat[,1]))
  X[[l]]=dat
}

f1=rbind(X[[1]])


fleet<-f1
fleet$len_cm<-sub('len', '', fleet$age)
fleet$len_cm<-as.numeric(fleet$len_cm)
fleet$len_cm<-as.factor(fleet$len_cm)

l_palangre_2024<-fleet[ ,c(8,3,6,7,4,2,5)]


l_palangre=rbind(l_palangre,l_palangre_2024)
head(l_palangre);tail(l_palangre)



## pareja ------------------------------------------------------------------------

l_pairTrw<-LFDs_all%>%filter(fleet  =="pair")
tail(l_pairTrw)

### * Important check before using the arrange
l_pairTrw_2024<-LFDs_2024%>%filter(fleet  =="pairTrw")
all(diff(l_pairTrw_2024$step) >= 0)

#### Arrange data ----------------------------------------------------------------

library(dplyr)
nam1="pair"
nam2<-"pairTrw"  
tot<-LFDs_2024%>%select(year,length, fleet,number)%>%filter(fleet==nam2)

f1<-tot[,-3]
colnames(f1)<-c("year","len","number")
uyear=unique(f1[,1])
f1$len=as.numeric(f1$len)
f1$number=as.numeric(f1$number)
l_m=length(uyear);X=list()

for(l in 1:l_m){
  
  f_aux<- f1 %>%  filter(year==uyear[l])
  f2=f_aux[,c(2,3)]
  
  # necesitamos saber cuantas veces se repite de 0 a 130 la secuencia incompleta
  # calcular cuantas veces se repite el vector
  l_aux=0
  dim1=dim(f2)[1]
  ss=1
  for(i in 1:(dim1-1)){
    if(f2$len[i+1]<f2$len[i]){
      l_aux=c(l_aux,length(f2$len[ss:i]))
      ss=i+1}
  }
  
  
  l_aux=c(l_aux[-1],dim(f2)[1]-sum(l_aux[-1]))
  l_aux
  
  new_aux=0
  len_aux=length(l_aux)
  for(i in 1:len_aux){
    new_aux=c(new_aux,rep(i,l_aux[i]))
  }
  
  new_aux=new_aux[-1]
  f2$new=new_aux# index for len aux
  
  
  f3 <- data.frame(len=rep(1:129,1))# structure we want 0-129
  library(dplyr)
  
  # LOOP for JOIN AND MATCH 0-130 l_aux times
  dat=f2[1,c(1,2)]
  dat[1,]=c(0,0)
  for(i in 1:len_aux){
    f3$len=as.numeric(f3$len)
    f2_1=subset(f2,f2$new==i)[,c(1,2)]
    f2_1$len=as.numeric(f2_1$len)
    dat1=left_join(f3, f2_1, by = "len")
    dat=rbind(dat,dat1)
  }
  
  dat=dat[-1,]
  
  # change NAs (not matches) for ZEROS
  dat
  ind<-is.na(dat$number)
  dat[ind,2]<-0
  dat$step<-sort(rep(1:4,dim(dat)[1]/4))
  dat$age<-paste("len", dat[,1], sep="")
  dat$fleet<-rep(nam1, times=length(dat[,1]))
  dat$area<-rep("area1", times=length(dat[,1]))
  dat$length<-rep("allages", times=length(dat[,1]))
  dat$year<-rep(uyear[l], times=length(dat[,1]))
  X[[l]]=dat
}

f1=rbind(X[[1]])


fleet<-f1
fleet$len_cm<-sub('len', '', fleet$age)
fleet$len_cm<-as.numeric(fleet$len_cm)
fleet$len_cm<-as.factor(fleet$len_cm)

l_pairTrw_2024<-fleet[ ,c(8,3,6,7,4,2,5)]


l_pairTrw=rbind(l_pairTrw,l_pairTrw_2024)
head(l_pairTrw);tail(l_pairTrw)



## baka -----------------------------------------------------------------------------

l_baka<-LFDs_all%>%filter(fleet  =="bakka")
tail(l_baka)


### * Important check before using the arrange
l_baka_2024<-LFDs_2024%>%filter(fleet  =="baka")
all(diff(l_baka_2024$step) >= 0)

#### Arrange data ----------------------------------------------------------------

library(dplyr)
nam1="bakka"
nam2<-"baka"  
tot<-LFDs_2024%>%select(year,length, fleet,number)%>%filter(fleet==nam2)

f1<-tot[,-3]
colnames(f1)<-c("year","len","number")
uyear=unique(f1[,1])
f1$len=as.numeric(f1$len)
f1$number=as.numeric(f1$number)
l_m=length(uyear);X=list()

for(l in 1:l_m){
  
  f_aux<- f1 %>%  filter(year==uyear[l])
  f2=f_aux[,c(2,3)]
  
  # necesitamos saber cuantas veces se repite de 0 a 130 la secuencia incompleta
  # calcular cuantas veces se repite el vector
  l_aux=0
  dim1=dim(f2)[1]
  ss=1
  for(i in 1:(dim1-1)){
    if(f2$len[i+1]<f2$len[i]){
      l_aux=c(l_aux,length(f2$len[ss:i]))
      ss=i+1}
  }
  
  
  l_aux=c(l_aux[-1],dim(f2)[1]-sum(l_aux[-1]))
  l_aux
  
  new_aux=0
  len_aux=length(l_aux)
  for(i in 1:len_aux){
    new_aux=c(new_aux,rep(i,l_aux[i]))
  }
  
  new_aux=new_aux[-1]
  f2$new=new_aux# index for len aux
  
  
  f3 <- data.frame(len=rep(1:129,1))# structure we want 0-129
  library(dplyr)
  
  # LOOP for JOIN AND MATCH 0-130 l_aux times
  dat=f2[1,c(1,2)]
  dat[1,]=c(0,0)
  for(i in 1:len_aux){
    f3$len=as.numeric(f3$len)
    f2_1=subset(f2,f2$new==i)[,c(1,2)]
    f2_1$len=as.numeric(f2_1$len)
    dat1=left_join(f3, f2_1, by = "len")
    dat=rbind(dat,dat1)
  }
  
  dat=dat[-1,]
  
  # change NAs (not matches) for ZEROS
  dat
  ind<-is.na(dat$number)
  dat[ind,2]<-0
  dat$step<-sort(rep(1:4,dim(dat)[1]/4))
  dat$age<-paste("len", dat[,1], sep="")
  dat$fleet<-rep(nam1, times=length(dat[,1]))
  dat$area<-rep("area1", times=length(dat[,1]))
  dat$length<-rep("allages", times=length(dat[,1]))
  dat$year<-rep(uyear[l], times=length(dat[,1]))
  X[[l]]=dat
}

f1=rbind(X[[1]])


fleet<-f1
fleet$len_cm<-sub('len', '', fleet$age)
fleet$len_cm<-as.numeric(fleet$len_cm)
fleet$len_cm<-as.factor(fleet$len_cm)

l_baka_2024<-fleet[ ,c(8,3,6,7,4,2,5)]


l_baka=rbind(l_baka,l_baka_2024)
head(l_baka);tail(l_baka)




## cdTrw -----------------------------------------------------------------------------

l_cdTrw<-LFDs_all%>%filter(fleet  =="cdTrw")


### * Important check before using the arrange
l_cdTrw_2024<-LFDs_2024%>%filter(fleet  =="cdTrw")
all(diff(l_cdTrw_2024$step) >= 0)

#### Arrange data ----------------------------------------------------------------

library(dplyr)
nam1="cdTrw"
nam2<-"cdTrw"  
tot<-LFDs_2024%>%select(year,length, fleet,number)%>%filter(fleet==nam2)

f1<-tot[,-3]
colnames(f1)<-c("year","len","number")
uyear=unique(f1[,1])
f1$len=as.numeric(f1$len)
f1$number=as.numeric(f1$number)
l_m=length(uyear);X=list()

for(l in 1:l_m){
  
  f_aux<- f1 %>%  filter(year==uyear[l])
  f2=f_aux[,c(2,3)]
  
  # necesitamos saber cuantas veces se repite de 0 a 130 la secuencia incompleta
  # calcular cuantas veces se repite el vector
  l_aux=0
  dim1=dim(f2)[1]
  ss=1
  for(i in 1:(dim1-1)){
    if(f2$len[i+1]<f2$len[i]){
      l_aux=c(l_aux,length(f2$len[ss:i]))
      ss=i+1}
  }
  
  
  l_aux=c(l_aux[-1],dim(f2)[1]-sum(l_aux[-1]))
  l_aux
  
  new_aux=0
  len_aux=length(l_aux)
  for(i in 1:len_aux){
    new_aux=c(new_aux,rep(i,l_aux[i]))
  }
  
  new_aux=new_aux[-1]
  f2$new=new_aux# index for len aux
  
  
  f3 <- data.frame(len=rep(1:129,1))# structure we want 0-129
  library(dplyr)
  
  # LOOP for JOIN AND MATCH 0-130 l_aux times
  dat=f2[1,c(1,2)]
  dat[1,]=c(0,0)
  for(i in 1:len_aux){
    f3$len=as.numeric(f3$len)
    f2_1=subset(f2,f2$new==i)[,c(1,2)]
    f2_1$len=as.numeric(f2_1$len)
    dat1=left_join(f3, f2_1, by = "len")
    dat=rbind(dat,dat1)
  }
  
  dat=dat[-1,]
  
  # change NAs (not matches) for ZEROS
  dat
  ind<-is.na(dat$number)
  dat[ind,2]<-0
  dat$step<-sort(rep(1:4,dim(dat)[1]/4))
  dat$age<-paste("len", dat[,1], sep="")
  dat$fleet<-rep(nam1, times=length(dat[,1]))
  dat$area<-rep("area1", times=length(dat[,1]))
  dat$length<-rep("allages", times=length(dat[,1]))
  dat$year<-rep(uyear[l], times=length(dat[,1]))
  X[[l]]=dat
}

f1=rbind(X[[1]])


fleet<-f1
fleet$len_cm<-sub('len', '', fleet$age)
fleet$len_cm<-as.numeric(fleet$len_cm)
fleet$len_cm<-as.factor(fleet$len_cm)

l_cdTrw_2024<-fleet[ ,c(8,3,6,7,4,2,5)]


l_cdTrw=rbind(l_cdTrw,l_cdTrw_2024)
head(l_cdTrw);tail(l_cdTrw)


## ptTrw ---------------------------------------------------------------------------

l_ptTrw<-LFDs_all%>%filter(fleet  =="ptTrw")
tail(l_ptTrw)


### * Important check before using the arrange
l_ptTrw_2024<-LFDs_2024%>%filter(fleet  =="ptTrw")
all(diff(l_ptTrw_2024$step) >= 0)

#### Arrange data ----------------------------------------------------------------

library(dplyr)
nam1="ptTrw"
nam2<-"ptTrw"  
tot<-LFDs_2024%>%select(year,length, fleet,number)%>%filter(fleet==nam2)

f1<-tot[,-3]
colnames(f1)<-c("year","len","number")
uyear=unique(f1[,1])
f1$len=as.numeric(f1$len)
f1$number=as.numeric(f1$number)
l_m=length(uyear);X=list()

for(l in 1:l_m){
  
  f_aux<- f1 %>%  filter(year==uyear[l])
  f2=f_aux[,c(2,3)]
  
  # necesitamos saber cuantas veces se repite de 0 a 130 la secuencia incompleta
  # calcular cuantas veces se repite el vector
  l_aux=0
  dim1=dim(f2)[1]
  ss=1
  for(i in 1:(dim1-1)){
    if(f2$len[i+1]<f2$len[i]){
      l_aux=c(l_aux,length(f2$len[ss:i]))
      ss=i+1}
  }
  
  
  l_aux=c(l_aux[-1],dim(f2)[1]-sum(l_aux[-1]))
  l_aux
  
  new_aux=0
  len_aux=length(l_aux)
  for(i in 1:len_aux){
    new_aux=c(new_aux,rep(i,l_aux[i]))
  }
  
  new_aux=new_aux[-1]
  f2$new=new_aux# index for len aux
  
  
  f3 <- data.frame(len=rep(1:129,1))# structure we want 0-129
  library(dplyr)
  
  # LOOP for JOIN AND MATCH 0-130 l_aux times
  dat=f2[1,c(1,2)]
  dat[1,]=c(0,0)
  for(i in 1:len_aux){
    f3$len=as.numeric(f3$len)
    f2_1=subset(f2,f2$new==i)[,c(1,2)]
    f2_1$len=as.numeric(f2_1$len)
    dat1=left_join(f3, f2_1, by = "len")
    dat=rbind(dat,dat1)
  }
  
  dat=dat[-1,]
  
  # change NAs (not matches) for ZEROS
  dat
  ind<-is.na(dat$number)
  dat[ind,2]<-0
  dat$step<-sort(rep(1:4,dim(dat)[1]/4))
  dat$age<-paste("len", dat[,1], sep="")
  dat$fleet<-rep(nam1, times=length(dat[,1]))
  dat$area<-rep("area1", times=length(dat[,1]))
  dat$length<-rep("allages", times=length(dat[,1]))
  dat$year<-rep(uyear[l], times=length(dat[,1]))
  X[[l]]=dat
}

f1=rbind(X[[1]])


fleet<-f1
fleet$len_cm<-sub('len', '', fleet$age)
fleet$len_cm<-as.numeric(fleet$len_cm)
fleet$len_cm<-as.factor(fleet$len_cm)

l_ptTrw_2024<-fleet[ ,c(8,3,6,7,4,2,5)]


l_ptTrw=rbind(l_ptTrw,l_ptTrw_2024)
head(l_ptTrw);tail(l_ptTrw)


## Art ---------------------------------------------------------------------------

l_Art<-LFDs_all%>%filter(fleet  =="Art")
tail(l_Art)


### * Important check before using the arrange
l_Art_2024<-LFDs_2024%>%filter(fleet  =="Art")
all(diff(l_Art_2024$step) >= 0)

#### Arrange data ----------------------------------------------------------------

library(dplyr)
nam1="Art"
nam2<-"Art"  
tot<-LFDs_2024%>%select(year,length, fleet,number)%>%filter(fleet==nam2)

f1<-tot[,-3]
colnames(f1)<-c("year","len","number")
uyear=unique(f1[,1])
f1$len=as.numeric(f1$len)
f1$number=as.numeric(f1$number)
l_m=length(uyear);X=list()

for(l in 1:l_m){
  
  f_aux<- f1 %>%  filter(year==uyear[l])
  f2=f_aux[,c(2,3)]
  
  # necesitamos saber cuantas veces se repite de 0 a 130 la secuencia incompleta
  # calcular cuantas veces se repite el vector
  l_aux=0
  dim1=dim(f2)[1]
  ss=1
  for(i in 1:(dim1-1)){
    if(f2$len[i+1]<f2$len[i]){
      l_aux=c(l_aux,length(f2$len[ss:i]))
      ss=i+1}
  }
  
  
  l_aux=c(l_aux[-1],dim(f2)[1]-sum(l_aux[-1]))
  l_aux
  
  new_aux=0
  len_aux=length(l_aux)
  for(i in 1:len_aux){
    new_aux=c(new_aux,rep(i,l_aux[i]))
  }
  
  new_aux=new_aux[-1]
  f2$new=new_aux# index for len aux
  
  
  f3 <- data.frame(len=rep(1:129,1))# structure we want 0-129
  library(dplyr)
  
  # LOOP for JOIN AND MATCH 0-130 l_aux times
  dat=f2[1,c(1,2)]
  dat[1,]=c(0,0)
  for(i in 1:len_aux){
    f3$len=as.numeric(f3$len)
    f2_1=subset(f2,f2$new==i)[,c(1,2)]
    f2_1$len=as.numeric(f2_1$len)
    dat1=left_join(f3, f2_1, by = "len")
    dat=rbind(dat,dat1)
  }
  
  dat=dat[-1,]
  
  # change NAs (not matches) for ZEROS
  dat
  ind<-is.na(dat$number)
  dat[ind,2]<-0
  dat$step<-sort(rep(1:4,dim(dat)[1]/4))
  dat$age<-paste("len", dat[,1], sep="")
  dat$fleet<-rep(nam1, times=length(dat[,1]))
  dat$area<-rep("area1", times=length(dat[,1]))
  dat$length<-rep("allages", times=length(dat[,1]))
  dat$year<-rep(uyear[l], times=length(dat[,1]))
  X[[l]]=dat
}

f1=rbind(X[[1]])


fleet<-f1
fleet$len_cm<-sub('len', '', fleet$age)
fleet$len_cm<-as.numeric(fleet$len_cm)
fleet$len_cm<-as.factor(fleet$len_cm)

l_Art_2024<-fleet[ ,c(8,3,6,7,4,2,5)]


l_Art=rbind(l_Art,l_Art_2024)
head(l_Art);tail(l_Art)


## ptArt ---------------------------------------------------------------------------

l_ptArt<-LFDs_all%>%filter(fleet  =="ptArt")
tail(l_ptArt)



### * Important check before using the arrange
l_ptArt_2024<-LFDs_2024%>%filter(fleet  =="ptArt")
all(diff(l_ptArt_2024$step) >= 0)

#### Arrange data ----------------------------------------------------------------

library(dplyr)
nam1="ptArt"
nam2<-"ptArt"  
tot<-LFDs_2024%>%select(year,length, fleet,number)%>%filter(fleet==nam2)

f1<-tot[,-3]
colnames(f1)<-c("year","len","number")
uyear=unique(f1[,1])
f1$len=as.numeric(f1$len)
f1$number=as.numeric(f1$number)
l_m=length(uyear);X=list()

for(l in 1:l_m){
  
  f_aux<- f1 %>%  filter(year==uyear[l])
  f2=f_aux[,c(2,3)]
  
  # necesitamos saber cuantas veces se repite de 0 a 130 la secuencia incompleta
  # calcular cuantas veces se repite el vector
  l_aux=0
  dim1=dim(f2)[1]
  ss=1
  for(i in 1:(dim1-1)){
    if(f2$len[i+1]<f2$len[i]){
      l_aux=c(l_aux,length(f2$len[ss:i]))
      ss=i+1}
  }
  
  
  l_aux=c(l_aux[-1],dim(f2)[1]-sum(l_aux[-1]))
  l_aux
  
  new_aux=0
  len_aux=length(l_aux)
  for(i in 1:len_aux){
    new_aux=c(new_aux,rep(i,l_aux[i]))
  }
  
  new_aux=new_aux[-1]
  f2$new=new_aux# index for len aux
  
  
  f3 <- data.frame(len=rep(1:129,1))# structure we want 0-129
  library(dplyr)
  
  # LOOP for JOIN AND MATCH 0-130 l_aux times
  dat=f2[1,c(1,2)]
  dat[1,]=c(0,0)
  for(i in 1:len_aux){
    f3$len=as.numeric(f3$len)
    f2_1=subset(f2,f2$new==i)[,c(1,2)]
    f2_1$len=as.numeric(f2_1$len)
    dat1=left_join(f3, f2_1, by = "len")
    dat=rbind(dat,dat1)
  }
  
  dat=dat[-1,]
  
  # change NAs (not matches) for ZEROS
  dat
  ind<-is.na(dat$number)
  dat[ind,2]<-0
  dat$step<-sort(rep(1:4,dim(dat)[1]/4))
  dat$age<-paste("len", dat[,1], sep="")
  dat$fleet<-rep(nam1, times=length(dat[,1]))
  dat$area<-rep("area1", times=length(dat[,1]))
  dat$length<-rep("allages", times=length(dat[,1]))
  dat$year<-rep(uyear[l], times=length(dat[,1]))
  X[[l]]=dat
}

f1=rbind(X[[1]])


fleet<-f1
fleet$len_cm<-sub('len', '', fleet$age)
fleet$len_cm<-as.numeric(fleet$len_cm)
fleet$len_cm<-as.factor(fleet$len_cm)

l_ptArt_2024<-fleet[ ,c(8,3,6,7,4,2,5)]


l_ptArt=rbind(l_ptArt,l_ptArt_2024)
head(l_ptArt);tail(l_ptArt)


## discards ---------------------------------------------------------------------------

l_disc<-LFDs_all%>%filter(fleet  =="disc")
tail(l_disc)

#### Two different fleet arrange (sp and pt)

sp=LFDs_2024%>%filter(fleet  =="spDisc")
pt=LFDs_2024%>%filter(fleet  =="ptDisc")

### * Important check before using the arrange
all(diff(sp$step) >= 0)
all(diff(pt$step) >= 0)


#### Arrange data Sp ----------------------------------------------------------------

library(dplyr)
nam1="spDisc"
nam2<-"spDisc"  
tot<-LFDs_2024%>%select(year,length, fleet,number)%>%filter(fleet==nam2)

f1<-tot[,-3]
colnames(f1)<-c("year","len","number")
uyear=unique(f1[,1])
f1$len=as.numeric(f1$len)
f1$number=as.numeric(f1$number)
l_m=length(uyear);X=list()

for(l in 1:l_m){
  
  f_aux<- f1 %>%  filter(year==uyear[l])
  f2=f_aux[,c(2,3)]
  
  # necesitamos saber cuantas veces se repite de 0 a 130 la secuencia incompleta
  # calcular cuantas veces se repite el vector
  l_aux=0
  dim1=dim(f2)[1]
  ss=1
  for(i in 1:(dim1-1)){
    if(f2$len[i+1]<f2$len[i]){
      l_aux=c(l_aux,length(f2$len[ss:i]))
      ss=i+1}
  }
  
  
  l_aux=c(l_aux[-1],dim(f2)[1]-sum(l_aux[-1]))
  l_aux
  
  new_aux=0
  len_aux=length(l_aux)
  for(i in 1:len_aux){
    new_aux=c(new_aux,rep(i,l_aux[i]))
  }
  
  new_aux=new_aux[-1]
  f2$new=new_aux# index for len aux
  
  
  f3 <- data.frame(len=rep(1:129,1))# structure we want 0-129
  library(dplyr)
  
  # LOOP for JOIN AND MATCH 0-130 l_aux times
  dat=f2[1,c(1,2)]
  dat[1,]=c(0,0)
  for(i in 1:len_aux){
    f3$len=as.numeric(f3$len)
    f2_1=subset(f2,f2$new==i)[,c(1,2)]
    f2_1$len=as.numeric(f2_1$len)
    dat1=left_join(f3, f2_1, by = "len")
    dat=rbind(dat,dat1)
  }
  
  dat=dat[-1,]
  
  # change NAs (not matches) for ZEROS
  dat
  ind<-is.na(dat$number)
  dat[ind,2]<-0
  dat$step<-sort(rep(1:4,dim(dat)[1]/4))
  dat$age<-paste("len", dat[,1], sep="")
  dat$fleet<-rep(nam1, times=length(dat[,1]))
  dat$area<-rep("area1", times=length(dat[,1]))
  dat$length<-rep("allages", times=length(dat[,1]))
  dat$year<-rep(uyear[l], times=length(dat[,1]))
  X[[l]]=dat
}

f1=rbind(X[[1]])


fleet<-f1
fleet$len_cm<-sub('len', '', fleet$age)
fleet$len_cm<-as.numeric(fleet$len_cm)
fleet$len_cm<-as.factor(fleet$len_cm)

l_spDisc_2024<-fleet[ ,c(8,3,6,7,4,2,5)]



#### Arrange data Pt ----------------------------------------------------------------

library(dplyr)
nam1="ptDisc"
nam2<-"ptDisc"  
tot<-LFDs_2024%>%select(year,length, fleet,number)%>%filter(fleet==nam2)

f1<-tot[,-3]
colnames(f1)<-c("year","len","number")
uyear=unique(f1[,1])
f1$len=as.numeric(f1$len)
f1$number=as.numeric(f1$number)
l_m=length(uyear);X=list()

for(l in 1:l_m){
  
  f_aux<- f1 %>%  filter(year==uyear[l])
  f2=f_aux[,c(2,3)]
  
  # necesitamos saber cuantas veces se repite de 0 a 130 la secuencia incompleta
  # calcular cuantas veces se repite el vector
  l_aux=0
  dim1=dim(f2)[1]
  ss=1
  for(i in 1:(dim1-1)){
    if(f2$len[i+1]<f2$len[i]){
      l_aux=c(l_aux,length(f2$len[ss:i]))
      ss=i+1}
  }
  
  
  l_aux=c(l_aux[-1],dim(f2)[1]-sum(l_aux[-1]))
  l_aux
  
  new_aux=0
  len_aux=length(l_aux)
  for(i in 1:len_aux){
    new_aux=c(new_aux,rep(i,l_aux[i]))
  }
  
  new_aux=new_aux[-1]
  f2$new=new_aux# index for len aux
  
  
  f3 <- data.frame(len=rep(1:129,1))# structure we want 0-129
  library(dplyr)
  
  # LOOP for JOIN AND MATCH 0-130 l_aux times
  dat=f2[1,c(1,2)]
  dat[1,]=c(0,0)
  for(i in 1:len_aux){
    f3$len=as.numeric(f3$len)
    f2_1=subset(f2,f2$new==i)[,c(1,2)]
    f2_1$len=as.numeric(f2_1$len)
    dat1=left_join(f3, f2_1, by = "len")
    dat=rbind(dat,dat1)
  }
  
  dat=dat[-1,]
  
  # change NAs (not matches) for ZEROS
  dat
  ind<-is.na(dat$number)
  dat[ind,2]<-0
  dat$step<-sort(rep(1:4,dim(dat)[1]/4))
  dat$age<-paste("len", dat[,1], sep="")
  dat$fleet<-rep(nam1, times=length(dat[,1]))
  dat$area<-rep("area1", times=length(dat[,1]))
  dat$length<-rep("allages", times=length(dat[,1]))
  dat$year<-rep(uyear[l], times=length(dat[,1]))
  X[[l]]=dat
}

f1=rbind(X[[1]])


fleet<-f1
fleet$len_cm<-sub('len', '', fleet$age)
fleet$len_cm<-as.numeric(fleet$len_cm)
fleet$len_cm<-as.factor(fleet$len_cm)

l_ptDisc_2024<-fleet[ ,c(8,3,6,7,4,2,5)]
l_Disc_2024=l_ptDisc_2024
l_Disc_2024$number=l_ptDisc_2024$number+l_spDisc_2024$number
l_Disc_2024$fleet="disc"

l_disc=rbind(l_disc,l_Disc_2024)
head(l_disc);tail(l_disc)


## SpGFS** ---------------------------------------------------------------------------



###--- ind --- ###

# Sex separated data
library(openxlsx)

l_SpGFS_indet=LFDs_all%>%filter(fleet  =="SpSurv_ind")


### Arrange data

l_SpGFS_indet_2024<-openxlsx::read.xlsx(xlsxFile = paste(dir,"boot/data/Surveys/SpGFS-WIBTS-Q4 (G2784).xlsx",sep=""),
                                        sheet = "Indet")
l_SpGFS_indet_2024=l_SpGFS_indet_2024[,c(1,dim(l_SpGFS_indet_2024)[2])]

f1<-l_SpGFS_indet_2024
flt<-"SpSurv_ind"# name for combined fleet



library(reshape2)
f1<-melt(f1, id.var="Length")
colnames(f1)<-c("len","Yr","number")

f1$Seas<-rep(10.3, times=length(f1$Yr))
f1$FltSvy<-rep(flt, times=length(f1$Yr))
f1$area<-rep("area1")
f1$length<-rep("allages")
f1$age<-paste("len", f1$len,sep="")
f1<-f1[,c(2,4,6,7,8,3,5)]
colnames(f1)<-c("year", "step",  "area",  "length",  "age", "number",  "fleet")
head(f1,4) #  year step  area  length  age number  fleet

l_SpGFS_indet=rbind(l_SpGFS_indet,f1)

###--- FEMALE --- ###

l_SpGFS_fem=LFDs_all%>%filter(fleet  =="SpSurv_fem")

### Arrange data
l_SpGFS_fem_2024<-openxlsx::read.xlsx(xlsxFile = paste(dir,"boot/data/Surveys/SpGFS-WIBTS-Q4 (G2784).xlsx",sep=""),
                                      sheet = "Females")
l_SpGFS_fem_2024=l_SpGFS_fem_2024[,c(1,dim(l_SpGFS_fem_2024)[2])]
f1<-l_SpGFS_fem_2024
flt<-"SpSurv_fem"# name for combined fleet



library(reshape2)
f1<-melt(f1, id.var="Length")
colnames(f1)<-c("len","Yr","number")
f1$Seas<-rep(10.3, times=length(f1$Yr))
f1$FltSvy<-rep(flt, times=length(f1$Yr))
f1$area<-rep("area1")
f1$length<-rep("allages")
f1$age<-paste("len", f1$len,sep="")
f1<-f1[,c(2,4,6,7,8,3,5)]
colnames(f1)<-c("year", "step",  "area",  "length",  "age", "number",  "fleet")
head(f1,4) #  year step  area  length  age number  fleet

l_SpGFS_fem=rbind(l_SpGFS_fem,f1)


###--- MALE --- ###
l_SpGFS_mal=LFDs_all%>%filter(fleet  =="SpSurv_mal")

### Arrange data
l_SpGFS_mal_2024<-openxlsx::read.xlsx(xlsxFile = paste(dir,"boot/data/Surveys/SpGFS-WIBTS-Q4 (G2784).xlsx",sep=""),
                                      sheet = "Males")
l_SpGFS_mal_2024=l_SpGFS_mal_2024[,c(1,dim(l_SpGFS_mal_2024)[2])]
f1<-l_SpGFS_mal_2024
flt<-"SpSurv_mal"# name for combined fleet



library(reshape2)
f1<-melt(f1, id.var="Length")
colnames(f1)<-c("len","Yr","number")
# Yr<-rep(2022, each=100)
# f1$Yr<-Yr
f1$Seas<-rep(10.3, times=length(f1$Yr))
f1$FltSvy<-rep(flt, times=length(f1$Yr))
f1$area<-rep("area1")
f1$length<-rep("allages")
f1$age<-paste("len", f1$len,sep="")
f1<-f1[,c(2,4,6,7,8,3,5)]
colnames(f1)<-c("year", "step",  "area",  "length",  "age", "number",  "fleet")
head(f1,4) #  year step  area  length  age number  fleet

l_SpGFS_mal=rbind(l_SpGFS_mal,f1)


## CdSurv ---------------------------------------------------------------------------

l_CdSurv<-LFDs_all%>%filter(fleet  =="cdSurv")
tail(l_CdSurv)

# Problem: detected in 2025, some values of LFDs are multiplied by
# 10 in the years before 2019, we need to correct with excel of
# the survey (new year this will not be required)

# New numbers (uncomment next year)

# l_CdSurv_new <- read_excel("boot/data/Surveys/SPGFScaut-WIBTS-Q4 (G4309).xlsx", sheet =
#                               "tabla años ARSA noviembre")
# 
# l1=dim(l_CdSurv_new)[1]
# l2=dim(l_CdSurv_new)[2]
# 
# l_CdSurv_2024=as.data.frame(l_CdSurv_new[-((l1-5):l1),c(13,l2-1)])
# 
# 
# aux1=data.frame(1:2,rep(0,2)); colnames(aux1)=colnames(l_CdSurv_2024)
# aux2=data.frame(81:129,rep(0,length(81:129))) ; colnames(aux2)=colnames(l_CdSurv_2024)  
# l_CdSurv_2024=rbind(aux1,l_CdSurv_2024,aux2)
# 
# ind=which(l_CdSurv$year=="2023")
# a=l_CdSurv[ind,]
# a$year=2024
# l_CdSurv=rbind(l_CdSurv,a)
# 
# ind=which(l_CdSurv$year=="2024")
# in_NA<-which(is.na(l_CdSurv_2024$`2024`)=="TRUE")
# l_CdSurv_2024$`2024`[in_NA]<-0
# l_CdSurv[ind,]$number=l_CdSurv_2024[,2]
# 

# Solving the problem! (delete next year!)

l_CdSurv_new <- read_excel("boot/data/Surveys/SPGFScaut-WIBTS-Q4 (G4309).xlsx", sheet =
                             "tabla años ARSA noviembre")

l1=dim(l_CdSurv_new)[1]
l2=dim(l_CdSurv_new)[2]

columns=14:(l2-1)
ind=which(l_CdSurv$year=="2023")
a=l_CdSurv[ind,]
b<-a[1,]

for (i in columns){
new_Cd=as.data.frame(l_CdSurv_new[-((l1-5):l1),c(13,i)])


aux1=data.frame(1:2,rep(0,2)); colnames(aux1)=colnames(new_Cd)
aux2=data.frame(81:129,rep(0,length(81:129))) ; colnames(aux2)=colnames(new_Cd)  
new_Cd=rbind(aux1,new_Cd,aux2)

a$year=(colnames(new_Cd)[2])
in_NA<-which(is.na(new_Cd[,2])=="TRUE")
new_Cd[in_NA,2]<-0
a$number=new_Cd[,2]

b<-rbind(b,a)
}
c<-b[-1,]
ind<-which(c$year==2021)
l_CdSurv_recent<-c[-ind,]

# Period 1999-2008
cdsurv_hist <- read_excel("boot/data/Surveys/SPGFScaut-WIBTS-Q4 (G4309)_historical period.xls", 
                                                              sheet = "lengthfile")

cdsurv_hist_red<-cdsurv_hist[,c(1,6,7)]

años <- unique(cdsurv_hist_red$AÑO)
tallas_completas <- 1:129
completo <- expand.grid(AÑO = años, TALLAS = tallas_completas)

df_completo <- completo %>%
  left_join(cdsurv_hist_red, by = c("AÑO", "TALLAS")) %>%
  mutate(NUMERO = ifelse(is.na(NUMERO), 0, NUMERO)) %>%
  arrange(AÑO, TALLAS)


# Input corrected

l_CdSurv_1999_2008<-subset(l_CdSurv,l_CdSurv$year>=1999 & l_CdSurv$year<=2008)

Yr<-(l_CdSurv_1999_2008$year)

for (i in 1:length(unique(Yr))){
  ind<-which(l_CdSurv_1999_2008$year==unique(Yr)[i])
  ind2<-which(df_completo$AÑO==unique(Yr)[i])
  l_CdSurv_1999_2008$number[ind]<-df_completo$NUMERO[ind2]
}
# Join

l_CdSurv<-rbind(l_CdSurv_1999_2008,l_CdSurv_recent)

## PtGFS ** ---------------------------------------------------------------------------

###--- IND --- ###

# Sex separated data
l_PtGFS_indet=LFDs_all%>%filter(fleet  =="PtSurv_ind")

# TAKE CARE, delete next year!!!

# 1990 appears twice
l_PtGFS_indet<-l_PtGFS_indet[-(1:129),]


# Add 2024!!! NO DATA AVAILABLE!
# library(openxlsx)
# l_PtGFS_indet_2023<-openxlsx::read.xlsx(xlsxFile =paste(dir, "boot/data/Surveys/ptGFS-WIBTS-Q4 (G8899).xlsx",sep=""),
#                                    sheet = "indet")
# l_PtGFS_indet_2023=l_PtGFS_indet_2023[,c(1,dim(l_PtGFS_indet_2023)[2])]
# f1<-l_PtGFS_indet_2023
# flt<-"PtSurv_ind"# name for combined fleet
# fltn<-7
# 
# # arrange data
# library(reshape2)
# f1<-melt(f1, id.var="lt")
# f1<-f1[,c(2,1,3)]
# colnames(f1)<-c("year","len","num")
# uyear=unique(f1[,1])
# f1$len=as.numeric(f1$len)
# f1$num=as.numeric(f1$num)
# #check
# diff(f1$len)
# 
# f1_aux=data.frame(year=rep(2023,length(unique(l_PtGFS_indet$age))),
#                   len=1:length(unique(l_PtGFS_indet$age)),num=0)
# 
# ind=which(f1_aux$len>=min(f1$len) & f1_aux$len<=max(f1$len))
# f1_aux[ind,]$num=f1$num
# f1_aux[is.na(f1_aux$num),]$num=0
# 
# f1_aux$step=1
# f1_aux$area="area1"
# f1_aux$length="allages"
# f1_aux$age=paste0("len",f1_aux$len)
# f1_aux$number=f1_aux$num
# f1_aux$fleet="PtSurv_ind"
# f1=f1_aux[,-c(2,3)]
# 
# head(f1,4) #  year step  area  length  age number  fleet
# 
# f1=rbind(l_PtGFS_indet,f1)
# l_PtGFS_indet<-f1
# 
# 
# ###--- FEMALE --- ###
# 
# 
# # Sex separated data
# 
 l_PtGFS_fem<-LFDs_all%>%filter(fleet  =="PtSurv_fem")
 # Delete next year!
 l_PtGFS_fem<-l_PtGFS_fem[-(1:129),]
 
# 
# # Add 2023!!!
# 
# l_PtGFS_fem_2023<-openxlsx::read.xlsx(xlsxFile =paste(dir, "boot/data/Surveys/ptGFS-WIBTS-Q4 (G8899).xlsx",sep=""),
#                                         sheet = "females")
# l_PtGFS_fem_2023=l_PtGFS_fem_2023[,c(1,dim(l_PtGFS_fem_2023)[2])]
# f1<-l_PtGFS_fem_2023
# flt<-"PtSurv_fem"# name for combined fleet
# fltn<-7
# 
# # arrange data
# library(reshape2)
# f1<-melt(f1, id.var="lt")
# f1<-f1[,c(2,1,3)]
# colnames(f1)<-c("year","len","num")
# uyear=unique(f1[,1])
# f1$len=as.numeric(f1$len)
# f1$num=as.numeric(f1$num)
# #check
# diff(f1$len)
# 
# f1_aux=data.frame(year=rep(2023,length(unique(l_PtGFS_fem$age))),
#                   len=1:length(unique(l_PtGFS_fem$age)),num=0)
# 
# ind=which(f1_aux$len>=min(f1$len) & f1_aux$len<=max(f1$len))
# f1_aux[ind,]$num=f1$num
# f1_aux[is.na(f1_aux$num),]$num=0
# 
# f1_aux$step=1
# f1_aux$area="area1"
# f1_aux$length="allages"
# f1_aux$age=paste0("len",f1_aux$len)
# f1_aux$number=f1_aux$num
# f1_aux$fleet="PtSurv_fem"
# f1=f1_aux[,-c(2,3)]
# 
# head(f1,4) #  year step  area  length  age number  fleet
# 
# f1=rbind(l_PtGFS_fem,f1)
# l_PtGFS_fem<-f1
# 
# 
# ###--- MALE --- ###
# 
# # Sex separated data
# 
l_PtGFS_mal<-LFDs_all%>%filter(fleet  =="PtSurv_mal")
# Delete next year!
l_PtGFS_mal<-l_PtGFS_mal[-(1:129),]
# 
# # Add 2023!!!
# 
# l_PtGFS_mal_2023<-openxlsx::read.xlsx(xlsxFile =paste(dir, "boot/data/Surveys/ptGFS-WIBTS-Q4 (G8899).xlsx",sep=""),
#                                       sheet = "males")
# l_PtGFS_mal_2023=l_PtGFS_mal_2023[,c(1,dim(l_PtGFS_mal_2023)[2])]
# f1<-l_PtGFS_mal_2023
# flt<-"PtSurv_mal"# name for combined fleet
# fltn<-7
# 
# # arrange data
# library(reshape2)
# f1<-melt(f1, id.var="lt")
# f1<-f1[,c(2,1,3)]
# colnames(f1)<-c("year","len","num")
# uyear=unique(f1[,1])
# f1$len=as.numeric(f1$len)
# f1$num=as.numeric(f1$num)
# #check
# diff(f1$len)
# 
# f1_aux=data.frame(year=rep(2023,length(unique(l_PtGFS_mal$age))),
#                   len=1:length(unique(l_PtGFS_mal$age)),num=0)
# 
# ind=which(f1_aux$len>=min(f1$len) & f1_aux$len<=max(f1$len))
# f1_aux[ind,]$num=f1$num
# f1_aux[is.na(f1_aux$num),]$num=0
# 
# f1_aux$step=1
# f1_aux$area="area1"
# f1_aux$length="allages"
# f1_aux$age=paste0("len",f1_aux$len)
# f1_aux$number=f1_aux$num
# f1_aux$fleet="PtSurv_mal"
# f1=f1_aux[,-c(2,3)]
# 
# head(f1,4) #  year step  area  length  age number  fleet
# 
# f1=rbind(l_PtGFS_mal,f1)
# l_PtGFS_mal<-f1

## SpCPUE ---------------------------------------------------------------------------

## Mirror LFDs from trawlers and volanta fleets

## PtCPUE ---------------------------------------------------------------------------

#l_PtCPUE<-LFDs_all%>%filter(fleet  =="PtCPUE")

## NSample ---------------------------------------------------------------------------

library(openxlsx)

## Fleets
ns_f<-read.csv(paste(dir, "data/LFDs/nsample/nsample fleets.csv", sep=""))
ns_trawlers<-subset(ns_f, ns_f$fleet=="trawlers")
ns_disc<-subset(ns_f, ns_f$fleet=="disc")
ns_volpal<-subset(ns_f, ns_f$fleet=="volpal")
ns_artisanal<-subset(ns_f, ns_f$fleet=="artisanal")
ns_cdTrw<-subset(ns_f, ns_f$fleet=="cdTrawl")

## Surveys
ns_s<-read.csv(paste(dir, "data/LFDs/nsample/nsample surveys.csv", sep=""))
ns_spsurv<-subset(ns_s, ns_s$Fleet=="SpSurv")
ns_ptsurv<-subset(ns_s, ns_s$Fleet=="PtSurv")


## save * ---------------------------------------------------------------------

LFDs_1994_2024<-rbind(l_volanta, l_palangre, l_baka, l_cdTrw, l_ptTrw, l_Art, l_ptArt
                      , l_disc, l_SpGFS_fem, l_SpGFS_indet, l_SpGFS_mal, l_CdSurv,
                      l_PtGFS_fem, l_PtGFS_indet, l_PtGFS_mal,l_pairTrw)

write.csv(LFDs_1994_2024, paste(dir,"data/LFDs/LFDs 1994-2024.csv",sep=""))

# save all.RData ---------------------------------------------------------------------------

save(c_hist_trawlers,c_hist_volpal,
     c_old_spArt, c_old_spTrw,c_old_cdTrw, c_old_vol, c_old_pal, c_old_ptArt, c_old_ptTrw, c_seas_1982_1993_trawlers, c_seas_1982_1993_volpal,c_seas_1982_1993_art,c_seas_1982_1993_cdTrw,
     c_Art,c_baka,c_cdTrw,c_disc,c_pairTrw,c_palangre, c_ptArt,c_ptTrw,c_volanta,
     ind_SpGFS, ind_CdSurv, ind_PtGFS, ind_SpCPUE_trawlers, ind_SpCPUE_volpal,
     l_o_pal,l_o_ptArt,l_o_ptTrw,l_o_spArt,l_o_spTrw,l_o_vol,
     l_volanta, l_palangre, l_baka, l_cdTrw, l_ptTrw, l_Art, l_ptArt, l_disc, l_SpGFS_fem, l_SpGFS_indet, l_SpGFS_mal, l_CdSurv,l_PtGFS_fem, l_PtGFS_indet, l_PtGFS_mal,l_pairTrw,
     ns_trawlers,ns_volpal,ns_artisanal,ns_cdTrw,ns_spsurv,ns_ptsurv,ns_disc,
     file=paste(dir,"data/all data.RData",sep="")) # save the full dataset in RData

