#get the correct paths and filenames on all systems
testfolder = dirname(@__FILE__())
importsfile = joinpath(testfolder,"imports.jl")
utilfile = joinpath(testfolder,"util.jl")

#import all test functionality
include(importsfile)
include(utilfile)

#make the run repeatable
srand(0)

println()
println("===========================================")
println("+++++++++++++++++++++++++++++++++++++++++++")
println("Running all tests with ",nprocs()," process")
println("+++++++++++++++++++++++++++++++++++++++++++")
println("===========================================")
println()

#all test categories
alltests = [
    "unit",
    "performance",
    "functionality"]

for t in alltests
    tfile = joinpath(testfolder,string(t,".jl"))
    println("  * $(tfile) *")
    include(tfile)
    println()
end

println("===================")
println("Completed all tests")
println("===================")
