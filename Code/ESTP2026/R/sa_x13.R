s <- rjd3toolkit::ABS$X0.2.09.10.M

spec<-rjd3x13::x11_spec()
spec$mode<-"ADDITIVE"

rslt_x11<-rjd3x13::x11(s,spec)
sa_x11<-rslt_x11$d11
ts.plot(ts.union(s,sa_x11), type="l", col=c("gray", "blue"))

rslt_x13<-rjd3x13::x13_fast(s, "RSA5")
sa_x13<-rslt_x13$final$d11final
ts.plot(ts.union(s,sa_x13), type="l", col=c("gray", "blue"))
