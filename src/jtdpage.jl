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
"""
function childpages(pg, pglist)
end
#childpages, grandchildpages