# Set the base image.
FROM --platform=linux/amd64 ubuntu:22.04
SHELL ["bash", "-c"]

COPY wrapper_script.sh wrapper_script.sh
RUN chmod +x wrapper_script.sh

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
CMD ["/bin/bash", "-c", "/wrapper_script.sh"]
