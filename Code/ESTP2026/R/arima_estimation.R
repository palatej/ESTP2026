# JD+
N<-5000
M<-100
y=log(rjd3toolkit::ABS$X0.2.09.10.M)
print(system.time(for (i in 1:N) {  j<-rjd3toolkit::sarima_estimate(y, order=c(2,1,1),
          seasonal = list(order=c(0,1,1), period=12))}))
print(system.time(for (i in 1:N) { k<-rjd3toolkit::sarima_hannan_rissanen(y, order=c(2,1,1),
                                    seasonal = c(0,1,1))}))
#R-native
print(system.time(for (i in 1:M) {  r<-arima(y, order=c(2,1,1),
          seasonal = list(order=c(0,1,1), period=12))}))

print(summary(j))
print(k)
print(r)

