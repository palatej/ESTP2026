s <- rjd3toolkit::ABS$X0.2.09.10.M

rslt_camplet<-camplet::camplet(s)
sa_camplet<-ts(rslt_camplet$data$sa, frequency=frequency(s), start = start(s))

ts.plot(ts.union(s,sa_camplet), type="l", col=c("gray", "blue"))
