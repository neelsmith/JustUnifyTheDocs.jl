using UnifyJustTheDocs
using Test

include("test_pageparsing.jl")

#=
@testset "Test reading directory of pages" begin
   testsite = joinpath(pwd(), "data", "samplesite") 
   pgs = readpages(testsite)
   @test isa(pgs, Vector{JTDPage})
end



@testset "Test rewriting markdown links" begin
   f = "data/link.md"
   fullpath = realdir(f)
   
end
=#