testfolder = dirname(@__FILE__())

performancetests = [
    "location",
    "focal",
    "finitefault"]

println("==========================")
println("Running performance tests:")
println("==========================")

for t in performancetests
    tfile = joinpath(testfolder,"performance",string(t,".jl"))
    println("  * $(tfile) *")
    include(tfile)
    println()
end
