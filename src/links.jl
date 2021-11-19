
"""Rewrite markdown source in `mdsrc` by converting relative paths to full paths.

$(SIGNATURES)
"""
function adjustpaths(mdsrc, dir)
    p = Parser()
    parsed = p(mdsrc)
    for (node, enter) in parsed
        if enter
            if node.t isa CommonMark.Link
                node.t.destination = rewrite_link(node.t.destination, dir)
                #@info("Modified destination to ", node.t.destination)
            end
        end
    end
    
    # Format rewritten AST as a markdown string:
    iobuf = IOBuffer()
    env = Dict{String,Any}()
    writer = CommonMark.Writer(CommonMark.Markdown(iobuf), iobuf, env)
    CommonMark.write_markdown(writer, parsed)
    String(take!(iobuf))
end

"""If `s` is a relative destination for a link, change to an absolute
destination relative to `dir`.

$(SIGNATURES)
"""
function rewrite_link(s, dir)
    if startswith(s, r"https?:")
        s
    elseif startswith(s, "/")
        s
    else
        @info("Expanding link path to ", joinpath(dir, s))
        joinpath(dir, s)
    end
end