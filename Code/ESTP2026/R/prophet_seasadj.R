prophet_seasadj<-function(s, mode="multiplicative"){
    freq<-frequency(s)
    n<-length(s)
    if (mode == "multiplicative")
        y<-log(s)
    else
        y<-s
    h <- data.frame(ds = rjd3toolkit::daysOf(y), y = y)
    model <- prophet::prophet(h,
                           yearly.seasonality = freq/2,
                           weekly.seasonality = FALSE,
                           daily.seasonality = FALSE,
                           seasonality.mode = "additive")
    fy<-ts(rep(0, n+freq), frequency = freq, start=start(y))
    future <- data.frame(ds = rjd3toolkit::daysOf(fy))
    forecasts <- predict(model, future)

    seas<-forecasts$yearly
    t<-forecasts$trend
    yhat<-forecasts$yhat
    i<-c(y-yhat[1:n], rep(0, freq))

    if (mode == "multiplicative"){
        seas<-exp(seas)
        t<-exp(t)
        i<-exp(i)
        # bias correction
        ny<-as.integer(length(s)/freq)
        dseas<-mean(seas[1:(ny*freq)])
        di<-mean(i[1:(ny*freq)])
        seas<-seas/dseas
        i<-i/di
        t<-t*dseas*di
        tss<-ts(seas, frequency = frequency(s), start = start(s))
        tst<-ts(t, frequency = frequency(s), start = start(s))
        tsi<-ts(i, frequency = frequency(s), start = start(s))
        tsa<-tst*tsi
    }else{
        tss<-ts(seas, frequency = frequency(s), start = start(s))
        tst<-ts(t, frequency = frequency(s), start = start(s))
        tsi<-ts(i, frequency = frequency(s), start = start(s))
        tsa<-tst+tsi
    }
    return (list(y=s, t=tst, s=tss, sa=tsa, i=tsi))
}

ts_end<-function(s){
    e<-end(s)
    y<-e[1]
    p<-e[2]
    freq<-frequency(s)
    if(p ==freq ) return (c(y+1, 1)) else return (c(y, p+1))
}
