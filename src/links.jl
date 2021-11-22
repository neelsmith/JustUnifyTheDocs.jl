
"""Rewrite markdown source in `mdsrc` to account for relative links in embedded images and direct links to files.


$(SIGNATURES)
Relative paths in image links are converted to full file paths.
If the `relpath` parameter is included, elative links to file contents are converted to internal links to pandoc headers. See the docs for more details.
"""
function adjustpaths(mdsrc, dir; relpath = "")
    linkbase = join(splitpath(relpath), "-")
    p = Parser()
    parsed = p(mdsrc)
    for (node, enter) in parsed
        if enter
            if node.t isa CommonMark.Image
                node.t.destination = rewrite_imglink(node.t.destination, dir)

            elseif node.t isa CommonMark.Link
                if ! isempty(linkbase)
                    newdest = "#" * join([linkbase, node.t.destination],"-")
                    node.t.destination = rewrite_internallink(node.t.destination, newdest)
                end
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
function rewrite_imglink(s, dir)
    if startswith(s, r"https?:")
        s
    elseif startswith(s, "/")
        s
    else
        @info("Expanding link path to ", joinpath(dir, s))
        joinpath(dir, s)
    end
end



function rewrite_internallink(s, locallink)
    if startswith(s, r"https?:")
        s
    elseif startswith(s, "/")
        s
    elseif startswith(s, "#")
        s
    else
        locallink
    end
end