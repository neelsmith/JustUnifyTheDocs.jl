"""A `JDTPage` has markdown content, and up to four
settings from its YAML header.
"""
struct JTDPage
    title
    parent
    grand_parent
    nav_order::Int64
    markdown
end


"""Select from a list pages all pages that
are in the root level of the site.
"""
function rootpages(pglist)
    filter(pg -> isnothing(pg.parent), pglist)
end


"""Select children of a give page in a pagelist.

$(SIGNATURES)
"""
function childpages(pg, pglist)
    filter(p -> p.parent == pg.title, pglist)
end

"""Select pages tagged grandchild.

$(SIGNATURES)
"""
function grandchildpages(parentpg, pglist)
    filter(p -> p.grand_parent == parentpg.title, pglist)
end



function rootpage(pg, pagelist)
    contentarray = [pg.markdown]
    for kid in childpages(pg, pagelist)
        push!(contentarray, kid.markdown)
        for gkid in grandchildpages(kid, pagelist)
            push!(contentarray, gkid.markdown)
        end
    end
    join(contentarray, "\n\n")
end

function composite(rootdir)
    allpages = readpages(rootdir)
    rootpgs = rootpages(allpages)
    allcontent = []
    for pg in rootpgs
        #println(pg.title)
        push!(allcontent, rootpage(pg, allpages))
    end
    join(allcontent, "\n\n")
end