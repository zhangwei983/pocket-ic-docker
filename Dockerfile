# Set the base image.
FROM --platform=linux/amd64 ubuntu:22.04
SHELL ["bash", "-c"]

# Install curl, ca-certificates and libunwind8.
RUN apt -yq update && \
    apt -yqq install --no-install-recommends curl ca-certificates libunwind8

WORKDIR /pocket-ic

# Download pocket-ic.
ARG POCKET_IC_URL=https://github.com/dfinity/pocketic/releases/latest/download/pocket-ic-x86_64-linux.gz
RUN curl -L --retry 3 --retry-delay 5 --output pocket-ic.gz "${POCKET_IC_URL}"

# Extract pocket-ic.
RUN gzip -f -d pocket-ic.gz && \
    chmod +x pocket-ic

# Run pocket-ic.
ENV PORT=0
ENV TTL=60
CMD ["/bin/bash", "-c", "/pocket-ic/pocket-ic --ip-addr 0.0.0.0 --port ${PORT} --ttl ${TTL}"]
