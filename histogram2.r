df <- read.delim("hist", header=T)
g <- NULL
g <- ggplot(df, aes(x = Value, fill=Class))
g <- g + geom_histogram(bins = 100,alpha=0.6,position="identity")
g
