rm(list=ls())
library("igraph")
library(readr)
##loading flight data 
flight_hault=read.csv(file.choose(),header=FALSE)
##Assigning column names
colnames(flight_hault) <- c("ID","Name","City","Country","IATA_FAA","ICAO","Latitude","Longitude","Altitude","Time","DST","Tz database time")
head(flight_hault)

##loading connecting routes data
connect_routes1 <- read.csv(file.choose(),header=FALSE)
connect_routes <-connect_routes1[ ,c(2,3,4,5,6,8,9)]
##Assigning column names
colnames(connect_routes) <- c("flights", " ID", "main Airport”, “main Airport ID", "Destination ","Destination  ID","haults","machinary")
head(connect_routes)


## network graph  for connect_routes
flights_new <- graph.edgelist(as.matrix(connect_routes[ ,c(2,4)]),directed = TRUE)
plot(flights_new)

##the count of nodes
vcount(flights_new)
##the count of edges
ecount(flights_new)
##degree centrality(local centrality measures)
deg_cen <- centr_degree(flights_new, mode='all')
deg_cen$res
# Which airport has most flights coming in, and how many?

indegree <- degree(flights_new,mode="in")
max(indegree)
index <-which(indegree==max(indegree))
indegree[index]
which(flight_hault$IATA_FAA=='ATL')
flight_hault[3584,]



# Which airport has most flights going out of, and how many?
outdegree <- degree(flights_new, mode = "out")
max(outdegree)
index <- which(outdegree == max(outdegree))
outdegree[index]
which(flight_hault$IATA_FAA == "ATL")
flight_hault[3584, ]

# Which airport is close to most of the airports (in terms of number of flights)

closeness_in <- closeness(flights_new, mode = "in", normalized = TRUE)
max(closeness_in)
index <- which(closeness_in == max(closeness_in))
closeness_in[index]
which(flight_hault$IATA_FAA == "FRA")
flight_hault[338, ]

# Which airport comes in between most of the routes and hence is an important international hub?
?betweenness
btwn <- betweenness(flights_new, normalized = TRUE)
max(btwn)
index <- which(btwn == max(btwn))
btwn[index]
which(airports$IATA_FAA == "LAX")
airports[3386,]

# Degree, closeness, and betweenness centralities together
centralities <- cbind(indegree, outdegree, closeness_in, btwn)
colnames(centralities) <- c("inDegree","outDegree","closenessIn","betweenness")
head(centralities)
