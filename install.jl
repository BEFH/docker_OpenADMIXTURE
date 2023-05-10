  #!/usr/bin/env julia
  using Pkg
  Pkg.add(url="https://github.com/kose-y/SKFR.jl", rev="802fedb")
  Pkg.add(url="https://github.com/OpenMendel/OpenADMIXTURE.jl", rev="76847be")
  pkg"add SnpArrays CSV DelimitedFiles CUDA Tables Printf ArgParse"
