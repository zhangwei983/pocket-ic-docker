# Set the base image.
FROM --platform=linux/amd64 ubuntu:22.04
SHELL ["bash", "-c"]

# Install curl, ca-certificates and libunwind8.
RUN apt -yq update && \
    apt -yqq install --no-install-recommends curl ca-certificates libunwind8

WORKDIR /pocket-ic

# Download pocket-ic.
RUN curl -L --retry 3 --retry-delay 5 --output pocket-ic.gz https://github.com/dfinity/pocketic/releases/download/8.0.0/pocket-ic-x86_64-linux.gz

# Extract pocket-ic.
RUN gzip -f -d pocket-ic.gz && \
    chmod +x pocket-ic && \
    export POCKET_IC_BIN="$(pwd)/pocket-ic"

# Run pocket-ic.
CMD ["/bin/bash", "-c", "/pocket-ic/pocket-ic"]
