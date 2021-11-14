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
using JustUnifyTheDocs

makedocs(
    sitename="CitableParserBuilder.jl",
    pages = [
        "Guide" => "index.md",
    ]
    )

deploydocs(
    repo = "github.com/neelsmith/JustUnifyTheDocs.jl.git",
    push_preview = true
)