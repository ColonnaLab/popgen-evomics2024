library (tidyverse) 
# a script to plot the site  frequency spectrum calculated with plink  

# usage: 

# to plot ALT (alternate) allele frequency spectrum: 
## Rscript  ../../rscripts/1.plotafsCOUNTS.R chr15.afreq HPRC-allele-counts


args <- commandArgs(trailingOnly = TRUE)
input_file1 <- args[1]
titleOfGraph <- args[2]

mydpop<- read.table(input_file1 , header =T, comment.char="" ) 

#myplot<- ggplot(myd, aes(X.BIN_START, OBS_CT, fill=pop )) + 
#    geom_bar (stat='identity', position='dodge') +
#    labs(title=titleOfGraph , x= 'allele frequency bin', y='counts')


mycount <- ggplot(mydpop, aes(x = OBS_CT, fill=pop )) +
  geom_histogram(binwidth = 1, fill = "blue", color = "black") +
  labs(title = "Histogram of OBS_CT", x = "Alternate allele Counts", y = "Frequency")


ggsave(plot = mycount, filename = paste(titleOfGraph, 'COUNTS.png', sep=''),  width = 18, height = 8 , units='cm') 