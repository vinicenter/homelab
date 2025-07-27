# 🏠 Homelab Infrastructure

A complete Docker-based homelab setup with automated deployment, reverse proxy, and monitoring solutions. This repository contains everything needed to deploy and manage a self-hosted infrastructure using Docker Compose, Ansible, and Nginx.

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

2. **Start the Gateway** (Nginx reverse proxy):
   ```bash
   cd gateway
   ./startGateway.sh
   ```

3. **Deploy Application Stack**:
   ```bash
   cd stacks
   docker compose up -d
   ```

## 🏗️ Architecture

### Gateway Layer
- **Nginx**: Stream-based reverse proxy for SSL termination (to expose services to the internet)
- **Traefik**: Container-aware reverse proxy with automatic SSL certificates (to keep service on VPN only)

## 🛠️ Prerequisites

- **Operating System**: Ubuntu/Debian-based Linux
- **Docker**: Installed via the provided Ansible playbook
- **Domain**: Configured DNS pointing to your server
- **Tailscale Account**: For VPN connectivity (optional)

## 📋 Services Overview

| Service | Purpose | Notes |
|---------|---------|-------|
| Traefik | Reverse Proxy | Automatic SSL certificates |
| AdGuard Home | DNS Ad Blocking | Network-wide protection |
| Jellyfin | Media Server | Movies, TV shows, music |
| Home Assistant | Home Automation | Smart home control |
| Uptime Kuma | Monitoring | Service availability |
| File Browser | File Management |  Web-based file access |
| Glance | Dashboard | Service overview |

## 🔐 Security Features

- **SSL/TLS**: Automatic certificate management with Let's Encrypt
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
