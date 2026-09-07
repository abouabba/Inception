# User Documentation

## Services Provided

The project provides a small web infrastructure made of three main services:

- **NGINX**: public HTTPS entry point and reverse proxy.
- **WordPress + PHP-FPM**: website and PHP application runtime.
- **MariaDB**: database used by WordPress.

The services communicate internally through the Docker network named `inception`.

## Starting the Project

From the repository root:

```bash
make
```

or:

```bash
make up
```

This builds the images when required, creates the required host data directories, and starts the Docker Compose stack.

## Stopping the Project

```bash
make down
```

This stops and removes the project containers and network.

Persistent named volumes are kept by default.

## Cleaning the Project

```bash
make clean
```

This removes the containers, network, and named volumes.

**Warning:** removing the volumes removes persistent application data.

## Accessing the Website

Open the HTTPS address configured for the project in a web browser.

The public entry point is NGINX on HTTPS port `443`.

For example:

```text
https://abouabba.42.fr
```

The exact domain depends on the project's local hostname or domain configuration.

## Accessing the WordPress Administration Panel

Open:

```text
https://abouabba.42.fr/wp-admin
```

Sign in with the WordPress administrator credentials configured for the project.

## Credentials

Credentials are stored in the project's environment/configuration files according to the project setup.

Check the configuration before starting the stack.

Do not commit real passwords or other sensitive credentials to Git.

Typical categories include:

- WordPress administrator credentials.
- WordPress database user credentials.
- MariaDB root credentials.

The WordPress application should use its dedicated database user rather than the MariaDB root account.

## Checking That the Services Are Running

Check all containers:

```bash
sudo docker ps
```

Check Compose service status:

```bash
sudo docker compose -f srcs/docker-compose.yml ps
```

Check logs:

```bash
sudo docker compose -f srcs/docker-compose.yml logs
```

Check one service:

```bash
sudo docker compose -f srcs/docker-compose.yml logs nginx
sudo docker compose -f srcs/docker-compose.yml logs wordpress
sudo docker compose -f srcs/docker-compose.yml logs mariadb
```

## Checking Persistent Data

The persistent project data is stored in the configured host directories backing the Docker volumes.

Typical locations in this project are:

```text
/home/abouabba/data/mariadb
/home/abouabba/data/wordpress
```

Do not delete these directories unless you intentionally want to remove the stored data.

## Basic Troubleshooting

### Containers are not running

Run:

```bash
sudo docker compose -f srcs/docker-compose.yml ps
```

Then inspect:

```bash
sudo docker compose -f srcs/docker-compose.yml logs
```

### Website returns 502

Check:

```bash
sudo docker compose -f srcs/docker-compose.yml logs nginx
sudo docker compose -f srcs/docker-compose.yml logs wordpress
```

Make sure PHP-FPM is listening on the port configured in NGINX.

### WordPress cannot connect to MariaDB

Check:

```bash
sudo docker compose -f srcs/docker-compose.yml logs mariadb
sudo docker compose -f srcs/docker-compose.yml logs wordpress
```

Verify:

- MariaDB is running.
- The database exists.
- The WordPress database user exists.
- The credentials match.
- WordPress uses the service name `mariadb` rather than a hard-coded container IP.
