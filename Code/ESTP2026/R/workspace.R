# java object
jws<-rjd3workspace::jws_open(file.path("workspaces", "test.xml"))
# corresponding R object (after computation)
ws<-rjd3workspace::read_workspace(jws)
# make a copy of the java object
jws2<-rjd3workspace::jws_make_copy(jws)

# change the path to the data to get last vintages
rjd3providers::set_spreadsheet_paths("Data/New")
# refresh the copy (data and parameters)
rjd3workspace::jws_refresh(jws2, 'FreeParameters')
ws2<-rjd3workspace::read_workspace(jws2)
# the previous results and the new results can be easily compared

SA1<-ws$processing$`SAProcessing-1`
SA2<-ws2$processing$`SAProcessing-1`
idx<-3
sa1=SA1[[idx]]
sa2<-SA2[[idx]]
dely<-sa2$results$final$series$data-sa1$results$final$series$data
delsa<-sa2$results$final$sa$data-sa1$results$final$sa$data
delproc<-delsa-dely
print(window(dely, start=2018))
print(window(delsa, start=2018))
print(window(delproc, start=2018))

all<-ts.union(dely, delsa, delproc)

print(window(all, start=2018))
cols<-c('red', 'gray', 'blue')
ts.plot(window(all, start=2015), col=cols, type='b', main="Tramo-Seats. Revisions")
legend(x="topleft", legend = c("Raw", "SA", "Proc"), col=cols, lty=c(1,1,1))

SA1<-ws$processing$`SAProcessing-2`
SA2<-ws2$processing$`SAProcessing-2`
idx<-3
sa1=SA1[[idx]]
sa2<-SA2[[idx]]
delsa<-sa2$results$final$d11final-sa1$results$final$d11final
delproc<-delsa-dely
print(window(dely, start=2018))TSA
print(window(delsa, start=2018))
print(window(delproc, start=2018))

all<-ts.union(dely, delsa, delproc)

print(window(all, start=2018))
ts.plot(window(all, start=2015), col=cols, type='b', main="X13. Revisions")
legend(x="topleft", legend = c("Raw", "SA", "Proc"), col=cols, lty=c(1,1,1))
