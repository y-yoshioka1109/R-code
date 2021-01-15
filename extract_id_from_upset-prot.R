library(tidyverse)

#Binary化した結果を読み込む
D1 <- read.delim("List.binary.txt")

#CとDだけが持つ要素の抽出
data <- D1 %>% rownames_to_column("rowid") %>% filter_at(vars(c("C", "D")), ~.==1)%>% filter_at(vars(c("A", "B")), ~.==0)

#nrowでカウントできる
nrow(data)

#書き出し
write.table(data, "out.txt", quote=F)
