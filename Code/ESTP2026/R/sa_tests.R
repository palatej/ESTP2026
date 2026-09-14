source("R/sa_all.r")


cat("Seasonality tests", "\n\n")

tests_sa<-function(title, sa){
ds <- rjd3toolkit::do_stationary(sa)$ddata
cat(title, "\n")
test<-rjd3toolkit::seasonality_f(sa, model="D1")
cat("F test:", test$pvalue, "\n")
test<-rjd3toolkit::seasonality_f(sa, model="D1", 8)
cat("F test(end):", test$pvalue, "\n")
test<-rjd3toolkit::seasonality_qs(ds)
cat("QS test:", test$pvalue, "\n")
test<-rjd3toolkit::seasonality_kruskalwallis(ds)
cat("Kruskal-Wallis test:", test$pvalue, "\n")
test<-rjd3toolkit::td_f(sa, model="D1")
cat("TD F test:", test$pvalue, "\n")

}

tests_sa("Camplet", sa_camplet)

tests_sa("Prophet", sa_prophet)

tests_sa("STL", sa_stl)

tests_sa("STS", sa_sts)

tests_sa("TS0", sa_ts0)

tests_sa("TS-full", sa_ts)

tests_sa("X11", sa_x11)

tests_sa("X13", sa_x13)
