FROM julia:1.6.7-alpine3.17
COPY OpenADMIXTURE.jl /usr/bin/OpenADMIXTURE
RUN chmod 555 /usr/bin/OpenADMIXTURE && \
  <<EOF
  #!/usr/bin/env julia
  using Pkg
  Pkg.add(url="https://github.com/kose-y/SKFR.jl", rev="802fedb")
  Pkg.add(url="https://github.com/OpenMendel/OpenADMIXTURE.jl", rev="76847be")
  pkg"add SnpArrays CSV DelimitedFiles CUDA Tables Printf ArgParse"
EOF

ENTRYPOINT ["OpenADMIXTURE"]
