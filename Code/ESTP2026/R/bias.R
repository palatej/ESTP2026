s<-rjd3toolkit::Retail$BookStores

spec<-rjd3tramoseats::tramoseats_spec("rsafull")

spec1<-rjd3tramoseats::set_seats(spec, bias=FALSE)

rslt<-rjd3tramoseats::tramoseats_fast(s, spec)
rslt1<-rjd3tramoseats::tramoseats_fast(s, spec1)

ts.plot(ts.union(s, rslt$final$sa$data, rslt1$final$sa$data), col=c("gray", "blue", "red"))


spec<-rjd3x13::x13_spec("rsa5c")
rg1<-rjd3toolkit::set_transform(spec$regarima, fun="Log")
nspec<-spec
nspec$regarima<-rg1
# LEGACY should be avoided !!!
spec1<-rjd3x13::set_x11(nspec, "logAdditive", bias = "LEGACY")
spec2<-rjd3x13::set_x11(nspec, "logAdditive", bias = "RATIO")
spec3<-rjd3x13::set_x11(nspec, "logAdditive", bias = "SMOOTH")
spec4<-rjd3x13::set_x11(nspec, "logAdditive", bias = "NONE")

rslt1<-rjd3x13::x13_fast(s, spec1)
rslt2<-rjd3x13::x13_fast(s, spec2)
rslt3<-rjd3x13::x13_fast(s, spec3)
rslt4<-rjd3x13::x13_fast(s, spec4)

ts.plot(ts.union(s, rslt1$final$d12final, rslt2$final$d12final, rslt3$final$d12final, rslt4$final$d12final), col=c("gray", "blue", "cyan", "red", "magenta"))
