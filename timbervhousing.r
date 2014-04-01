library("quantmod")
library(tseries)

filenames = c("Series_Comp", "Cross-Corr_Series", "Cross-corr_diff", "Cross-corr_logs")

getSymbols("CUT")
getSymbols("IYR")

timber0 = CUT[,6]
timber1 = diff(timber0)
timber2 = diff(timber1)
timberlog = log(timber0)

land0 = IYR[,6]
land1 = diff(land0)
land2 = diff(land1)
landlog = log(land0)

data0 = merge(timber0, land0, all=FALSE)
data1 = merge(timber1, land1, all=FALSE)
data2 = merge(timber2, land2, all=FALSE)
datal = merge(timberlog, landlog, all=FALSE)

#REMOVE NA
data1 = na.remove(data1)
data2 = na.remove(data2)

titles = c("Price Series Plot", "First difference", "log series")

pdf(paste("1", filenames[1],".pdf", sep=""))
  lb = floor(min(data0))
  ub = ceiling(max(data0))
  ylim=c(lb,ub)
  plot(data0[,2],ylim=c(lb,ub), main="Timber(CUT) is red. Housing(IYR) is black", type="l", col="red")
  lines(data0[,1])
dev.off()

pdf(paste("2", filenames[2],".pdf", sep=""))
  acf(data0, sub=titles[1])
dev.off()

pdf(paste("3", filenames[3],".pdf", sep=""))
  acf(data1, sub=titles[2])
dev.off()

pdf(paste("4", filenames[4],".pdf", sep=""))
  acf(datal, sub=titles[3])
dev.off()