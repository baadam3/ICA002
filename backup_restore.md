# Installing the infrastructure:

The whole infrastructure should be installed by running $ ansible-playbook infra.yaml .
This will aslo restore a service if it stopped and uploads necesarry configurations, files etc.
If we know what the problem is we can run specific ansible plays by adding the -t<tag> parameter after ansible-playbook infra.yaml.
The order does matter so my suggestion is to run the whole playbook excapt if all the needed modules are known which are needed to restore trhe service.
More tags can be added by comma separators: -t<tag1,tag2,tag3>.

## Restoring the database:

### Mysql:
The first step is to log in as the backup user and use the duplicity tool to download the backed up data then push it to our database.
#### Here are the commands to do that:
1. sudo su - backup
2. duplicity --no-encryption restore rsync://ToxicalBullet@backup//home/ToxicalBullet/mysql /home/backup/restore/
3. exit
4. sudo su -
5. mysql agama < /home/backup/restore/agama.sql
If the 2nd command gives the error "Error '[Errno 1] Operation not permitted: b'/home/backup/restore'' processing" then just wait a few seconds and re-enter the command.

### InfluxDB:
This is very similar to the mysql restore proccess but we need to drop our table and stop the telegraf servoice before restoreing.
#### Commands to do it:
1. sudo su - backup
2. duplicity --no-encryption restore rsync://ToxicalBullet@backup//home/ToxicalBullet/influxdb /home/backup/influxdb/
3. exit
4. sudo su -
5. service telegraf stop
6. influx -execute 'DROP DATABASE telegraf'
7. influxd restore -portable -database telegraf /home/backup/influxdb
8. service telegraf start
If we get the same error in the 2nd step as described in the Mysql part then the process to resolve the issue is the same.
After these stepps our databases should be back to normal. If fore some reason any of the services are not working just run the ansible-playbook infra.yaml command!
