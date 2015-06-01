[Icosmith](https://github.com/tulios/icosmith) Dockerfile

# Instructions

## Building the image

```sh
docker build -t icosmith .
```

Or you can just pull it from the [Docker hub repository](https://registry.hub.docker.com/u/ggarnier/icosmith/):

```sh
docker pull ggarnier/icosmith
```

## Running the container

```sh
docker run --rm --name icosmith -p 3000:3000 ggarnier/icosmith
```

The application will be accessible at port 3000 of the host machine.
