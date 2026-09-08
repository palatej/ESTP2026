s <- rjd3toolkit::ABS$X0.2.09.10.M

rslt_ts0<-rjd3tramoseats::tramoseats_fast(s, "rsa0")
sa_ts0<-rslt_ts0$final$sa$data
ts.plot(ts.union(s,sa_ts0), type="l", col=c("gray", "blue"))

rslt_ts<-rjd3tramoseats::tramoseats_fast(s)
sa_ts<-rslt_ts$final$sa$data
ts.plot(ts.union(s,sa_ts), type="l", col=c("gray", "blue"))
