library(datasets)
library(ggplot2)
library(reshape2)
library(dplyr)
library(tidyr)
library(gridExtra)

#データ読み込み
D1 <- read.delim("expression",header=T,check.names=F)

#確認
head(D1)

#列名の中からfactor型の列を探す。今回だとgeneID
colf <- grep("factor",sapply(D1,class))

#D1からfactor型以外を除く
datf <- datf <- D1[,c(colf)] 

#出力するファイル形式をpdfとする
pdf(file="output.pdf", paper="a4r", width=11.6,height=8.2)

for (i in datf){
#対象とする遺伝子名を代入。リストの中からマッチする行を抽出する。
Gene=i
D2 <- D1 %>% dplyr::filter(geneID==Gene) 

#縦長に変換
D3 <- melt(D2,id.vars="geneID",variable.name="Samples",value.name="Counts")

#グループ情報を追加
group <- c(rep("20140523_cont",3),rep("20140523_SymA1",3),rep("20140523_SymA2",3),rep("20140523_SymA3",3),rep("20140527_cont",3),rep("20140527_SymA1",3),rep("20140527_SymA2",3),rep("20140527_SymA3",3),rep("20140531_cont",3),rep("20140531_SymA1",3),rep("20140531_SymA2",3),rep("20140531_SymA3",3))

#サンプル情報を追加
condition <- c(rep("cont",3),rep("SymA1",3),rep("SymA2",3),rep("SymA3",3),rep("cont",3),rep("SymA1",3),rep("SymA2",3),rep("SymA3",3),rep("cont",3),rep("SymA1",3),rep("SymA2",3),rep("SymA3",3))

#日付を追加
date <- c(rep("20140523",12),rep("20140527",12),rep("20140531",12))

#連結
D4 <- cbind(group,condition,date,D3)

#groupごとで平均、標準誤差を計算
D4_mean_se <- D4 %>% group_by(group,condition,date,geneID) %>% summarize(mean = mean(Counts),se = sd(Counts)/sqrt(length(Counts)))

#作図
g1 <- NULL
g1 <- ggplot(D4_mean_se,aes(x=date,y=mean,fill=condition))#サンプルごとで色分け
g1 <- g1 + geom_bar(stat="identity",position="dodge")
errors <- aes(ymax=mean+se,ymin=mean-se)
g1 <- g1 + geom_errorbar(errors, width = 0.05) 
g1 <- g1 + facet_grid(. ~ condition)
g1 <- g1 + theme_bw() #白い背景にする
g1 <- g1 + ggtitle(Gene) #グラフタイトルを設定
g1 <- g1 + xlab("Date") #x軸ラベルを設定
g1 <- g1 + ylab("Expression level (transcripts per million)") #y軸ラベルを設定
g1 <- g1 + theme(legend.position = 'none') #凡例の消去
print(g1)
}
dev.off()
