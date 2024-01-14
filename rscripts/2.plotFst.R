library (tidyverse) 

# a script to plot fst calculated with vcftools 
# usage Rscript <input file>  <what-you-want-in-the-title-of-the-graph>
# Rscript ../rscripts/2.plotFst.R afr-amr.w10k.windowed.weir.fst   Fst_AFR-AMR_w10k

# mylaptop Rscript ../../tutorials/evomics2024/rscripts/2.plotFst.R afr-amr.w10k.windowed.weir.fst   Fst_AFR-AMR_w10k


args <- commandArgs(trailingOnly = TRUE)
input_file <- args[1]
titleOfGraph <- args[2]
fst_threshold <-as.numeric(args[3])


myd<-read.table( input_file, header =T , comment.char="")

myplot <- myd%>% 
    filter (MEAN_FST>0) %>% 
    ggplot ( aes(BIN_START/1000000, MEAN_FST) ) +
    geom_point() +
    labs(title=titleOfGraph , x= 'chr15 position (Mb)') +
    geom_hline(yintercept = fst_threshold, color = "red", linetype = "dashed")  

ggsave(plot = myplot, filename = paste(input_file, titleOfGraph, '.png', sep=''), width = 18, height = 10 , units='cm') 


highFst<- myd%>% filter (as.numeric(MEAN_FST)>fst_threshold) 
write.table(highFst, file = paste(input_file, titleOfGraph, '.highFst', sep=''), sep = "\t", row.names = FALSE, quote= FALSE)