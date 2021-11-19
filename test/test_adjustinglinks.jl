@testset "Test modifying relative links in markdown" begin
    f = joinpath("data", "link.md")  |> realpath
    yaml = read(f, String)
    parsed = p(yaml)
end

@testset "Test adjusting destination strings" begin
    relpath = joinpath("data", "link.md")
    abspath = realpath(relpath)
    
end