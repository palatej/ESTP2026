
s <- rjd3toolkit::Retail$RetailSalesTotal
#s <- rjd3toolkit::ABS$X0.2.05.10.M

spec<-rjd3x13::x11_spec()
spec$mode<-"ADDITIVE"

rslt_x11<-rjd3x13::x11(s,spec)
sa_x11<-rslt_x11$d11

rslt_x13<-rjd3x13::x13_fast(s)
sa_x13<-rslt_x13$final$d11final

rslt_ts0<-rjd3tramoseats::tramoseats_fast(s, "rsa0")
sa_ts0<-rslt_ts0$final$sa$data

rslt_ts<-rjd3tramoseats::tramoseats_fast(s)
sa_ts<-rslt_ts$final$sa$data


rslt_camplet<-camplet::camplet(s)
sa_camplet<-ts(rslt_camplet$data$sa, frequency=frequency(s), start = start(s))


ts.plot(window(ts.union(sa_camplet, sa_x11, sa_x13, sa_ts0, sa_ts), start=2005), type='l', col=c("green", "orange", "red", "blue", "magenta"))

ts.plot(window(ts.union(sa_x11, sa_x13), start=2005), type='l', col=c("orange", "red"))
ts.plot(window(ts.union(sa_ts0, sa_ts), start=2005), type='l', col=c("blue", "magenta"))
