FROM julia:1.6.7-alpine3.17
ENV JULIA_DEPOT_PATH="/julia_depot"
COPY OpenADMIXTURE.jl /usr/bin/OpenADMIXTURE
COPY install.jl /opt/src/scripts/install.jl
RUN chmod 555 /usr/bin/OpenADMIXTURE && \
  mkdir $JULIA_DEPOT_PATH && \
  julia /opt/src/scripts/install.jl

ENTRYPOINT ["OpenADMIXTURE"]
