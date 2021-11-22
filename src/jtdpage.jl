"""A `JDTPage` has markdown content, and four optional
settings from its YAML header.  If the page lacks
properties for `parent` or `grand_parent`, their value
will be `nothing`; if no `nav_order` is set, its value
is 0.
"""
struct JTDPage
    title
    parent
    grand_parent
    nav_order::Int64
    markdown
end


"""Select from a list of pages all pages that
are in the root level of the site.
"""
function rootpages(pglist)
    pages = filter(pg -> isnothing(pg.parent), pglist)
    sort(pages, by = pg -> pg.nav_order)
end


"""Select children of a given page from a list of pages.

$(SIGNATURES)
"""
function childpages(pg, pglist)
    pages = filter(p -> p.parent == pg.title, pglist)
    sort(pages, by = p -> p.nav_order)
end

"""For a single page at the root level of the Jekyll
site's content hierarchy, compose a markdown
string with the content of the root page together with
the content of all of its children and grandchildren
pages.

$(SIGNATURES)
"""
function rootpage(pg, pagelist)
    contentarray = [pg.markdown]
    for kid in childpages(pg, pagelist)
        push!(contentarray, kid.markdown)
        for gkid in childpages(kid, pagelist)
            push!(contentarray, gkid.markdown)
        end
    end
    join(contentarray, "\n\n")
end


"""Compose a single markdown string with all content
of a Jekyll web site configured for the `just-the-doc` theme.

$(SIGNATURES)
""" 
function composite(rootdir; pandoc_anchors =  true)
    allpages = readpages(rootdir; anchors = pandoc_anchors)
    rootpgs = rootpages(allpages)
    allcontent = []
    for pg in rootpgs
        #println(pg.title)
        push!(allcontent, rootpage(pg, allpages))
    end
    join(allcontent, "\n\n")
end