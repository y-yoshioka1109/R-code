#simple version

library("ggplot2")

df <- read.delim("hist.txt", header=T)
g <- ggplot(df, aes(x = value))
g <- g + geom_histogram(binwidth = 100)
g
