# Build a pocket-ic docker image 

Build a docker image with [pocket-ic](https://github.com/dfinity/pocketic) installed.

## How to run

### Build image

Please check the [Dockerfile](./Dockerfile) for details.

Use the below command to build the docker image:

```bash
docker build -t pocket-ic .
```

Or use `--build-arg` to provide custom pocket-ic download url:

```bash
docker build --build-arg POCKET_IC_URL=https://github.com/dfinity/pocketic/releases/download/8.0.0/pocket-ic-x86_64-linux.gz -t pocket-ic .
```

### Run image

Use the below command to run a docker image:

```bash
docker run --name pocket-ic -t pocket-ic
```

Use the below command to start an exited docker container:

```bash
docker start pocket-ic
```
