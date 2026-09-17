source("R/prophet_seasadj.R")
source("R/sts_seasadj.R")

#s <- rjd3toolkit::Retail$RetailSalesTotal
s <- rjd3toolkit::aggregate(rjd3toolkit::Retail$RetailSalesTotal, 4)

#s <- rjd3toolkit::Retail$AutomobileDealers
#s <- rjd3toolkit::aggregate(rjd3toolkit::Retail$AutomobileDealers, 4)
#s <- rjd3toolkit::ABS$X0.2.20.10.M
#s <- rjd3toolkit::aggregate(rjd3toolkit::ABS$X0.2.09.10.M, 4)


spec<-rjd3x13::x11_spec()
spec$mode<-"ADDITIVE"

rslt_x11<-rjd3x13::x11(s,spec)
sa_x11<-rslt_x11$d11

rslt_x13<-rjd3x13::x13_fast(s, "rsa5c")
sa_x13<-rslt_x13$final$d11final

rslt_ts0<-rjd3tramoseats::tramoseats_fast(s, "rsa0")
sa_ts0<-rslt_ts0$final$sa$data

rslt_ts<-rjd3tramoseats::tramoseats_fast(s)
sa_ts<-rslt_ts$final$sa$data

rslt_prophet<-prophet_seasadj(s)
sa_prophet<-rslt_prophet$sa

rslt_camplet<-camplet::camplet(s)
sa_camplet<-ts(rslt_camplet$data$sa, frequency=frequency(s), start = start(s))

rslt_stl<- stl(s, s.window = 7)
sa_stl<-s-rslt_stl$time.series[,"seasonal"]

rslt_sts<- sts_fast(s)
sa_sts<-rslt_sts$sa

