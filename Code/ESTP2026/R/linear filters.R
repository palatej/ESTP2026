c<-c(1/24,1/12,1/12,1/12,1/12,1/12,1/12,1/12,1/12,1/12,1/12,1/12,1/24)
s<-rjd3toolkit::Retail$AutomobileDealers
t<-filter(s, c, sides = 2)

ts.plot(ts.union(s, t), type='l', col=c("gray", "red"))

vf<-Vectorize(function(z){cos(z)})

q<-vf((0:length(s))*pi/(17.898))
sc<-filter(q, c, sides = 2)
matplot(cbind(q,sc), type='l')


# First difference :  b(-1) = -1; b(0) = 1

fr_del<-function(w){
    return (1-complex(real=cos(-w), imaginary = sin(-w)))
}

w<-seq(0:600)*pi/600

cw<-fr_del(w)


plot( Mod(cw), type='l', main = "Gain")
plot( Arg(cw), type='l', main = "Phase")
