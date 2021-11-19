@testset "Test segmenting page parts" begin
    homepage = joinpath("data", "samplesite", "index.md")  |> realpath
    (yaml,md) = UnifyJustTheDocs.pageparts(homepage)
    @test yaml isa String
    @test md isa String


    noyaml = joinpath("data", "link.md")  |> realpath
    (yaml2, md2) = UnifyJustTheDocs.pageparts(noyaml)
    @test isempty(yaml2)
    @test md2 isa String
end

