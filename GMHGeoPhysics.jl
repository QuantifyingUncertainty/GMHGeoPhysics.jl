module GMHGeoPhysics

import GeneralizedMetropolisHastings:
    parameters,noise,data,model,
    applynoise!,
    AbstractNoiseModel

import Geodesy:
    LatLon,distance,wgs84

export
    locationmodel,focalmodel

include("location/models/model.jl")
#include("focal/models/model.jl")

end
