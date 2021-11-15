using JustUnifyTheDocs
using Test

@testset "Test reading directory of pages" begin
   testsite = joinpath(pwd(), "data", "samplesite") 
   pgs = readpages(testsite)
   @test isa(pgs, Vector{JTDPage})

   
end