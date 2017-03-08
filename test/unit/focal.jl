using GeneralizedMetropolisHastings
using Geodesy
using PyPlot

###Include the model functions
include("../../focal/models/model.jl")

###Focal mechanism (strike, dip, rake)
src_mag = 3.98
src_dura = 1.0
src_rise = 0.5
src_focal = [311.0, 75.0, -22.0]

###Delta
npts = 4096
delta = 0.01
idx = 1:1:npts
tt = idx * delta

###Receiver information
num_rcv = 7
#idx_rcv = 1:1:num_rcv
index = 1:1:(3*num_rcv*npts)
idx_rcv = ["INN", "SBR", "SIB", "STM", "TKD",  "TKO",  "TMC"]
rcv_dist = ["103.14", "103.13", "86.07", "98.24", "62.70", "97.88", "17.83"]
rcv_azim = [30.61, 333.91, 205.50, 284.39, 74.77, 151.67, 113.68]

###Generate waveform data
value = synwv(src_focal, num_rcv, rcv_dist, rcv_azim, src_mag, src_dura, src_rise, delta)

amp_scale = 3.0
fig = PyPlot.figure()
ax1 = PyPlot.subplot(1,3,1)
PyPlot.plot(tt, float(rcv_dist[1])+amp_scale*(value[:,1]/maximum(map(abs, value[:,1]))), "k-", linewidth=1)
PyPlot.plot(tt, float(rcv_dist[2])+amp_scale*(value[:,2]/maximum(map(abs, value[:,2]))), "r-", linewidth=1)
PyPlot.plot(tt, float(rcv_dist[3])+amp_scale*(value[:,3]/maximum(map(abs, value[:,3]))), "b-", linewidth=1)
PyPlot.plot(tt, float(rcv_dist[4])+amp_scale*(value[:,4]/maximum(map(abs, value[:,4]))), "g-", linewidth=1)
PyPlot.plot(tt, float(rcv_dist[5])+amp_scale*(value[:,5]/maximum(map(abs, value[:,5]))), "y-", linewidth=1)
PyPlot.plot(tt, float(rcv_dist[6])+amp_scale*(value[:,6]/maximum(map(abs, value[:,6]))), "c-", linewidth=1)
PyPlot.plot(tt, float(rcv_dist[7])+amp_scale*(value[:,7]/maximum(map(abs, value[:,7]))), "m-", linewidth=1)
PyPlot.xlim(0, 35)
PyPlot.xlabel("Time (s)")
PyPlot.ylabel("Distance (km)")

ax2 = PyPlot.subplot(1,3,2)
PyPlot.plot(tt, float(rcv_dist[1])+amp_scale*(value[:,8]/maximum(map(abs, value[:,8]))), "k-", linewidth=1)
PyPlot.plot(tt, float(rcv_dist[2])+amp_scale*(value[:,9]/maximum(map(abs, value[:,9]))), "r-", linewidth=1)
PyPlot.plot(tt, float(rcv_dist[3])+amp_scale*(value[:,10]/maximum(map(abs, value[:,10]))), "b-", linewidth=1)
PyPlot.plot(tt, float(rcv_dist[4])+amp_scale*(value[:,11]/maximum(map(abs, value[:,11]))), "g-", linewidth=1)
PyPlot.plot(tt, float(rcv_dist[5])+amp_scale*(value[:,12]/maximum(map(abs, value[:,12]))), "y-", linewidth=1)
PyPlot.plot(tt, float(rcv_dist[6])+amp_scale*(value[:,13]/maximum(map(abs, value[:,13]))), "c-", linewidth=1)
PyPlot.plot(tt, float(rcv_dist[7])+amp_scale*(value[:,14]/maximum(map(abs, value[:,14]))), "m-", linewidth=1)
PyPlot.xlim(0, 35)
PyPlot.xlabel("Time (s)")
PyPlot.ylabel("Distance (km)")

ax3 = PyPlot.subplot(1,3,3)
PyPlot.plot(tt, float(rcv_dist[1])+amp_scale*(value[:,15]/maximum(map(abs, value[:,15]))), "k-", linewidth=1)
PyPlot.plot(tt, float(rcv_dist[2])+amp_scale*(value[:,16]/maximum(map(abs, value[:,16]))), "r-", linewidth=1)
PyPlot.plot(tt, float(rcv_dist[3])+amp_scale*(value[:,17]/maximum(map(abs, value[:,17]))), "b-", linewidth=1)
PyPlot.plot(tt, float(rcv_dist[4])+amp_scale*(value[:,18]/maximum(map(abs, value[:,18]))), "g-", linewidth=1)
PyPlot.plot(tt, float(rcv_dist[5])+amp_scale*(value[:,19]/maximum(map(abs, value[:,19]))), "y-", linewidth=1)
PyPlot.plot(tt, float(rcv_dist[6])+amp_scale*(value[:,20]/maximum(map(abs, value[:,20]))), "c-", linewidth=1)
PyPlot.plot(tt, float(rcv_dist[7])+amp_scale*(value[:,21]/maximum(map(abs, value[:,21]))), "m-", linewidth=1)
PyPlot.xlim(0, 35)
PyPlot.xlabel("Time (s)")
PyPlot.ylabel("Distance (km)")

PyPlot.show()
