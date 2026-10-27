
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


## Follow-Up Investigation: Recurring Clock Drift

### Problem

After initially correcting the system clock, I discovered that my Ubuntu VM continued falling several hours behind actual time.

This caused newly created Git commits to appear significantly older on GitHub.

### Investigation

I inspected Chrony's synchronization information:

```bash
chronyc tracking
chronyc sources -v
sudo journalctl -u chrony -n 30 --no-pager
```

Chrony reported that the system clock was approximately 52,766 seconds (14.7 hours) behind NTP time.

The logs also showed intermittent NTP connectivity problems, excessive jitter, and disagreement between time sources.

I identified the virtualization environment using:

```bash
systemd-detect-virt
```

Result:

```text
qemu
```

I examined the configured kernel clock source:

```bash
cat /sys/devices/system/clocksource/clocksource0/current_clocksource
```

Result:

```text
arch_sys_counter
```

### Configuration Investigation

I inspected Chrony's configuration:

```bash
grep -nE 'makestep|rtcsync|maxslewrate' /etc/chrony/chrony.conf
```

The configuration contained:

```text
rtcsync
makestep 1 3
```

The `makestep 1 3` directive permits immediate correction of offsets greater than one second during the first three clock updates.

After those updates, Chrony ordinarily adjusts the clock gradually.

### Corrective Action

For this experimental Ubuntu VM, I updated Chrony's configuration to permit large clock corrections after startup.

I backed up the original configuration:

```bash
sudo cp /etc/chrony/chrony.conf /etc/chrony/chrony.conf.bak
```

I changed:

```text
makestep 1 3
```

To:

```text
makestep 1 -1
```

I then restarted Chrony and requested an immediate correction:

```bash
sudo systemctl restart chrony
sudo chronyc makestep
```

### Verification and Observations

After the correction, the Ubuntu clock displayed approximately 18:21 UTC while local Houston time was approximately 13:21 CDT.

This five-hour difference was expected because the server uses UTC.

The displayed time was consistent with the correct local time.

Long-term synchronization stability still needs to be observed, particularly after the Mac sleeps or the VM resumes.

### Lessons Learned

- A running NTP service does not necessarily mean the system clock is synchronized.
- Virtual machine clocks can experience large offsets, especially around suspension and resume.
- Chrony can either gradually adjust time or make an immediate correction.
- UTC and local time zones represent the same moment differently.
- Accurate clocks are important for logs, scheduled tasks, authentication, and Git commit timestamps.
- Sudden time adjustments should be evaluated carefully in production environments.
