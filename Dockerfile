FROM julia:1.6.7-alpine3.17
ARG JULIA_DEPOT_PATH="/julia_depot"
ENV JULIA_LOAD_PATH="$JULIA_DEPOT_PATH:$JULIA_LOAD_PATH"
COPY --chmod=555 OpenADMIXTURE.jl /usr/bin/OpenADMIXTURE
COPY install.jl /opt/src/scripts/install.jl
RUN mkdir $JULIA_DEPOT_PATH && \
  julia /opt/src/scripts/install.jl

ENTRYPOINT ["OpenADMIXTURE"]
