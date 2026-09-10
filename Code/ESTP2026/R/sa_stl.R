s <- rjd3toolkit::ABS$X0.2.09.10.M

rslt_stl<- stl(s, s.window = 7)
sa_stl<-s-rslt_stl$time.series[,"seasonal"]

ts.plot(ts.union(s,sa_stl), type="l", col=c("gray", "blue"))
