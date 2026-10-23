
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

## Automated Server Health Monitoring

Developed a Bash script to collect server health information, including:

- System uptime and load averages
- Memory and disk utilization
- Nginx service availability
- HTTP response status

Configured a systemd oneshot service and timer to automatically run the health check every five minutes.

The script uses conditional logic and exit codes to report successful and failed HTTP checks.

### Running the Script

```bash
./scripts/health-check.sh
```

### Monitoring the Scheduled Service

```bash
systemctl status homelab-health.timer
journalctl -u homelab-health.service --no-pager
```

The systemd configuration files are available in the `systemd/` directory.

The service currently runs on the Ubuntu homelab and writes its output to the systemd journal.

## Next Steps

- Add an infrastructure architecture diagram.
- Document configuration and troubleshooting exercises.
- Implement monitoring and automation.

## Future Improvements

- Add automated failure notifications.
- Implement CPU, memory, and disk usage thresholds.
- Expand monitoring to multiple servers.
- Explore Docker and cloud infrastructure.
