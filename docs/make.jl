# Run this from repository root, e.g. with
#
#    julia --project=docs/ docs/make.jl
#
# Run this from repository root to serve:
#
#   julia -e 'using LiveServer; serve(dir="docs/build")'julia -e 'using LiveServer; serve(dir="docs/build")'

using Pkg
Pkg.activate(".")
Pkg.instantiate()

using Documenter
using UnifyJustTheDocs

makedocs(
    sitename="UnifyJustTheDocs.jl",
    pages = [
        "Guide" => "index.md",
        "Resolving relative links" => "links.md",
        "How it works" => "how.md",


        "API documentation" => "api.md"
    ]
    )

deploydocs(
    repo = "github.com/neelsmith/UnifyJustTheDocs.jl.git"
)