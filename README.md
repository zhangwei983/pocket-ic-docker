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
docker run -p 8081:8081 -e PORT=8081 -e TTL=2592000 --name pocket-ic -t pocket-ic
```

- `-e PORT=8081` to let `pocket-ic` listen on port `8081`
- `-e TTL=2592000` to let `pocket-ic` wait 2592000 seconds (30 days) for connecting before exiting
- `-p 8081:8081` to map the host port to the container port

Use the below command to start an existing docker container:

```bash
docker start pocket-ic
```

Use the below command to check the binding port:

```bash
docker port pocket-ic
```

You will see something similar as below:

```bash
8081/tcp -> 0.0.0.0:8081
```

### Run the test

Please run below commands to run the test against the `pocket-ic server` running inside the container.

```bash
cd pocket-ic-test
cargo run
```

You will see something similar as below:

```bash
pocket ic id: 0
canister id: "lxzze-o7777-77777-aaaaa-cai"
```
