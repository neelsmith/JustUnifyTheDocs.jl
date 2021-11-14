using JustUnifyTheDocs
using Test

@testset "Test reading directory of pages" begin
   testsite = joinpath(pwd(), "data", "docs1") 
   pgs = readpages(testsite)
   @test isa(pgs, Vector{JTDPage})
end