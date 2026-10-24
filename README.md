# 🏠 Homelab Infrastructure

A complete Docker-based homelab setup with automated deployment and monitoring solutions. This repository contains everything needed to deploy and manage a self-hosted infrastructure using Docker Compose and Ansible, exposed to the internet through a Pangolin gateway.

## 🚀 Quick Start

### Initial Server Setup

To prepare a new server with SSH and VPN connectivity, run:

```bash
bash <(wget -qO- https://raw.githubusercontent.com/vinicenter/homelab/main/pre-server-install.sh)
```

This script will:
- Set a custom hostname
- Install and configure Tailscale VPN
- Enable Tailscale SSH access

### Deploy Services

1. **Install Docker** (using Ansible):
   ```bash
   cd ansible
   ansible-playbook -i inventory playbooks/install_docker.yml
   ```

    Alternatively, if you want to run the playbook in only one host:

   ```bash
   cd ansible
   ansible-playbook -i inventory playbooks/install_docker.yml -l neptune
   ```

2. **Deploy Application Stack**:
   ```bash
   cd stacks
   docker compose up -d
   ```

## 🏗️ Architecture

### Gateway Layer

Ingress is handled by **Pangolin**, running on a separate Oracle Cloud VPS. There is no
reverse proxy in this repository anymore.

The **Newt** agent runs natively on this server (systemd) and dials out to Pangolin, so
no inbound port needs to be opened on the home network. Every HTTP service therefore
publishes **only on `127.0.0.1`**, where Newt can reach it but the LAN cannot:

| Service | Local address |
|---------|---------------|
| Glance | `127.0.0.1:8080` |
| AdGuard Home (web UI) | `127.0.0.1:3000` |
| Uptime Kuma | `127.0.0.1:3001` |
| Neon Drift Server | `127.0.0.1:3002` |
| OpenSpeedTest | `127.0.0.1:3003` |
| File Browser | `127.0.0.1:8081` |
| Home Assistant | `127.0.0.1:8123` (host network) |

When adding a service, publish it on the next free `127.0.0.1` port and create the
matching resource in the Pangolin dashboard.

AdGuard Home is the exception: its DNS ports (53, 853, 784, 5443, 8853) stay bound to
all interfaces, since LAN clients resolve through it directly.

## 🛠️ Prerequisites

- **Operating System**: Ubuntu/Debian-based Linux
- **Docker**: Installed via the provided Ansible playbook
- **Pangolin**: A reachable Pangolin instance, plus the Newt agent installed on this server
- **Tailscale Account**: For VPN connectivity (optional)

## 📋 Services Overview

| Service | Purpose | Notes |
|---------|---------|-------|
| AdGuard Home | DNS Ad Blocking | Network-wide protection |
| Home Assistant | Home Automation | Smart home control |
| Uptime Kuma | Monitoring | Service availability |
| File Browser | File Management |  Web-based file access |
| Glance | Dashboard | Service overview |

## 🔐 Security Features

- **SSL/TLS**: Terminated by Pangolin on the Oracle Cloud VPS
- **No inbound ports**: Newt dials out to Pangolin; services bind to `127.0.0.1` only
- **VPN Access**: Tailscale mesh networking
- **SSH Security**: Tailscale SSH for secure access
- **Container Isolation**: Docker container security
- **DNS Filtering**: AdGuard Home for malware protection

## 🚀 Deployment Tips

1. **Resource Planning**: Ensure adequate CPU, RAM, and storage for your services
2. **Backup Strategy**: Implement regular backups for important data volumes
3. **Monitoring**: Use Uptime Kuma to monitor service health
4. **Updates**: Regularly update container images for security patches
5. **Scaling**: Use Docker Compose scaling features for high-availability setups

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## 📝 License

This project is open source. Please check individual service licenses for specific requirements.

## 🆘 Support

- Check service logs: `docker compose logs [service-name]`
- Restart services: `docker compose restart [service-name]`
- Update services: `docker compose pull && docker compose up -d`

---

**Note**: This homelab setup is designed for personal use and learning. Always follow security best practices when exposing services to the internet.
