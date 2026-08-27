s <- rjd3toolkit::ABS$X0.2.09.10.M
h <- data.frame(ds = rjd3toolkit::daysOf(s), y = s)
sa <- prophet::prophet(h,
                       yearly.seasonality = 12,
                       weekly.seasonality = FALSE,
                       daily.seasonality = FALSE,
                       seasonality.mode = "multiplicative")
future <- prophet::make_future_dataframe(sa, periods = 12, freq="month")
forecasts <- predict(sa, future)

plot(forecasts$yearly, type ="l")

sa <- prophet::prophet(h,
                       yearly.seasonality = 12,
                       weekly.seasonality = FALSE,
                       daily.seasonality = FALSE,
                       seasonality.mode = "additive")
future <- prophet::make_future_dataframe(sa, periods = 12, freq="month")
forecasts <- predict(sa, future)

plot(forecasts$yearly, type ="l")

