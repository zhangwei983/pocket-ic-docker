# Build a pocket-ic docker image 

Build a docker image with [pocket-ic](https://github.com/dfinity/pocketic) installed.

## How to run

### Build image

Please check the [Dockerfile](./Dockerfile) for details.

Use the below command to build the docker image:

```bash
docker build -t pocket-ic .
```

Or use `--build-arg` to provide a specific pocket-ic version:

```bash
docker build --build-arg POCKET_REV=f195ba756bc3bf170a2888699e5e74101fdac6ba -t pocket-ic .
```

### Run image

Use the below command to run a docker image:

```bash
docker run -p 8080:8080 -p 8081:8081 --name pocket-ic -t pocket-ic
```
- `-p 8080:8080` to map the `replica URL` port to the container port
- `-p 8081:8081` to map the `pocket-ic server` port to the container port

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
8080/tcp -> 0.0.0.0:8080
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
