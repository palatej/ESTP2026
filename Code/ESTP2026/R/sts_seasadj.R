sts_model<-function(s, time_varying_td=TRUE){
    # create the model
    bsm<-rjd3sts::model()
    # create the components and add them to the model
    rjd3sts::add(bsm, rjd3sts::locallineartrend("ll"))
    n<-rjd3sts::noise('n')
    rjd3sts::add(bsm, n)
    rjd3sts::add(bsm, rjd3sts::seasonal("s", 12, type="HarrisonStevens"))
    if (time_varying_td){
    vtd<-rjd3sts::reg_td("td", frequency(s), start(s), length(s), c(1,2,3,4,5,6,0), FALSE, variance = .0001, fixed=FALSE)
    }else{
        vtd<-rjd3sts::reg_td("td", frequency(s), start(s), length(s), c(1,2,3,4,5,6,0), TRUE, variance = 0, fixed=TRUE)
    }
    rjd3sts::add(bsm, vtd)
    #estimate the model
    rslt<-rjd3sts::estimate(bsm, s, marginal=F, initialization="Augmented_Robust", concentrated=TRUE, precision = 1e-20)
    return(rslt)
}

sts_fast<-function(s, mode="multiplicative", time_varying_td=TRUE){
    freq<-frequency(s)
    n<-length(s)
    if (mode == "multiplicative")
        y<-log(s)
    else
        y<-s
    rslt<-sts_model(y, time_varying_td)
    ss<-rjd3sts::smoothed_states(rslt)
    tst<-ts(ss[,1], frequency = frequency(s), start = start(s))
    tsi<-ts(ss[,3], frequency = frequency(s), start = start(s))
    tssa<-tst+tsi
    tss<-y-tssa
    if (mode == "multiplicative"){
        tss<-exp(tss)
        tst<-exp(tst)
        tsi<-exp(tsi)
        # bias correction
        ny<-as.integer(length(tss)/freq)
        dseas<-mean(tss[1:(ny*freq)])
        di<-mean(tsi[1:(ny*freq)])
        tss<-tss/dseas
        tsi<-tsi/di
        tst<-tst*(dseas*di)
        tssa<-tst*tsi
    }
    return (list(y=s, sa=tssa, t=tst, s=tss, i=tsi))

}
