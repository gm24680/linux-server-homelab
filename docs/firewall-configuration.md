
# UFW Firewall Configuration

## Objective

Configure a Linux firewall to control incoming network traffic and verify how firewall rules affect access to server services.

## Firewall Setup

I used UFW (Uncomplicated Firewall) to manage network access on Ubuntu Server.

The firewall was configured with these default policies:

- Deny incoming connections
- Allow outgoing connections

## Allowed Ports

| Port | Protocol | Purpose |
|------|----------|---------|
| 22 | TCP | SSH remote administration |
| 80 | TCP | HTTP web server access |

## Commands Used

Check firewall status:

```bash
sudo ufw status verbose
```

Allow SSH:

```bash
sudo ufw allow 22/tcp
```

Allow HTTP:

```bash
sudo ufw allow 80/tcp
```

## Firewall Experiment

I tested how blocking TCP port 80 affected my ability to access the Nginx web server.

### Test 1: Port 80 Allowed

- Nginx was running.
- UFW allowed TCP port 80.
- My browser could access the webpage.

### Test 2: Port 80 Blocked

- Nginx continued running.
- Incoming HTTP traffic was blocked by UFW.
- The browser could no longer load the webpage.

## What I Learned

A running service is not necessarily reachable over the network.

Both the application and the network security rules must allow communication.

I also learned that firewall rules and application processes are separate parts of server infrastructure.
