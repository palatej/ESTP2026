# helper function
henderson<-function(n){
    jfilter<-rJava::.jcall("jdplus/toolkit/base/core/math/linearfilters/HendersonFilters",     "Ljdplus/toolkit/base/core/math/linearfilters/SymmetricFilter;", "ofLength", as.integer(n))
    w<-rJava::.jcall(jfilter, "[D", "weightsToArray")
    ff<-rjd3filters::moving_average(w, lags=-(length(w)-1)/2)
    return(ff)
}

nh<-121

ff<-henderson(nh)
par(mfrow=c(1,2))
barplot(ff@coefficients, main="weights")
rjd3filters::plot_gain(ff, main="gain")
par(mfrow=c(1,1))

lp<-rjd3filters::lp_filter(horizon=(nh-1)/2, degree=1, kernel="biweight", endpoints = "DAF")
par(mfrow=c(1,2))
barplot(lp@sfilter@coefficients, main="weights")
rjd3filters::plot_gain(lp@sfilter, main="gain")
par(mfrow=c(1,1))
