library (tidyverse) 
library(gridExtra)

# a script to plot fst calculated with vcftools 
# usage Rscript <input file>  <what-you-want-in-the-title-of-the-graph>
# Rscript ../rscripts/2.plotFst.R afr-amr.w10k.windowed.weir.fst   Fst_AFR-AMR_w10k

# mylaptop Rscript ../../tutorials/evomics2024/rscripts/2.plotFst.R afr-amr.w10k.windowed.weir.fst   Fst_AFR-AMR_w10k


args <- commandArgs(trailingOnly = TRUE)
input_file <- args[1]
titleOfGraph <- args[2]
weightedfst_threshold <-as.numeric(args[3])
fst_threshold <-as.numeric(args[4])

myd<-read.table( input_file, header =T , comment.char="")

myplot_w <- myd%>% 
    filter (WEIGHTED_FST>0) %>% 
    ggplot ( aes(BIN_START/1000000, WEIGHTED_FST) ) +
    geom_point() +
    labs(title=titleOfGraph , x= 'chr15 position (Mb)') +
    geom_hline(yintercept = weightedfst_threshold, color = "red", linetype = "dashed")  


myplot_f <- myd%>% 
    filter (MEAN_FST>0) %>% 
    ggplot ( aes(BIN_START/1000000, MEAN_FST) ) +
    geom_point() +
    labs(title=titleOfGraph , x= 'chr15 position (Mb)') +
    geom_hline(yintercept = fst_threshold, color = "red", linetype = "dashed")  

 mp<-grid.arrange(myplot_w, myplot_f, nrow = 2) #, widths = c(2, 2, 2, 0.5))

ggsave(plot = mp, filename = paste(titleOfGraph, '.png', sep=''), width = 18, height = 20 , units='cm') 


highMeanFst<- myd%>% filter (as.numeric(MEAN_FST)>fst_threshold) 
write.table(highMeanFst, file = paste(titleOfGraph, '.MEAN_FST.high', sep=''), sep = "\t", row.names = FALSE, quote= FALSE)


highWeighFst<- myd%>% filter (as.numeric(WEIGHTED_FST)>fst_threshold) 
write.table(highWeighFst, file = paste(titleOfGraph, '.WEIGHTED_FST.high', sep=''), sep = "\t", row.names = FALSE, quote= FALSE)