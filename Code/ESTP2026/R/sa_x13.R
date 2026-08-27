s <- rjd3toolkit::ABS$X0.2.09.10.M
sa_x13<-rjd3x13::x13_fast(s, "rsa0")

plot(c(sa_x13$final$d16, sa_x13$final$d16a), type="l")

spec<-rjd3x13::x11_spec()
spec$mode<-"ADDITIVE"
spec$sfilters<-"FILTER_CROSSVALIDATION"

sa_x11<-rjd3x13::x11(s,spec)

plot(sa_x11$d10)
