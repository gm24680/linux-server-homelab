
# Linux Server Administration & Network Security Homelab

## Project Overview

This project documents my experience deploying, configuring, and troubleshooting an Ubuntu Server virtual machine.

The goal was to develop practical skills in Linux administration, networking, web server management, and system security.

## Technologies Used

- Ubuntu Server
- SSH / OpenSSH
- UFW Firewall
- Nginx
- systemd / systemctl
- journalctl
- Linux command-line utilities

## Infrastructure

I deployed an Ubuntu Server virtual machine on my Mac and configured remote access using SSH.

The server hosts an Nginx web service accessible over HTTP within my lab network.

## Implementation

### Remote Administration
- Configured SSH access to the Ubuntu server.
- Verified remote access from macOS Terminal.

### Network Security
- Enabled UFW with a default-deny incoming policy.
- Configured rules permitting SSH (TCP 22) and HTTP (TCP 80).
- Tested web connectivity with different firewall rules.

### Web Server Administration
- Installed and configured Nginx.
- Hosted a local HTTP webpage.

- Managed Nginx using systemctl.
- Verified connectivity using curl and ss.

### Troubleshooting
- Inspected service logs using journalctl.
- Investigated Nginx configuration errors.
- Identified file-permission errors during configuration testing.
- Validated configurations using nginx -t.

## Verification

- Confirmed Nginx was running.
- Verified HTTP/1.1 200 OK using curl.
- Validated the production Nginx configuration successfully.

## Next Steps

- Add an infrastructure architecture diagram.
- Document configuration and troubleshooting exercises.
- Implement monitoring and automation.
