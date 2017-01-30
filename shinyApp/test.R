datas <- read.csv("dataCSV.csv")
colNA <- apply(datas, 2, is.na)
meanNA <- apply(colNA, 2, mean)
index <- 1:ncol(colNA)
meanNA <- cbind(meanNA, index)
meanNA <- data.frame(meanNA)
colNA
meanNA
names(meanNA)


require(corrgram)
corrgram(state.x77, lower.panel=panel.shade, upper.panel=panel.pts, text.panel=panel.txt, pch=16)
