@testset "Test modifying relative links in markdown" begin
    f = joinpath("data", "link.md")  |> realpath
    yaml = read(f, String)
    p = Parser()
    parsed = p(yaml)
end

@testset "Test adjusting destination strings" begin
    relpath = joinpath("data", "link.md")
    abspath = realpath(relpath)
    adjusted = UnifyJustTheDocs.rewrite_imglink("tegres.png", abspath)
    # Split this into parts and test that they end with "test", "data", "tegres.png"

end