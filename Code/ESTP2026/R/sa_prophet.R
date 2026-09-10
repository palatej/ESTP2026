source("./R/prophet_seasadj.R")
s <- rjd3toolkit::ABS$X0.2.07.10.M
#s <- rjd3toolkit::aggregate(rjd3toolkit::ABS$X0.2.07.10.M, 4)

sa<-prophet_seasadj(s, "additive")
ts.plot(ts.union(sa$y, sa$sa, sa$t), type='l', col=c("gray", "blue", "red"))

sa<-prophet_seasadj(s, "multiplicative")
ts.plot(ts.union(sa$y, sa$sa, sa$t), type='l', col=c("gray", "blue", "red"))

