source("R/sa_all.r")

growth<-function(s){
    return (s/lag(s,1))
}


ts.plot(window(ts.union(sa_x11, sa_x13), start=2005), type='b', col=c("orange", "red"))
ts.plot(window(ts.union(sa_ts0, sa_ts, sa_sts), start=2005), type='b', col=c("blue", "magenta", "black"))
ts.plot(window(ts.union(sa_prophet, sa_camplet, sa_x11, sa_stl), start=2005), type='b', col=c("brown", "green", "orange", "darkgreen"))

ts.plot(window(ts.union( growth(sa_prophet), growth(sa_camplet), growth(sa_stl), growth(sa_x11),
                         growth(sa_x13), growth(sa_ts0), growth(sa_ts)),
               start=2005), type='l', col=c("brown", "green", "darkgreen", "orange", "red", "blue", "magenta"))
ts.plot(window(ts.union(s, sa_prophet, sa_camplet, sa_stl, sa_x11, sa_x13, sa_ts0, sa_ts), start=2005), type='p', col=c("gray", "brown", "green", "darkgreen", "orange", "red", "blue", "magenta"))
