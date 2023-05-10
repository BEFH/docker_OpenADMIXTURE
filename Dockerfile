FROM julia:1.6.7-alpine3.17
ARG JULIA_DEPOT_PATH="/usr/local/julia/share/julia"
COPY --chmod=555 OpenADMIXTURE.jl /usr/bin/OpenADMIXTURE
COPY install.jl /opt/src/scripts/install.jl
RUN julia /opt/src/scripts/install.jl && \
  chmod -R go+rX $JULIA_DEPOT_PATH
ENV JULIA_LOAD_PATH="@:@v#.#:@stdlib:$JULIA_DEPOT_PATH/environments/v1.6"

ENTRYPOINT ["OpenADMIXTURE"]
