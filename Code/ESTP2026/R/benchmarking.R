data<-file.path(rprojroot::find_root(rprojroot::is_rstudio_project ), 'Data')
rjd3providers::set_spreadsheet_paths(data)
retail_m<-rjd3providers::spreadsheet_data("US-Retail.xlsx")$series
retail_q<-rjd3providers::spreadsheet_data("US-Retail.xlsx", gathering.period=4, gathering.aggregation = "Sum", gathering.cleanMissing = FALSE)$series
retail_m<-lapply(retail_m, function(z)z$data)
retail_q<-lapply(retail_q, function(z)z$data)

spec<-rjd3tramoseats::tramoseats_spec('RSAfull')
spec$benchmarking$enabled<-TRUE


retail_m_sa<-lapply(retail_m, function(z){rjd3tramoseats::tramoseats_fast(z, spec, userdefined = c("benchmarking.original", "benchmarking.result", "regression.ntd" ))})
retail_q_sa<-lapply(retail_q, function(z){rjd3tramoseats::tramoseats_fast(z, spec, userdefined = c("benchmarking.original", "benchmarking.result", "regression.ntd" ))})

mtd<-sapply(retail_m_sa, function(z)z$user_defined$regression.ntd)

qtd<-sapply(retail_q_sa, function(z)z$user_defined$regression.ntd)

print(sapply(c(0,1,6),function(z)sum(mtd==z)))
print(sapply(c(0,1,6),function(z)sum(qtd==z)))

m1<-sapply(retail_m_sa, function(z){rjd3toolkit::seasonality_qs(z$user_defined$benchmarking.original)$value})
m2<-sapply(retail_m_sa, function(z){rjd3toolkit::seasonality_qs(z$user_defined$benchmarking.result)$value})
plot(cbind(m1, m2))

q1<-sapply(retail_q_sa, function(z){rjd3toolkit::seasonality_qs(z$user_defined$benchmarking.original)$value})
q2<-sapply(retail_q_sa, function(z){rjd3toolkit::seasonality_qs(z$user_defined$benchmarking.result)$value})
plot(cbind(q1, q2))
