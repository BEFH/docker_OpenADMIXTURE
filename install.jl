  #!/usr/bin/env julia
  using Pkg
  Pkg.add(url="https://github.com/kose-y/SKFR.jl", rev="802fedb")
  Pkg.add(url="https://github.com/BEFH/OpenADMIXTURE.jl", rev="a60ade5")
  pkg"add CSV CUDA Tables Printf ArgParse"
