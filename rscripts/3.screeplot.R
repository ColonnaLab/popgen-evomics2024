library (tidyverse) 

# a script to make a scree plot  
# usage Rscript <input file>  
# Rscript ../rscripts/3.screeplot.R all.eigenval

args <- commandArgs(trailingOnly = TRUE)
input_file <- args[1]




# Read the eigenvalues from the text file
eigenvalues <- read.table(input_file, header = FALSE)

# Calculate the proportion of variance explained by each PC
proportion_variance <- eigenvalues$V1 / sum(eigenvalues$V1)

# Create a data frame for plotting
pc_data <- data.frame(PC = 1:length(proportion_variance), 
                      Variance = proportion_variance)

# Generate the scree plot
myplot<- ggplot(pc_data, aes(x = PC, y = Variance)) +
    geom_line() + 
    geom_point() +
    xlab("Principal Component") +
    ylab("Proportion of Variance Explained") +
    ggtitle("Scree Plot")

ggsave(plot = myplot, filename = paste(input_file, 'scree.png', sep=''), width = 10, height = 10 , units='cm') 
