source("R/sa_all.r")

all<-ts.union(s, sa_prophet, sa_stl, sa_camplet, sa_sts, sa_ts0, sa_ts, sa_x11, sa_x13)

write.csv(all, "output/all.csv")
