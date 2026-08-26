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
- [1] `init.sh`
- [1] ENTRYPOINT
- [1] Environment variables
- [1] Runtime sequence
- [1] Volume usage
- [1] Defense questions

---

## 🌐 WordPress

- [1] Directory structure
- [1] Dockerfile
- [1] `init.sh`
- [1] WP-CLI commands
- [1] `wp-config.php`
- [1] Runtime sequence
- [1] Connection with MariaDB
- [1] Volume usage
- [1] Defense questions

---

## 🔒 Nginx

- [1] Directory structure
- [1] Dockerfile
- [1] `nginx.conf`
- [1] TLS certificates
- [1] FastCGI configuration
- [1] Runtime sequence
- [1] Defense questions

---

## 🐳 docker-compose.yml

- [1] Purpose of Docker Compose
- [1] `services`
- [1] `build`
- [1] `image`
- [1] `container_name`
- [1] `depends_on`
- [1] `restart`
- [1] `env_file`
- [1] `environment`
- [1] `volumes`
- [1] `networks`
- [1] Startup sequence
- [1] Defense questions

---

## ⚙️ Makefile

- [1] Variables
- [1] Targets
- [1] `.PHONY`
- [1] Execution flow

**✅ Phase 2 Complete**

</details>

---

# 🧠 Phase 3 — Docker Internals (Deep Understanding)

<details>
<summary><strong>Open Phase 3</strong></summary>

## Docker Architecture

- [1] Docker CLI
- [1] Docker Engine
- [1] `dockerd`
- [1] `containerd`
- [1] `runc`
- [1] OCI

---

## Images

- [1] Image layers
- [1] Build cache
- [1] Dockerfile execution
- [1] Image lifecycle

---

## Containers

- [1] Container lifecycle
- [1] Writable layer
- [1] PID 1
- [1] Signals
- [1] ENTRYPOINT vs CMD

---

## Storage

- [1] OverlayFS
- [1] Named Volumes
- [1] Bind Mounts
- [1] Anonymous Volumes

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