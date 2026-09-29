# Create a SARIMA model (airline model)

model1<-rjd3toolkit::sarima_model("model1", 12, d=1, theta=c(-.8), bd=1, btheta = c(-.6))
print(model1)

model1_props<-rjd3toolkit::sarima_properties(model1)

par( mfrow=c(1,2))

plot(model1_props$spectrum, type='l', ylim=c(0,2), main="Pseudo-spectrum", ylab='y', xlab='frequency (*600/pi)')

# [theta(B)*theta(F)]/[phi(B)*phi(F])
plot(model1_props$acf, type='h', main="Auto-correlations (stationary transformation)", ylab='ac(i)', xlab='lag')

model2<-rjd3toolkit::sarima_model("model2", 12, phi = -.5, d=1, theta=-.8, bd=1, btheta = -.6)
print(model2)

model2_props<-rjd3toolkit::sarima_properties(model2)


plot(model2_props$spectrum, type='l', ylim=c(0,2), main="Pseudo-spectrum", ylab='y', xlab='frequency (*600/pi)')

# [theta(B)*theta(F)]/[phi(B)*phi(F])
plot(model2_props$acf, type='h', main="Auto-correlations (stationary transformation)", ylab='ac(i)', xlab='lag')


par( mfrow=c(1,1))

ucm1<-rjd3toolkit::sarima_decompose(model1)

print(ucm1)

model1cmps_props<-lapply(ucm1$components, function(m){rjd3toolkit::arima_properties(m)})

matplot(sapply(model1cmps_props, function(m){m$spectrum}), type='l', ylim=c(0,1), main="Pseudo-spectrum", ylab='y', xlab='frequency (*600/pi)')

ucm2<-rjd3toolkit::sarima_decompose(model2, rmod=0.9)

print(ucm2)

model2cmps_props<-lapply(ucm2$components, function(m){rjd3toolkit::arima_properties(m)})

matplot(sapply(model2cmps_props, function(m){m$spectrum}), type='l', ylim=c(0,1), main="Pseudo-spectrum", ylab='y', xlab='frequency (*600/pi)')
