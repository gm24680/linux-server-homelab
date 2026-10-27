
# Automated Website Backup and Recovery

## Objective

Create, automate, and verify backups of an Nginx website hosted on Ubuntu Server.

## Technologies

- Bash
- tar and gzip
- systemd services and timers
- Linux filesystem utilities
- diff

## Implementation

Created `scripts/backup-website.sh` to:

- Archive `/var/www/html`
- Generate timestamped `.tar.gz` backups
- Verify archive readability
- Retain the seven most recent timestamped backups

Backups are stored in `/home/gabe/backups`.

## Automation

Configured `homelab-backup.service` to execute the script as a oneshot service.

Configured `homelab-backup.timer` to schedule daily execution at 03:00 UTC, with `Persistent=true` to support catching up on missed scheduled runs.

## Recovery Test

Created an isolated restoration directory:

```bash
mkdir -p ~/restore-test
```

Extracted a backup:

```bash
tar -xzf ~/backups/nginx-website.tar.gz -C ~/restore-test
```

Compared the restored website against the original:

```bash
diff -r /var/www/html ~/restore-test/html
```

The comparison showed no differences.

## Verification

The backup service successfully created and verified a timestamped archive.

The daily systemd timer was enabled and confirmed active.

The retention code executed successfully; deletion of backups beyond the seven-file limit has not yet been tested.

## Limitations

- Backups are stored on the same virtual disk as the source website.
- The backup covers website files, not the full operating system or Nginx configuration.
- Automated failure notifications have not been implemented.
- Off-machine backups are a future improvement.

## Lessons Learned

Backup creation and recovery verification are separate processes. Scheduled backups reduce manual administration, while retention policies help control storage consumption.
