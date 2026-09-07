# Developer Documentation

## Project Overview

This project is a Docker-based web infrastructure composed of:

```text
NGINX
  |
  v
WordPress + PHP-FPM
  |
  v
MariaDB
```

The services are orchestrated with Docker Compose and communicate through a dedicated user-defined Docker network.

## Prerequisites

Install:

- Linux environment.
- Docker Engine.
- Docker Compose.
- GNU Make.

Verify:

```bash
docker --version
docker compose version
make --version
```

The project assumes the developer has permission to use Docker. If the local setup requires it, Docker commands may be run with `sudo`.

## Repository Structure

Typical structure:

```text
.
├── Makefile
├── README.md
├── USER_DOC.md
├── DEV_DOC.md
└── srcs
    ├── docker-compose.yml
    └── requirements
        ├── mariadb
        │   ├── Dockerfile
        │   ├── conf
        │   └── tools
        ├── nginx
        │   ├── Dockerfile
        │   ├── conf
        │   └── tools
        └── wordpress
            ├── Dockerfile
            ├── conf
            └── tools
```

Adapt the exact paths to the repository.

## Configuration

Create the environment configuration required by `docker-compose.yml`.

Do not hard-code real passwords in source files.

Keep sensitive local files out of version control when appropriate, for example by using `.gitignore`.

## Build and Launch

The project Makefile provides:

```bash
make
```

which invokes the default target.

Equivalent explicit command:

```bash
make up
```

The `up` target:

1. Creates the host data directories when necessary.
2. Builds or rebuilds the images.
3. Starts the Docker Compose stack.

The direct Docker Compose command is:

```bash
sudo docker compose -f srcs/docker-compose.yml up --build
```

## Makefile Commands

### Start

```bash
make
```

or:

```bash
make up
```

### Stop

```bash
make down
```

### Remove stack and named volumes

```bash
make clean
```

### Rebuild

```bash
make re
```

## Docker Compose Commands

Start in the foreground:

```bash
sudo docker compose -f srcs/docker-compose.yml up
```

Start in the background:

```bash
sudo docker compose -f srcs/docker-compose.yml up -d
```

Rebuild:

```bash
sudo docker compose -f srcs/docker-compose.yml build
```

View status:

```bash
sudo docker compose -f srcs/docker-compose.yml ps
```

View logs:

```bash
sudo docker compose -f srcs/docker-compose.yml logs
```

Follow logs:

```bash
sudo docker compose -f srcs/docker-compose.yml logs -f
```

Stop and remove containers/network:

```bash
sudo docker compose -f srcs/docker-compose.yml down
```

Stop and remove containers/network/volumes:

```bash
sudo docker compose -f srcs/docker-compose.yml down -v
```

## Managing Containers

List containers:

```bash
sudo docker ps
sudo docker ps -a
```

Inspect a container:

```bash
sudo docker inspect <container>
```

Open a shell when available:

```bash
sudo docker exec -it <container> /bin/bash
```

View logs:

```bash
sudo docker logs <container>
```

## Managing Images

List images:

```bash
sudo docker images
```

Build an image:

```bash
sudo docker build -t <image-name>:<tag> <path>
```

Remove an image:

```bash
sudo docker rmi <image>
```

## Managing Volumes

List volumes:

```bash
sudo docker volume ls
```

Inspect a volume:

```bash
sudo docker volume inspect <volume>
```

Remove a named volume:

```bash
sudo docker volume rm <volume>
```

Be careful: removing a volume can remove persistent project data.

## Managing Networks

List networks:

```bash
sudo docker network ls
```

Inspect the project network:

```bash
sudo docker network inspect inception
```

The services use the internal network to communicate by service name, for example:

```text
wordpress -> mariadb:3306
nginx     -> wordpress:9000
```

No public host port is required for MariaDB or PHP-FPM.

## Data Storage and Persistence

The project uses persistent storage so application data does not depend on the container writable layer.

The MariaDB data is mounted at:

```text
/var/lib/mysql
```

inside the MariaDB container.

The WordPress data is mounted at:

```text
/var/www/html
```

inside the WordPress container.

The project uses named volumes whose local driver is backed by host directories similar to:

```text
/home/<host-user>/data/mariadb
/home/<host-user>/data/wordpress
```

This gives the project predictable volume names and explicit host-side persistence.

### Persistence model

```text
MariaDB container
/var/lib/mysql
        |
        v
mariadb_data
        |
        v
/home/<host-user>/data/mariadb
```

and:

```text
WordPress container
/var/www/html
        |
        v
wordpress_data
        |
        v
/home/<host-user>/data/wordpress
```

Removing a container does not remove the named volume by default.

However:

```bash
docker compose down -v
```

does remove the Compose-managed named volumes.

## Build and Runtime Separation

A Dockerfile is executed during the **image build**:

```text
Dockerfile
   |
   v
docker build
   |
   v
Image layers
```

Container startup happens later:

```text
Image
   |
   v
Container
   |
   v
ENTRYPOINT / CMD
   |
   v
Main service process
```

The image layers are read-only; the container normally receives a writable layer on top.

Persistent application data should be stored in a volume or bind mount instead of relying on the container writable layer.

## Service Initialization

Initialization scripts can be used to prepare a service before the final process becomes the container's main process.

For a shell entrypoint script, use `exec` when launching the long-running service, for example:

```bash
exec mariadbd --user=mysql
```

or:

```bash
exec php-fpm8.2 -F
```

This replaces the shell process with the service process so the service can become PID 1 and receive container signals directly.

## Runtime Troubleshooting

### MariaDB connection failure

Check:

```bash
sudo docker compose -f srcs/docker-compose.yml logs mariadb
sudo docker compose -f srcs/docker-compose.yml logs wordpress
```

Verify:

- MariaDB is running.
- The MariaDB database exists.
- The dedicated WordPress database user exists.
- Credentials match.
- The WordPress database host is `mariadb`.
- Port `3306` is reachable internally on the Docker network.

### NGINX 502

Check:

```bash
sudo docker compose -f srcs/docker-compose.yml logs nginx
sudo docker compose -f srcs/docker-compose.yml logs wordpress
```

Verify that PHP-FPM is running and listening on the address/port expected by NGINX.

### TLS problems

Check:

- Certificate and key paths.
- NGINX TLS configuration.
- Certificate validity.
- TLS versions configured by NGINX.
- Whether port `443` is published.

### Volume problems

Check:

```bash
sudo docker volume ls
sudo docker volume inspect mariadb_data
sudo docker volume inspect wordpress_data
```

Check host directories:

```bash
ls -ld /home/<host-user>/data/mariadb
ls -ld /home/<host-user>/data/wordpress
```

Check ownership and permissions when a service cannot read or write its data.

### Network problems

Check:

```bash
sudo docker network ls
sudo docker network inspect inception
```

Confirm all expected containers are attached to the same network.

Check service-name resolution from a container when the relevant tools are installed:

```bash
getent hosts mariadb
getent hosts wordpress
```

## Development Workflow

Recommended workflow:

```text
Edit Dockerfile / configuration
        |
        v
make re
        |
        v
Check container status
        |
        v
Check logs
        |
        v
Test HTTPS and WordPress
        |
        v
Inspect network/volumes if needed
```

Before submitting:

```bash
make re
sudo docker compose -f srcs/docker-compose.yml ps
sudo docker compose -f srcs/docker-compose.yml logs
```

Confirm that:

- All required services are running.
- HTTPS works.
- WordPress can reach MariaDB.
- Data remains after recreating containers.
- Only intended ports are published.
- The repository contains no accidental credentials.
