library (tidyverse) 

# a script to plot the allele frequency spectrum calculated with plink  

# usage: 

# to plot ALT (alternate) allele frequency spectrum: 
# Rscript  Rscript  plotafs.R chr15.afr.afreq.alt1.bins chr15.amr.afreq.alt1.bins afr-amr-ALT

# to plot REF (alternate) allele frequency spectrum:
# Rscript plotafs.R chr15.afr.afreq.ref.bins chr15.amr.afreq.ref.bins afr-amr-REF

args <- commandArgs(trailingOnly = TRUE)
input_file1 <- args[1]
input_file2 <- args[2]
titleOfGraph <- args[3]

mydpop1<- read.table(input_file1 , header =T, comment.char="" ) 
mydpop1$pop<-'pop1'

mydpop2<- read.table(input_file2 , header =T, comment.char="" ) 
mydpop2$pop<-'pop2'

myd<-rbind(mydpop1, mydpop2)

myplot<- ggplot(myd, aes(X.BIN_START, OBS_CT, fill=pop )) + 
    geom_bar (stat='identity', position='dodge') +
    labs(title=titleOfGraph , x= 'allele frequency bin', y='counts')

ggsave(plot = myplot, filename = paste(titleOfGraph, '.png', sep=''),  width = 18, height = 8 , units='cm') 