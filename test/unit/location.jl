# latitude, longitude and depth of the receiver
rcv_lat = 27.7124
rcv_lon = 85.3156
rcv_dep = 0.0
# latitude, longitude and depth of the source
src_loc = [27.809, 86.066, 10.0]
# number of layers
num_lay = 22
# thickness of each layer
thk = [1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 4.00, 6.50, 10.00, 5.00, 14.00, 15.00]
# P wave velocity of each layer
vp = [5.50, 5.50, 5.50, 5.50, 5.85, 5.85, 5.85, 5.85, 5.85, 5.85, 5.85, 5.85, 5.85, 5.85, 5.85, 5.85, 6.00, 6.45, 6.65, 7.20, 7.50, 7.90]
vs = [3.20, 3.20, 3.20, 3.20, 3.40, 3.40, 3.40, 3.40, 3.40, 3.40, 3.40, 3.40, 3.40, 3.40, 3.40, 3.40, 3.50, 3.70, 3.85, 4.15, 4.20, 4.30]

t0, td = trav(src_loc, rcv_lat, rcv_lon, rcv_dep, num_lay, thk, vp)
@printf "%0.4f\n" t0
