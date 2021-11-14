struct JTDPage
    title
    parent
    grand_parent
    nav_order
    markdown
end

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