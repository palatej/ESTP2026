s <- rjd3toolkit::ABS$X0.2.20.10.M

# fast processing : series + spec

# default spec, default output

rslt_ts0<-rjd3tramoseats::tramoseats_fast(s, "rsa0")
sa_ts0<-rslt_ts0$final$sa$data
ts.plot(ts.union(s,sa_ts0), type="l", col=c("gray", "blue"))

rslt_ts<-rjd3tramoseats::tramoseats_fast(s)
sa_ts<-rslt_ts$final$sa$data
ts.plot(ts.union(s,sa_ts), type="l", col=c("gray", "blue"))

###############################################################################

# customized output

summary(rjd3tramoseats::tramoseats_dictionary())

# add some "non-standard" output

rslt_ts_ex<-rjd3tramoseats::tramoseats_fast(s, userdefined = c("y_f(67)", "y_ef(67)", "diagnostics.seas-res-evolutive", "diagnostics.seas-res-stable"))

print(rslt_ts_ex$user_defined$`diagnostics.seas-res-evolutive`)
print(rslt_ts_ex$user_defined$`diagnostics.seas-res-stable`)

f<-rslt_ts_ex$user_defined$`y_f(67`
ef<-rslt_ts_ex$user_defined$`y_ef(67`

ts.plot(ts.union(f,f+ef, f-ef), col=c("red", "gray", "gray"))

###############################################################################

# complete processing : contains the "result" or "point" spec

rslt_ts_full<-rjd3tramoseats::tramoseats(s)
nspec<-rslt_ts_full$result_spec
nspec$benchmarking$enabled<-TRUE
rslt_ts_bench<-rjd3tramoseats::tramoseats_fast(s, nspec, userdefined = "benchmarking.result")

ts.plot(rslt_ts_bench$final$sa$data/rslt_ts_bench$user_defined$benchmarking.result, col=c("red"), ylab="benchmarking correction")

###############################################################################

# user-defined calendar (for Australia)

CAL <- rjd3toolkit::national_calendar(list(
    rjd3toolkit::fixed_day(1,26),
    rjd3toolkit::fixed_day(4,25),
    rjd3toolkit::special_day('NEWYEAR'),
    rjd3toolkit::special_day('CHRISTMAS'),
    rjd3toolkit::fixed_day(12,26),
    rjd3toolkit::easter_day(-2),
    rjd3toolkit::easter_day(-1),
    rjd3toolkit::easter_day(1)
))

spec<-rjd3tramoseats::tramoseats_spec()
context<-rjd3toolkit::modelling_context(list(aus=CAL))
spec$tramo<-rjd3toolkit::set_tradingdays(spec$tramo, option="UserDefined", "aus")

rslt_ts<-rjd3tramoseats::tramoseats_fast(s, userdefined="cal")
rslt_ts_cal<-rjd3tramoseats::tramoseats_fast(s, spec, context = context, userdefined="cal")

ts.plot(window(ts.union(rslt_ts$user_defined$cal, rslt_ts_cal$user_defined$cal), start=2005), col=c("red", "blue"))

