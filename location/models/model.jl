function findp0(x::Float64, p0::Float64, topp::Int64, bttm::Int64, ray_len::Vector, vps::Vector)
    ZERO = 1.0e-7
    p1 = 0.0
    while p1 != p0
        p2 = p0
        p0 = 0.5*(p1+p2)
        dtdp0 = dtdp(x, p0, topp, bttm, ray_len, vps)
        if (abs(dtdp0) < ZERO || p0 == p1 || p0 == p2)
            return p0
        end
        if dtdp0 > 0.0
            p1 = p0
            p0 = p2
        end
    end
    return p0
end

function taup(x::Float64, p::Float64, topp::Int64, bttm::Int64, ray_len::Vector, vps::Vector)
    taup0 = p*x
    pp = p*p
    for i=topp:1:bttm
        taup0 = taup0 + sqrt(vps[i]-pp) * ray_len[i]
    end
    return taup0
end

function dtdp(x::Float64, p::Float64, topp::Int64, bttm::Int64, ray_len::Vector, vps::Vector)
    pp = p*p
    dtdp0 = 0.0
    for j=topp:1:bttm
        dtdp0 = dtdp0 - ray_len[j]/sqrt(vps[j]-pp)
    end
    dtdp0 = x + p*dtdp0
    return dtdp0
end

function trav(paras::Vector, rcv_lat::Float64, rcv_lon::Float64, rcv_dep::Float64, num_lay::Int64, thk::Vector, vp::Vector)
    src_lat = paras[1]
    src_lon = paras[2]
    src_dep = paras[3]
    rcv_latlon = LatLon(rcv_lat, rcv_lon)
    src_latlon = LatLon(src_lat, src_lon)
    x = distance(src_latlon, rcv_latlon, wgs84)
    x = x/1000.0
    # compute the layer of source and receiver that located
    lay_dep = 0.0
    for i=1:1:num_lay
        lay_dep = lay_dep + thk[i]
        if lay_dep > rcv_dep
            rcv_lay = i
            break
        end
    end
    lay_dep = 0.0
    for i=1:1:num_lay
        lay_dep = lay_dep + thk[i]
        if lay_dep > src_dep
            src_lay = i
            break
        end
    end
    if src_lay < rcv_lay
        i = src_lay
        src_lay = rcv_lay
        rcv_lay = i
    end
    vps = Vector(num_lay)
    for i=1:1:num_lay
        vps[i] = 1.0/vp[i]^2
    end

    # direct arrival
    topp = rcv_lay + 1
    bttm = src_lay
    aa = 1.0e20
    ray_len = Vector(num_lay)
    for k = topp:1:bttm
        ray_len[k] = thk[k]
        aa = aa < vps[k] ? aa : vps[k]
    end
    pd = sqrt(aa)
    pd = findp0(x, pd, topp, bttm, ray_len, vps)
    td = taup(x, pd, topp, bttm, ray_len, vps)
    t0 = td
    p0 = pd

    # reflected arrivals from below
    for bttm = src_lay+1:1:num_lay-1
        ray_len[bttm] = 2.0 * thk[bttm]
        aa = aa < vps[bttm] ? aa : vps[bttm]
        p = sqrt(aa)
        p = findp0(x, p, topp, bttm, ray_len, vps)
        aa = aa < vps[bttm+1] ? aa : vps[bttm+1]
        pc = sqrt(aa)
        if p > pc
            p = pc
        end
        t = taup(x, p, topp, bttm, ray_len, vps)
        if t < t0
             t0 = t
             p0 = p
        end
    end

    # reflected arrivals from above
    bttm = src_lay
    for topp = rcv_lay:-1:1
        ray_len[topp] = 2.0*thk[topp]
        aa = aa < vps[topp] ? aa : vps[topp]
        p = sqrt(aa)
        p = findp0(x, p, topp, bttm, ray_len, vps)
        if topp > 1
            aa = aa < vps[topp-1] ? aa : vps[topp-1]
        end
        pc = sqrt(aa)
        if p > pc
            p = pc
        end
        t = taup(x, p, topp, bttm, ray_len, vps)
        if t < t0
             t0 = t
             p0 = p
        end
    end
    return t0, td
end
