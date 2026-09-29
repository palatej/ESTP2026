c<-c(1/24,1/12,1/12,1/12,1/12,1/12,1/12,1/12,1/12,1/12,1/12,1/12,1/24)
s<-rjd3toolkit::Retail$AutomobileDealers
t<-filter(s, c, sides = 1)

plot(t)

vf<-Vectorize(function(z){cos(z)})

q<-vf((0:length(s))*pi/(17.898))
sc<-filter(q, c, sides = 1)
matplot(cbind(q,sc), type='l')
