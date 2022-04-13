# Backup
The infrastructure we use contain a lot of different services:
* Web Servers
* App Servers
* Database Servers
* DNS Servers
* Monitoring Servers
* Ansible repository
And more.

## Purpose of backup
In order to backup our infrastucture and restore the operation of our services we us backups.

## Versioning and retention

### Customer data
Will see a full backup once a week - every Sunday, 00:01 UTC, while incremental backups will happen every day at 00:02 UTC

Full backups will be stored for three (3) weeks, while only last seven (7) incremental backups will be retained.

In conclusion - Ten versions of data will be available, with better tuning available for the more recent data.

### Ansible repository
As the repository is powered by git, every version of the repository is going to be available with no (For the lifetime of the infrastructure) time constraint for storage.

## Usability

To ensure the validity of data, on a machine separate from production, MySQL and Grafana will be randomly deployed and their functionality verified once a week.

## Restoration criteria

Upon infrastructure operation error, first the correctness of configuration and operability of services should be insured, after which all the possible errors should go through troubleshooting.

If and only if the abovementioned procedure won't yield a working infrastructure, restoration from backups can take place.

## Backup Recovery Time Objective

During the restoration, the whole infrastructure can be expected to be redeployed in one and a half hours, while data backup restoration can be expected to take up to one additional hour.
