@everywhere using GeneralizedMetropolisHastings
@everywhere using Geodesy
using PyPlot

###Include the model functions
include("../models/model.jl")

###Focal mechanism (strike, dip, rake)
src_mag = 3.98
src_dura = 1.0
src_rise = 0.5
src_focal = [311.0, 75.0, -22.0]

###Delta
npts = 4096
delta = 0.01
#idx = 1:1:npts

###Receiver information
num_rcv = 7
#idx_rcv = 1:1:num_rcv
idx_rcv = ["INN", "SBR", "SIB", "STM", "TKD",  "TKO",  "TMC"]
rcv_dist = ["103.14", "103.13", "86.07", "98.24", "62.70", "97.88", "17.83"]
rcv_azim = [30.61, 333.91, 205.50, 284.39, 74.77, 151.67, 113.68]

###Generate waveform data
d = synwv(src_focal, num_rcv, rcv_dist, rcv_azim, src_mag, src_dura, src_rise, delta)
#d = data(:function, idx_rcv, synwv, src_focal, num_rcv, rcv_dist, rcv_azim, src_mag, src_dura, src_rise, delta)

#for i=1:1:npts
#    println(d[1][i])
#end

PyPlot.plot(d[1,1], linewidth=1)
PyPlot.show()
