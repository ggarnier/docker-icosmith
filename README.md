[Icosmith](https://github.com/tulios/icosmith) Dockerfile

# Instructions

Build the image:

```sh
docker build -t icosmith .
```

Run the container:

```sh
docker run --rm --name icosmith -p 3000:3000 icosmith
```

The application will be accessible at port 3000 of the host machine.
