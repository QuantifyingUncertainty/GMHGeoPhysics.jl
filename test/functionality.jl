testfolder = dirname(@__FILE__())

functionalitytests = [
    "location",
    "focal",
    "finitefault"]

println("============================")
println("Running functionality tests:")
println("============================")

for t in functionalitytests
    tfile = joinpath(testfolder,"functionality",string(t,".jl"))
    println("  * $(tfile) *")
    include(tfile)
    println()
end
