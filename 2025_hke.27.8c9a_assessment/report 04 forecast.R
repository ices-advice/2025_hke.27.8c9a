
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Extract forecast information for SS shake model #
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Modified 26/03/2024 #
#~~~~~~~~~~~~~~~~~~~~~~
# Marta Cousido       #
# Anxo Paz            #
# Santiago Cervino    #
#~~~~~~~~~~~~~~~~~~~~~~~

## Press Ctrl + Shift + O to see the document outline

rm(list=ls()) ## Clean environment
library(r4ss) 
library(icesAdvice)
library(icesTAF)

## Required paths
run<-"model/final"
mod_path <- paste0(getwd(), "/", run, sep="") 

tabledir_report<-paste0(getwd(), "/","report/table", sep="") 
mkdir(tabledir_report)
plotdir_report<-paste0(getwd(), "/","report/plots", sep="") 

fore_path <-  paste0(mod_path,"/Forecast")
tabledir_fore<- paste(fore_path, "/table", sep="")

# Move tables to the report folder ----------------------------------------------


file.copy(file.path(tabledir_fore, "table intermediate year.csv"), 
            file.path(tabledir_report, "table intermediate year.csv"))


old_file_name <-file.path(tabledir_report, "table intermediate year.csv")
new_file_name <- file.path(tabledir_report, "Table_10.7a.csv")
file.rename(from = old_file_name, to = new_file_name)



file.copy(file.path(tabledir_fore, "catOptionsTab.csv"), 
            file.path(tabledir_report, "catOptionsTab.csv"))
old_file_name <-file.path(tabledir_report, "catOptionsTab.csv")
new_file_name <- file.path(tabledir_report, "Table_10.7b.csv")
file.rename(from = old_file_name, to = new_file_name)



file.copy(file.path(tabledir_fore, "Table10.7 b extended.csv"), 
          file.path(tabledir_report, "Table10.7 b extended.csv"))
file.copy(file.path(tabledir_fore, "Table10.7 b extended.xlsx"), 
          file.path(tabledir_report, "Table10.7 b extended.xlsx"))



# Create forecast plot -------------------------------------------------------------



fore_path <-  paste0(mod_path,"/Forecast")
tabledir_fore<- paste(fore_path, "/table", sep="")
Table=read.csv(paste(tabledir_fore, "/table Fmult.csv", sep=""))
Table=Table[1:40,]

Fmsy=0.221
# Extract Fst
replist <- SS_output(dir = mod_path, verbose=TRUE, printstats=TRUE) 
datmul=replist$exploitation
year_inter=2026;Naver=2
datmul=subset(datmul, datmul$Yr>=(year_inter-(Naver+1)) & datmul$Yr<=(year_inter-1))
Fst=mean(datmul$F_std[c(1,5,9)])


Catch=c(Table$Catches2026,Table$Landings2026)
F2026=c(rep(Table$F2026,2))
factor=c(rep("Catch 2026",(nrow(Table))),rep("Landings 2026",(nrow(Table))))
plot1df=data.frame(Catch,F2026,factor)

plot2df=data.frame(SSB2027=Table$SSB2027,F2026=Table$F2026)

plot1 = ggplot(plot1df, aes(x=F2026,y=Catch,colour=factor)) +
  geom_line() + theme_bw() +
  labs(title="", x="F") +
  theme(legend.title=element_blank(), legend.position = c(0.15, 0.8), legend.background = element_rect(fill="transparent")) + 
  geom_vline(xintercept=c(Fmsy,Fst), linetype="dashed", colour=c("darkgreen","darkorange")) +
  annotate(geom="text", x=Fmsy, y=0.1*max(Catch), label="Fmsy",
           color="darkgreen", hjust=-0.1)+
  annotate(geom="text", x=Fst, y=0.15*max(Catch), label="Fst",
           color="darkorange", hjust=-0.1)

plot2 = ggplot(plot2df, aes(x=F2026, y=SSB2027)) +
  geom_line(colour=3, lwd=1) + theme_bw() +
  labs(title="", x="F", y="SSB 2027") +
  ylim(0,max(plot2df$SSB2027))

library(gridExtra)
library(grid)
plot_both=grid.arrange(plot1,plot2,nrow=2)
print(plot_both)
p <- grDevices::recordPlot()  
grDevices::jpeg(paste(plotdir_report, "/Figure 10.11.png", sep=""),width=3000, height=3000,res=300)    
grDevices::replayPlot(p)    
grDevices::dev.off()

# Comparing with previous year-------------------------------------------------


load('boot/data/Forecast last year/WGBIE2024_table.RData')

df1 <- df2   


stf_current <- readxl::read_xlsx('report/table/Tab10.6.xlsx')
stf_current2 <- read.csv2('report/table/Table_10.7a.csv', sep=',')
stf_current3 <- read.csv2('report/table/Table_10.7b.csv', sep=',')
stf_current3 <- stf_current3[stf_current3$basis=='MSY approach = FMSY',]

df2 <- stf_current[,c('years', 'rec_value', 'ssb_val', 'F_val', 'catch')]
df2$estimate <- 'assessment'

df2 <- rbind( df2,
              c(2025, stf_current2$Rec2025, NA, stf_current2$F2025, stf_current2$Catches2025, 'intermediate'),
              c(2026, NA, stf_current2$SSB2026, NA, NA, 'intermediate'),
              c(2026, stf_current2$Rec2026, NA, stf_current3$ft, stf_current3$tcat, 'MSY forecast'),
              c(2027, NA, stf_current3$ssb, NA, NA, 'MSY forecast'))

df2$name <- 'WGBIE25'

save( df2, file = paste0( getwd(),'/model/final/Forecast/info models/WGBIE2025_table.RData'))


colnames(df1)[1:5] <- colnames(df2)[1:5] <- c('year','Recruitment','SSB','F','Catch')

df <- rbind( df1, df2)


dft <- df %>%
  pivot_longer(cols = c(Catch, SSB, Recruitment, F), 
               names_to = 'Variable', 
               values_to = 'Value')  %>% 
  mutate( Value = as.numeric(Value),
          year = as.numeric(year))

dft <- subset( dft, year>2015)
dft <- na.omit( dft)



ggplot( dft) +
  geom_line( aes( x = year, y = Value, col = name)) +
  geom_point( aes (x = year, y = Value, col = name, shape = estimate), size=2, fill='white') + 
  scale_shape_manual( values=c(3,21,16)) +  
  expand_limits (y=0) +
  facet_wrap( ~Variable, scales='free_y',ncol=2) +
  theme(legend.title = element_blank()) +
  labs(x = NULL, y = NULL)+  scale_x_continuous(breaks = seq(2016, 2027, by = 1))


ggsave(paste(plotdir_report, "/Figure 10.12.png", sep=""),width=8.5,height=6.5,scale=1.2)

