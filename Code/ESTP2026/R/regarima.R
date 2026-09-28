# See what is available
rjd3x13::x13_dictionary()

y<-rjd3toolkit::Retail$RetailSalesTotal

# fast processing (just get the result)
# ask for the forecasts and for their stdev (with 27 periods) + the residuals (one-step ahead forecast errors) and the linearized series
regs<-rjd3x13::regarima_fast(y, userdefined = c("residuals.tsres", "y_f(27)", "y_ef(27)", "l"))
fcast<-regs$user_defined$`y_f(27)`
efcast<-regs$user_defined$`y_ef(27)`
res<-regs$user_defined$`residuals.tsres`

ts.plot(ts.union(fcast, fcast+efcast, fcast-efcast), col=c('blue', 'gray', 'gray'))

if (regs$description$log)
  y<-log(y)

# we plot the series and the series without the residuals (=one-step ahead forecasts)
ts.plot(ts.union(y, y-res), col=c('blue', 'red'))

ts.plot(ts.union(y, regs$user_defined$l), col=c('blue', 'red'))
