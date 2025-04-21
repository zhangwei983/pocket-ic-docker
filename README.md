# Build a pocket-ic docker image 

Build a docker image with pocket-ic installed.

## How to run

Use the below command to build the docker image:

```bash
docker build -t pocket-ic .
```

Use the below command to run a docker image:

```bash
docker run --name pocket-ic -t pocket-ic
```

Use the below command to start an exited docker image:

```bash
docker start <CONTAINER_ID>
```

Use the below command to check the container id:

```bash
docker ps -a
```
