#simple version

library("ggplot2")

df <- read.delim("hist", header=T)
g <- ggplot(df, aes(x = value))
g <- g + geom_histogram(bins = 100)
g
