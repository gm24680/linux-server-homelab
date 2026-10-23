
# Homelab Architecture

## Overview

My homelab runs Ubuntu Server in a virtual machine on my Mac. I use macOS Terminal to administer the server remotely over SSH.

The Ubuntu server runs Nginx to serve a webpage over HTTP. UFW controls which incoming connections are permitted.

## Architecture Diagram

```mermaid
flowchart TD
    A["Mac / macOS"] --> B["Ubuntu Server VM"]
    A -- "SSH over TCP 22" --> C["OpenSSH"]
    A -- "HTTP over TCP 80" --> D["Nginx"]
    B --> E["UFW Firewall"]
    E -. "Permits incoming TCP 22" .-> C
    E -. "Permits incoming TCP 80" .-> D
    C --> F["Remote Administration"]
    D --> G["Webpage"]
```

## Components

- **Mac:** Provides physical computing resources and runs the virtualization software.
- **Ubuntu Server:** Guest operating system used for server administration.
- **OpenSSH:** Provides encrypted remote terminal access.
- **UFW:** Applies firewall rules to incoming network traffic.
- **Nginx:** Serves the HTTP webpage on TCP port 80.

## Verification

I verified the server using:

```bash
hostname
sudo ufw status verbose
sudo ss -tlnp
sudo nginx -t
systemctl is-active nginx
curl -I http://localhost
```

The HTTP test returned `200 OK`.
