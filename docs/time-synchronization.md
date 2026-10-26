
# Linux Time Synchronization Troubleshooting

## Problem

While working on my Linux homelab, I noticed that GitHub displayed my newest commits as several days old.

I investigated the Ubuntu Server clock and found that its system time was approximately three days behind the correct date.

## Investigation

I checked the system clock using:

```bash
date -u
timedatectl
```

The output showed:
- System clock: October 23, 2026
- RTC clock: October 26, 2026
- System clock synchronized: no
- NTP service: active

I initially attempted to restart `systemd-timesyncd`, but the service was not installed.

I identified the active time synchronization service using:

```bash
systemctl list-unit-files --type=service | grep -Ei 'chrony|timesync|ntp'
systemctl status chrony --no-pager
```

Ubuntu was using Chrony.

## Diagnosis

I investigated Chrony's synchronization status using:

```bash
chronyc tracking
chronyc sources -v
```

Chrony reported that the system clock was approximately 268,359 seconds slow compared with NTP time.

Chrony had a selected time source, but the operating system clock was still incorrect.

## Corrective Action

I requested an immediate clock correction:

```bash
sudo chronyc makestep
```

Chrony responded:

```text
200 OK
```

This confirmed that Chrony accepted the correction request.

## Verification

The following commands can be used to verify synchronization:

```bash
date -u
timedatectl
chronyc tracking
```

The systemd timer schedule can be checked using:

```bash
systemctl list-timers --all
```

## Lessons Learned

- A running time synchronization service does not guarantee that the system clock is synchronized.
- Linux can use different NTP implementations, including Chrony.
- Accurate system time is important for Git timestamps, logs, authentication, and scheduled tasks.
- Diagnostic commands should be used to identify the actual service before changing its configuration.
- Git commits retain the timestamps recorded when they were created.
