# 🚀 Phase 1 — Understand the Technologies (The "What & Why" Phase)

<details>
<summary><strong>Open Phase 1</strong></summary>

## 🗄️ MariaDB

- [1] What is MariaDB?
- [1] Why does Inception require MariaDB?
- [1] Why MariaDB instead of MySQL?
- [1] Database fundamentals (DB, table, row, column, user, SQL)
- [1] How WordPress uses MariaDB

---

## 🌐 WordPress

- [1] What is WordPress?
- [1] Why does Inception require WordPress?
- [1] PHP basics
- [1] PHP-FPM
- [1] WP-CLI
- [1] How WordPress works internally

---

## 🔒 Nginx

- [1] What is Nginx?
- [1] Why do we need a web server?
- [1] Reverse Proxy
- [1] HTTPS
- [1] TLS 1.2 / TLS 1.3
- [1] SSL certificates
- [1] FastCGI
- [1] Complete request lifecycle

---

## 🐳 Docker

- [1] What is Docker?
- [1] Why containers?
- [1] VM vs Container
- [1] Images
- [1] Containers
- [1] Dockerfile
- [1] Docker Compose
- [1] Volumes
- [1] Networks

**✅ Phase 1 Complete**

</details>

---

# ⚙️ Phase 2 — Understand Your Inception Project

<details>
<summary><strong>Open Phase 2</strong></summary>

## 🗄️ MariaDB

- [1] Directory structure
- [1] Dockerfile (line by line)
- [1] `50-server.cnf`
- [] `init.sh`
- [ ] ENTRYPOINT
- [ ] Environment variables
- [ ] Runtime sequence
- [ ] Volume usage
- [ ] Defense questions

---

## 🌐 WordPress

- [ ] Directory structure
- [ ] Dockerfile
- [ ] `init.sh`
- [ ] WP-CLI commands
- [ ] `wp-config.php`
- [ ] Runtime sequence
- [ ] Connection with MariaDB
- [ ] Volume usage
- [ ] Defense questions

---

## 🔒 Nginx

- [ ] Directory structure
- [ ] Dockerfile
- [ ] `nginx.conf`
- [ ] TLS certificates
- [ ] FastCGI configuration
- [ ] Runtime sequence
- [ ] Defense questions

---

## 🐳 docker-compose.yml

- [ ] Purpose of Docker Compose
- [ ] `services`
- [ ] `build`
- [ ] `image`
- [ ] `container_name`
- [ ] `depends_on`
- [ ] `restart`
- [ ] `env_file`
- [ ] `environment`
- [ ] `volumes`
- [ ] `networks`
- [ ] Startup sequence
- [ ] Defense questions

---

## ⚙️ Makefile

- [ ] Variables
- [ ] Targets
- [ ] `.PHONY`
- [ ] Execution flow

**✅ Phase 2 Complete**

</details>

---

# 🧠 Phase 3 — Docker Internals (Deep Understanding)

<details>
<summary><strong>Open Phase 3</strong></summary>

## Docker Architecture

- [ ] Docker CLI
- [ ] Docker Engine
- [ ] `dockerd`
- [ ] `containerd`
- [ ] `runc`
- [ ] OCI

---

## Images

- [ ] Image layers
- [ ] Build cache
- [ ] Dockerfile execution
- [ ] Image lifecycle

---

## Containers

- [ ] Container lifecycle
- [ ] Writable layer
- [ ] PID 1
- [ ] Signals
- [ ] ENTRYPOINT vs CMD

---

## Storage

- [ ] OverlayFS
- [ ] Named Volumes
- [ ] Bind Mounts
- [ ] Anonymous Volumes

---

## Networking

- [ ] Bridge network
- [ ] Docker DNS
- [ ] Service discovery
- [ ] Ports vs Expose
- [ ] Container communication

---

## Linux

- [ ] Namespaces
- [ ] Cgroups
- [ ] Process isolation
- [ ] Resource limits

**✅ Phase 3 Complete**

</details>

---

# 🎓 Phase 4 — Defense Preparation

<details>
<summary><strong>Open Phase 4</strong></summary>

## Defense Practice

- [ ] MariaDB defense
- [ ] WordPress defense
- [ ] Nginx defense
- [ ] docker-compose.yml defense
- [ ] Makefile defense
- [ ] Docker architecture defense

---

## Runtime Explanations

- [ ] Explain the full startup sequence
- [ ] Explain an HTTP request from browser to WordPress
- [ ] Explain Docker startup from `make`

---

## Troubleshooting

- [ ] Database connection failures
- [ ] Nginx 502 errors
- [ ] TLS problems
- [ ] Volume issues
- [ ] Network issues
- [ ] Build failures

---

## Mock Defense

- [ ] 50-question evaluator session
- [ ] 100-question evaluator session
- [ ] Final evaluation

**🏆 Inception Mastered**

</details>