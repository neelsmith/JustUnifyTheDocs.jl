
"""Rewrite markdown source in `mdsrc` by converting relative paths to full paths.

$(SIGNATURES)
"""
function adjustpaths(mdsrc, dir)
    p = Parser()
    parsed = p(mdsrc)
    for (node, enter) in parsed
        if enter
            @info("Entering new ", node.t)
            if node.t isa CommonMark.Link
                node.t.destination = rewrite_link(node.t.destination, dir)
            end
        end
    end
    n
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
        joinpath(dir, s)
    end
end