# Set the base image.
FROM --platform=linux/arm64 ubuntu:22.04
SHELL ["bash", "-c"]

COPY wrapper_script.sh wrapper_script.sh
RUN chmod +x wrapper_script.sh

# Install curl, ca-certificates and libunwind8.
RUN apt -yq update && \
    apt -yqq install --no-install-recommends curl ca-certificates libunwind8

WORKDIR /pocket-ic

# Download pocket-ic.
ARG POCKET_IC_URL=https://download.dfinity.systems/ic/0000000000000000000000000000000000000000/binaries/arm64-linux/pocket-ic-server-arm64-linux
RUN curl -L --retry 3 --retry-delay 5 --output pocket-ic "${POCKET_IC_URL}"

# Extract pocket-ic.
RUN chmod +x pocket-ic

# Run pocket-ic.
CMD ["/bin/bash", "-c", "/wrapper_script.sh"]
