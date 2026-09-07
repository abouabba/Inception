*This project has been created as part of the 42 curriculum by <login1>.*

# Inception

## Description

Inception is a system administration and Docker project from the 42 curriculum. Its goal is to build a small web infrastructure composed of multiple Docker containers, each dedicated to a specific service, and to understand how containers, images, networks, volumes, TLS, databases, and reverse proxies work together.

The stack is built from custom Dockerfiles and is orchestrated with Docker Compose. The main services are:

- **NGINX** — reverse proxy and HTTPS web server.
- **WordPress + PHP-FPM** — content management application and PHP application runtime.
- **MariaDB** — relational database used by WordPress.

The services communicate through a dedicated Docker network, while persistent application data is stored outside the container writable layers using Docker volumes backed by host directories.

## Project Goal

The main goal is to create a secure, reproducible, multi-container infrastructure while learning:

- Docker images and Dockerfiles.
- Containers and their lifecycle.
- Docker Compose.
- Persistent storage with volumes and bind mounts.
- Container networking and service discovery.
- NGINX as a reverse proxy.
- TLS/HTTPS.
- MariaDB and WordPress integration.
- Basic container security and isolation.

## Architecture

```text
                         Internet
                            |
                         HTTPS :443
                            |
                            v
                  +-------------------+
                  |       NGINX       |
                  |  TLS / Reverse    |
                  |       Proxy       |
                  +---------+---------+
                            |
                     FastCGI :9000
                            |
                            v
                  +-------------------+
                  | WordPress + PHP-FPM|
                  +---------+---------+
                            |
                       MySQL/MariaDB
                            |
                         :3306
                            |
                            v
                  +-------------------+
                  |      MariaDB      |
                  +-------------------+

        All services are connected through the Docker
              user-defined "inception" network.
```

## Docker and Project Design Choices

### Why Docker is used

Each service runs in its own container. This keeps responsibilities separated, makes the infrastructure reproducible, and lets each service have its own dependencies and configuration.

The project uses custom Dockerfiles rather than relying on pre-built application images for the required services. Docker Compose is used to define the full stack, networks, volumes, dependencies, and startup configuration in one place.

### Main design choices

- One container per main service.
- NGINX is the only public entry point.
- HTTPS is terminated at NGINX.
- WordPress runs with PHP-FPM and does not use NGINX internally.
- MariaDB is isolated from direct public access.
- Services communicate through a dedicated Docker network.
- MariaDB and WordPress data are persisted using volumes.
- Host-side data directories are used as the backing storage for the project volumes.
- Credentials are provided through environment configuration rather than hard-coded in application source files.

## Virtual Machines vs Docker

| Virtual Machines | Docker Containers |
|---|---|
| Each VM includes a complete guest operating system. | Containers share the host kernel. |
| Usually heavier in memory and disk usage. | Usually lighter and faster to start. |
| Strong isolation at the virtual machine level. | Process-level isolation using Linux kernel features. |
| Can run a different guest kernel/OS. | Uses the host kernel. |
| Useful when full OS isolation is required. | Useful for portable, reproducible application environments. |

Docker is therefore a good fit for this project because the services can be isolated as processes while sharing the host kernel and remaining lightweight.

## Secrets vs Environment Variables

**Environment variables** are convenient for configuration such as database names, users, ports, and non-sensitive settings. However, sensitive credentials should be handled carefully because environment variables can be exposed through container inspection or process/runtime tooling depending on the setup.

**Docker secrets** are designed for sensitive data and are preferable when the deployment environment supports them, because the secret is handled separately from ordinary application configuration.

For this project, the required setup uses environment configuration for the stack's credentials. Secrets should not be committed to Git.

## Docker Network vs Host Network

### Docker Network

Containers attached to a Docker network have isolated networking and can communicate internally using service names.

For example:

```text
WordPress -> mariadb:3306
NGINX     -> wordpress:9000
```

This keeps internal services private and allows Docker DNS/service discovery to resolve service names.

### Host Network

With host networking, a container uses the host's network namespace instead of getting a separate container network namespace. This reduces network isolation and is unnecessary for the standard Inception architecture.

The project therefore uses a dedicated Docker network instead of host networking.

## Docker Volumes vs Bind Mounts

### Docker Volume

A named volume is managed by Docker:

```text
mariadb_data:/var/lib/mysql
```

Docker manages the storage location.

### Bind Mount

A bind mount maps an explicit host path into the container:

```text
/home/<host-user>/data/mariadb:/var/lib/mysql
```

The host path is chosen and managed by the administrator.

### Project choice

The project uses **named Docker volumes backed by bind mounts** so that the volumes have predictable names while the actual persistent data is stored in the required host directories.

## Services

### NGINX

NGINX is the public-facing reverse proxy. It handles TLS and forwards application requests to WordPress/PHP-FPM.

### WordPress + PHP-FPM

WordPress provides the web application. PHP-FPM executes PHP requests. WordPress does not run an NGINX server inside its own container.

### MariaDB

MariaDB stores WordPress's structured application data. WordPress connects to MariaDB through the internal Docker network.

## Requirements and Technical Choices

- Custom Dockerfiles are used for the required services.
- Docker Compose manages the multi-container application.
- Services communicate through a dedicated Docker network.
- Persistent data is stored outside container writable layers.
- NGINX provides HTTPS using TLS.
- WordPress connects to MariaDB using the MariaDB service name instead of a hard-coded IP address.
- The MariaDB root account is not used by WordPress; a dedicated application database user is used instead.
- Application initialization is performed by service entrypoint scripts where required.

## Instructions

### Prerequisites

Install and configure:

- Linux environment suitable for Docker.
- Docker Engine.
- Docker Compose plugin.
- GNU Make.

Check the installation:

```bash
docker --version
docker compose version
make --version
```

### Repository layout

A typical project layout is:

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
        ├── nginx
        └── wordpress
```

### Configuration

Create the required environment configuration file according to the project setup. Do not commit real credentials to the repository.

The Compose file should reference the environment configuration where appropriate.

### Build and start

From the repository root:

```bash
make
```

or:

```bash
make up
```

The Makefile creates the host data directories and starts the Docker Compose stack with a build.

To start directly with Compose:

```bash
sudo docker compose -f srcs/docker-compose.yml up --build
```

### Stop the stack

```bash
make down
```

This stops and removes the project containers and network while keeping named volumes by default.

### Clean the stack

```bash
make clean
```

This uses:

```bash
docker compose down -v
```

and removes the named volumes as well. Use it only when you intentionally want to remove persistent project data.

### Rebuild from scratch

```bash
make re
```

This cleans the current stack and starts it again.

## Usage

After the stack is running, access the website through the HTTPS endpoint configured for the project.

The administration panel is normally available through the WordPress administration path:

```text
/wp-admin
```

Use the credentials defined in the project's environment/configuration.

## Checking the Stack

List running containers:

```bash
sudo docker ps
```

Inspect the Compose application:

```bash
sudo docker compose -f srcs/docker-compose.yml ps
```

View logs:

```bash
sudo docker compose -f srcs/docker-compose.yml logs
```

View a specific service:

```bash
sudo docker compose -f srcs/docker-compose.yml logs mariadb
sudo docker compose -f srcs/docker-compose.yml logs wordpress
sudo docker compose -f srcs/docker-compose.yml logs nginx
```

Inspect volumes:

```bash
sudo docker volume ls
sudo docker volume inspect mariadb_data
sudo docker volume inspect wordpress_data
```

Inspect networks:

```bash
sudo docker network ls
sudo docker network inspect inception
```

## Resources

### Official documentation

- Docker Documentation: https://docs.docker.com/
- Docker Engine documentation: https://docs.docker.com/engine/
- Docker Compose documentation: https://docs.docker.com/compose/
- Docker storage documentation: https://docs.docker.com/engine/storage/
- Docker networking documentation: https://docs.docker.com/engine/network/
- Dockerfile reference: https://docs.docker.com/reference/dockerfile/
- MariaDB Documentation: https://mariadb.com/docs/
- WordPress Documentation: https://wordpress.org/documentation/
- NGINX Documentation: https://nginx.org/en/docs/
- PHP-FPM documentation: https://www.php.net/manual/en/install.fpm.php
- Open Container Initiative: https://opencontainers.org/

### AI usage

AI tools were used as a learning and productivity aid during the project. They were used for:

- Explaining Docker, Docker Compose, networking, storage, and container-runtime concepts.
- Helping understand Dockerfile and Compose behavior.
- Supporting troubleshooting and interpreting command output and error messages.
- Reviewing configuration logic and suggesting possible causes of runtime issues.
- Helping structure documentation and explain technical concepts clearly.

AI was not used as a replacement for understanding or verifying the project. Final implementation, testing, configuration decisions, and project validation remain the responsibility of the project author.

## License

This project is part of the 42 curriculum and is intended for educational purposes.
