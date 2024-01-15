library (tidyverse) 

# a script to plot pca 
# usage Rscript <eigenvec_file>  <hprc_metadata>
# Rscript ../rscripts/2.plotPCA.R all.eigenvec ../data/pop/hprc.metadata

args <- commandArgs(trailingOnly = TRUE)
eigenvec_file<- args[1]
hprc_metadata<- args[2]


# Read the Eigenvec file
eigenvec <- read.table(eigenvec_file, header = TRUE, comment.char="") #colClasses = "character")
eigenvec$Sample =eigenvec$X.IID

# Read the Metadata file
metadata <- read.table(hprc_metadata, header = TRUE, comment.char="")

# Merge the Eigenvec data with Metadata
merged_data <- merge(eigenvec, metadata, by.x = "Sample") #

# Plot the first two principal components
myplot<- ggplot(merged_data, aes(x = PC1, y = PC2, color = Superpopulation)) +
  geom_point() +
  labs(title = "PCA Plot", x = "Principal Component 1", y = "Principal Component 2")

ggsave(plot = myplot, filename = paste(eigenvec_file, '.pca.png', sep=''), width = 15, height = 10 , units='cm') 
