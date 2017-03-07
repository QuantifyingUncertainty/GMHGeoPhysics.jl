using GeneralizedMetropolisHastings
using Geodesy
using PyPlot

###Include the model functions
include("../models/model.jl")
include("../models/dataparameters.jl")

###Source location(latitude, longitude and depth)
src_loc = [27.809, 86.066, 10.0]

###Velocity model
###Number of layers of velocity model
num_lay = 22
###Thickness of each layer of velocity model
thk = [1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 4.00, 6.50, 10.00, 5.00, 14.00, 15.00]
###P and S wave velocity of each layer of velocity model
vp = [5.50, 5.50, 5.50, 5.50, 5.85, 5.85, 5.85, 5.85, 5.85, 5.85, 5.85, 5.85, 5.85, 5.85, 5.85, 5.85, 6.00, 6.45, 6.65, 7.20, 7.50, 7.90]
vs = [3.20, 3.20, 3.20, 3.20, 3.40, 3.40, 3.40, 3.40, 3.40, 3.40, 3.40, 3.40, 3.40, 3.40, 3.40, 3.40, 3.50, 3.70, 3.85, 4.15, 4.20, 4.30]

###Receiver location(latitude, longitude and depth)
num_rcv = 8
idx_rcv = 1:1:num_rcv
rcv_lat = [27.0, 27.1, 27.2, 27.3, 27.4, 27.5, 27.6, 27.7]
rcv_lon = [85.0, 85.1, 85.2, 85.3, 85.4, 85.5, 85.6, 85.7]
rcv_dep = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]

###Generate arrival time data
d = data(:function, idx_rcv, trav, src_loc, num_rcv, rcv_lat, rcv_lon, rcv_dep, num_lay, thk, vp)
println(d)
