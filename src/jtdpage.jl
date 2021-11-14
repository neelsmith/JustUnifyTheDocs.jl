struct JTDPage
    parent
    grand_parent
    nav_order
    markdown
end

function rootpages(pglist)
    filter(pg -> isnothing(pg.parent), pglist)
end