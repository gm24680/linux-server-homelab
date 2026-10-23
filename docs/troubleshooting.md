
# Nginx Troubleshooting Lab

## Objective

Practice identifying, diagnosing, and resolving Nginx configuration and Linux permissions errors without modifying the working web server.

## Environment

- Ubuntu Server virtual machine
- Nginx web server
- SSH remote administration
- systemd service manager

## Scenario 1: Invalid Nginx Directive

I created a separate Nginx configuration file containing an intentionally invalid directive.

Error:

```text
unknown directive "invalid_directive"
```

The configuration test identified the invalid directive and its line number.

**Resolution:** Removed the unsupported directive and tested the configuration again.

## Scenario 2: File Permission Error

After correcting the syntax, the configuration test reported:

```text
open() "/run/nginx.pid" failed
(13: Permission denied)
```

The regular Linux user did not have permission to access the required system file.

**Resolution:** Configured a PID file path inside my home directory for the isolated test environment.

## Scenario 3: Duplicate Directives

While editing the test configuration, I encountered duplicate `events` and `pid` directives.

**Resolution:** Inspected the configuration using:

```bash
cat -n ~/nginx-lab/broken.conf
```

This helped verify the file contents and line numbers.

## Scenario 4: Access Log Permissions

The configuration test also encountered an access log permissions error:

```text
open() "/var/log/nginx/access.log" failed
(13: Permission denied)
```

I verified that running the configuration test with appropriate elevated permissions succeeded.

## Final Verification

I confirmed the working Nginx service was healthy using:

```bash
sudo nginx -t
systemctl is-active nginx
curl -I http://localhost
```

Results:

- Configuration test successful
- Nginx service active
- HTTP/1.1 200 OK

## Lessons Learned

1. Configuration syntax errors are different from operating system permission errors.
2. Nginx diagnostic messages help identify the cause and location of errors.
3. Testing configurations before applying them reduces the risk of service disruption.
4. Linux services, configuration files, logs, and permissions are interconnected.
5. A structured troubleshooting process is more effective than repeatedly restarting services.
