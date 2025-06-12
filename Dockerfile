# Set the base image.
FROM --platform=linux/amd64 ubuntu:22.04
SHELL ["bash", "-c"]

# Install curl, ca-certificates and libunwind8.
RUN apt -yq update && \
    apt -yqq install --no-install-recommends curl ca-certificates libunwind8

WORKDIR /pocket-ic

# Download pocket-ic.
ARG POCKET_REV=f195ba756bc3bf170a2888699e5e74101fdac6ba
RUN curl -L --retry 3 --retry-delay 5 --output pocket-ic.gz "https://download.dfinity.systems/ic/${POCKET_REV}/binaries/x86_64-linux/pocket-ic.gz"

# Extract pocket-ic.
RUN gzip -f -d pocket-ic.gz && \
    chmod +x pocket-ic

# Run pocket-ic.
CMD ["/bin/bash", "-c", "/pocket-ic/pocket-ic --ip-addr 0.0.0.0 --port 8081 --port-file pocket-ic-port --ttl 2592000"]
