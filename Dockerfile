FROM julia:1.6.7-alpine3.17
ARG JULIA_DEPOT_PATH="/usr/local/julia/share/julia"
COPY --chmod=555 OpenADMIXTURE.jl /usr/bin/OpenADMIXTURE
COPY install.jl /opt/src/scripts/install.jl
RUN julia /opt/src/scripts/install.jl

ENTRYPOINT ["OpenADMIXTURE"]
