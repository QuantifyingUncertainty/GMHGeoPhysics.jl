testfolder = dirname(@__FILE__())

unittests = [
    "location",
    "focal",
    "finitefault"]

println("===================")
println("Running unit tests:")
println("===================")

for t in unittests
    tfile = joinpath(testfolder,"unit",string(t,".jl"))
    println("  * $(tfile) *")
    include(tfile)
    println()
end
