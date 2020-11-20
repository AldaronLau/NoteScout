# NoteScout Backend
The backend code for NoteScout.

## Getting Started
The server runs on a machine with Fedora Server Edition installed (IP:
73.94.232.74).

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
# Follow onscreen instructions to install Rust

sudo dnf install postgresql
# Press 'y' than enter to install postgresql postgresql-server

sudo systemctl start postgresql.service
# Starts the service

sudo systemctl enable postgresql.service
# Configures the service to start on reboot

sudo su postgres
# Logs you in as postgres user
```

Now that you're logged in as postgres user:

```bash
postgresql-setup --initdb
createuser --interactive
# make the name of the role your username
# make yourself superuser

```

As your own user

```bash
# createdb your_username
psql
```

Now you'll be in a SQL prompt where you can set up the database.

### Set Up The NoteScout Database
The NoteScout server will be running under the `notescout` user.

```
sudo su postgres
createuser --interactive
notescout # Name of role to add
n # superuser
n # allowed to create databases
n # allowed to create more roles
createdb notescout
```

Login as NoteScout.

```
ssh notescout@73.94.232.74
psql
```

Now you'll be in a SQL prompt where you can set up the database.

### Building An Empty Database
```sql
create table users (username text primary key);
alter table users add column password text;
insert into users (username, password) values (USER, PSWD),(USER, PSWD);
```

# Backing Up Database
You can back up a database to a file with:
```bash
pg_dump > BACKUP.sql
```

You can run this script to re-create the database if it gets deleted:

```bash
psql notescout -f BACKUP.sql
```
