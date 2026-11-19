
# Automated Server Health Monitoring

## Overview

This homelab uses a Bash script and a systemd timer to perform automated health checks on an Ubuntu Server.

The monitoring system is designed to provide visibility into server resource usage and verify that the Nginx web service is functioning.

## Metrics Monitored

The monitoring script checks:

- **CPU:** System processor utilization
- **Memory:** Available and used system memory
- **Disk:** Storage utilization
- **Nginx:** Whether the web server service is running
- **HTTP:** Whether the local web server responds to HTTP requests

## How the Automation Works

1. A systemd timer runs at five-minute intervals.
2. The timer activates a systemd service.
3. The service executes the Bash monitoring script.
4. The script collects system information and checks web service availability.
5. The monitoring cycle repeats automatically.

## Architecture

```text
systemd timer
     |
     v
systemd service
     |
     v
Bash monitoring script
     |
     +--- CPU check
     +--- Memory check
     +--- Disk check
     +--- Nginx service check
     +--- HTTP response check
```

## Verification

The system can be inspected using standard Linux commands.

Check the timer:

```bash
systemctl list-timers --all
```

Check the Nginx service:

```bash
systemctl status nginx
```

Test HTTP availability:

```bash
curl -I http://localhost
```

View service logs:

```bash
journalctl -u SERVICE_NAME
```

Replace `SERVICE_NAME` with the actual monitoring service name.

## Technologies

- Ubuntu Server
- Bash
- systemd services and timers
- Nginx
- Linux command-line utilities

## Skills Demonstrated

- Linux system administration
- Automated infrastructure monitoring
- Bash scripting
- Service management with systemd
- HTTP service verification

