function conv(s::Array, ns::Int64, f::Array, n::Int64)
    m = n + ns
    g = zeros(Float64, m)
    ff = zeros(Float64, n)
    for i=ns+1:1:m
        g[i] = f[i-ns]
        for j=1:1:ns
            ff[i-ns] = ff[i-ns]+g[i-j]*s[j]
        end
    end
    return ff
end

function readsac(fstream)
    floatKey = ["delta","depmin","depmax","scale","odelta","b",
                "e","o","a","internal","t0","t1","t2","t3","t4","t5","t6",
                "t7","t8","t9","f","resp0","resp1","resp2","resp3","resp4",
                "resp5","resp6","resp7","resp8","resp9","stla","stlo",
                "stel","stdp","evla","evlo","evel","evdp","mag","user0",
                "user1","user2","user3","user4","user5","user6","user7",
                "user8","user9","dist","az","baz","gcarc","internal",
                "internal","depmen","cmpaz","cmpinc","xminimum","xmaximum",
                "yminimum","ymaximum","unused","unused","unused","unused",
                "unused","unused","unused"]

    intKey = ["nzyear","nzjday","nzhour","nzmin","nzsec","nzmsec","nvhdr",
              "norid","nevid","npts","internal","nwfid","nxsize","nysize",
              "unused","iftype","idep","iztype","unused","iinst","istreg",
              "ievreg","ievtyp","iqual","isynth","imagtyp","imagsrc","unused",
              "unused","unused","unused","unused","unused","unused","unused",
              "leven","lpspol","lovrok","lcalda","unused"]

    charKey = ["kstnm","kevnm","khole","ko","ka","kt0","kt1","kt2","kt3","kt4",
               "kt5","kt6","kt7","kt8","kt9","kf","kuser0","kuser1","kuser2",
               "kcmpnm","knetwk","kdatrd","kinst"]

    # Read in header information
    floatData = read(fstream, Float32, 70)
    intData = read(fstream, Int32, 40)
    charData = read(fstream, UInt8, 192)

    # Build dictionaries and merge
    d = Dict{Any, Any}()
    fd = [ floatKey[i] => floatData[i] for i = 1:length(floatKey) ]
    id = [ intKey[i] => intData[i] for i = 1:length(intKey) ]
    j = 1
    for i = 1:length(charKey)
        if i == 2
            d[ charKey[i] ] = ascii(charData[j : j + 15])
            j += 16
        else
            d[ charKey[i] ] = ascii(charData[j : j + 7])
            j += 8
        end
    end

    d = merge(fd, id, d)

    # Extract number of points in data array
    npts = intData[10]
    data = read(fstream, Float32, npts)
    return d, data

end

function dc_radiat(stk::Float64, dip::Float64, rak::Float64)
    stk = stk * pi / 180.0
    dip = dip * pi / 180.0
    rak = rak * pi / 180.0
    sstk = sin(stk)
    cstk = cos(stk)
    sdip = sin(dip)
    cdip = cos(dip)
    srak = sin(rak)
    crak = cos(rak)
    sstk2 = 2.0*sstk*cstk
    cstk2 = cstk*cstk-sstk*sstk
    sdip2 = 2.0*sdip*cdip
    cdip2 = cdip*cdip-sdip*sdip
    rad = zeros(Float64,3,3)
    rad[1,1] = 0.5*srak*sdip2
    rad[1,2] = rad[1,1]
    rad[1,3] = 0.0
    rad[2,1] = -sstk*srak*cdip2 + cstk*crak*cdip
    rad[2,2] = rad[2,1]
    rad[2,3] = cstk*srak*cdip2 + sstk*crak*cdip
    rad[3,1] = -sstk2*crak*sdip - 0.5*cstk2*srak*sdip2
    rad[3,2] = rad[3,1]
    rad[3,3] = cstk2*crak*sdip - 0.5*sstk2*srak*sdip2
    return rad
end

function trapezoid(dura::Float64, rise::Float64, dt::Float64)
    ns = round(Int64, dura/dt)
    src = zeros(Float64,ns+1)
    nr = round(Int64, rise*ns)
    #println(length(src))
    amp = 1.0/(nr*(ns-nr))
    #println(amp)
    for i = 1:1:ns+1
        if i < nr+1
            src[i] = (i-1)*amp
        elseif i < ns-nr+1
            src[i] = nr*amp
        else
            src[i] = (ns+1-i)*amp
        end
    end
    return src
end

# green func 0
fgrn0 = "50.grn.0"
fsgrn0 = open(fgrn0)
hdgrn0, grn0 = readsac(fsgrn0)
close(fsgrn0)
# green func 1
fgrn1 = "50.grn.1"
fsgrn1 = open(fgrn1)
hdgrn1, grn1 = readsac(fsgrn1)
close(fsgrn1)
# green func 2
fgrn2 = "50.grn.2"
fsgrn2 = open(fgrn2)
hdgrn2, grn2 = readsac(fsgrn2)
close(fsgrn2)
# green func 3
fgrn3 = "50.grn.3"
fsgrn3 = open(fgrn3)
hdgrn3, grn3 = readsac(fsgrn3)
close(fsgrn3)
# green func 4
fgrn4 = "50.grn.4"
fsgrn4 = open(fgrn4)
hdgrn4, grn4 = readsac(fsgrn4)
close(fsgrn4)
# green func 5
fgrn5 = "50.grn.5"
fsgrn5 = open(fgrn5)
hdgrn5, grn5 = readsac(fsgrn5)
close(fsgrn5)
# green func 6
fgrn6 = "50.grn.6"
fsgrn6 = open(fgrn6)
hdgrn6, grn6 = readsac(fsgrn6)
close(fsgrn6)
# green func 7
fgrn7 = "50.grn.7"
fsgrn7 = open(fgrn7)
hdgrn7, grn7 = readsac(fsgrn7)
close(fsgrn7)
# green func 8
fgrn8 = "50.grn.8"
fsgrn8 = open(fgrn8)
hdgrn8, grn8 = readsac(fsgrn8)
close(fsgrn8)

# source parameters 
strike = 155.0
dip = 82.0
rake = 172.0
azimuth = 226.8
rad =  dc_radiat(azimuth-strike, dip, rake)
#println(rad[1,1])
#println(rad[1,2])
#println(rad[1,3])
#println(rad[2,1])
#println(rad[2,2])
#println(rad[2,3])
#println(rad[3,1])
#println(rad[3,2])
#println(rad[3,3])

m0 = 6.0
m0 = 10.0^(1.5*m0+16.1-20.0)
dura = 2.0
rise = 0.2
dt = 0.1
src = trapezoid(dura, rise, dt)
ns = round(Int64, dura/dt)
#for i=1:1:ns+1
#    println(src[i])
#end

npt = convert(Int64, hdgrn0["npts"])
syn = zeros(Float64, 3, npt)

for k = 1:1:hdgrn0["npts"]
    syn[1,k] = m0 * (rad[1,1]*grn0[k] + rad[2,1]*grn3[k] + rad[3,1]*grn6[k])
    syn[2,k] = m0 * (rad[1,2]*grn1[k] + rad[2,2]*grn4[k] + rad[3,2]*grn7[k])
    syn[3,k] = m0 * (rad[1,3]*grn2[k] + rad[2,3]*grn5[k] + rad[3,3]*grn8[k])
end

pt1 = conv(src, ns, syn[1,:], npt)
pt2 = conv(src, ns, syn[2,:], npt)
pt3 = conv(src, ns, syn[3,:], npt)

for i=1:1:npt
    #println(syn[3,i])
    #println(pt3[i])
    println(pt1[i], " ", pt2[i], " ", pt3[i])
end
