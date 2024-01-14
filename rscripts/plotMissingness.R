library(tidyverse) 

# a script to plot missingness 
# usage Rscript <input file>  <what-you-want-in-the-title-of-the-graph>


args <- commandArgs(trailingOnly = TRUE)
input_file <- args[1]
titleOfGraph <- args[2]

myd=read.table (input_file , header=T , comment.char="") 
myplot<- ggplot(myd, aes(F_MISS) )+ geom_histogram() +labs(title=titleOfGraph , x= 'fraction') 

ggsave(plot = myplot, filename = paste(input_file, titleOfGraph, '.png', sep='')) #,  width = 15, height = 15, dpi = 300, units = "cm")