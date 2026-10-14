# 02 — Group Management Command Reference

## 1. `groupadd` — create a group

**Syntax**

```bash
sudo groupadd [options] GROUP
```

| Option | Meaning | Example |
|---|---|---|
| `-g GID` | Request a specific GID | `sudo groupadd -g 1605 projectteam` |
| `-r` | Create a system group | `sudo groupadd -r appservice` |
| `-f` | Exit successfully if group already exists; behavior also interacts with `-g` | `sudo groupadd -f projectteam` |

Expected output: usually none on success.

Verify:

```bash
getent group projectteam
```

Example pattern:

```text
projectteam:x:1005:
```

GIDs vary. Avoid choosing a fixed GID unless your lab requires it and you have checked that it is unused.

## 2. `groupmod` — modify a group

| Option | Meaning | Example |
|---|---|---|
| `-n NEWNAME` | Rename a group | `sudo groupmod -n engineering projectteam` |
| `-g GID` | Change the GID | `sudo groupmod -g 1606 projectteam` |

Verify:

```bash
getent group engineering
```

Changing a GID can leave existing files with the old numeric group ownership. Plan and audit such a change; do not use it casually on production systems.

## 3. `groupdel` — delete a group

```bash
sudo groupdel projectteam
```

Expected output: normally none on success.

Before deletion:

```bash
getent group projectteam
getent passwd
```

A group generally cannot be deleted while it is the primary group of an existing user. Check dependencies and files that use the group's numeric GID first.

## 4. `groups` — display group memberships

```bash
groups
groups labuser
```

- No username: show groups for the current process/user context.
- With username: display groups associated with that account.

Expected pattern:

```text
labuser : labuser projectteam
```

The precise output format may vary.

## 5. `id` — display numeric and named IDs

```bash
id labuser
id -g labuser
id -G labuser
id -Gn labuser
```

| Option | Meaning |
|---|---|
| `-g` | Primary GID |
| `-G` | All group IDs |
| `-n` | Display names rather than numeric IDs when combined with an ID option |

Use `id` to verify whether a membership change has taken effect in the account database.

## 6. `usermod -aG` — add a user to a supplementary group

```bash
sudo usermod -aG projectteam labuser
```

- `-G projectteam`: specify supplementary groups.
- `-a`: append instead of replacing the current supplementary group list.
- Without `-a`, `-G` can remove existing supplementary memberships.

Verify:

```bash
id labuser
getent group projectteam
```

A user may need to start a new login session to receive updated group credentials.

To remove a user from a supplementary group, a common method is to provide the full intended list with `usermod -G`, taking care not to remove other needed groups. On systems with `gpasswd`, you can also use:

```bash
sudo gpasswd -d labuser projectteam
```

Expected output commonly says the user was removed from the group.

## 7. `gpasswd` — administer group membership

```bash
sudo gpasswd -a labuser projectteam
sudo gpasswd -d labuser projectteam
```

- `-a USER GROUP`: add a user as a member.
- `-d USER GROUP`: remove a user from a group.
- `-M USERLIST GROUP`: replace the supplementary member list for the group; use carefully because it overwrites the list.

Verify all changes with `getent group projectteam` and `id labuser`.

## 8. `chgrp`, `chown`, and `chmod` — file access

### `chgrp`

```bash
sudo chgrp projectteam report.txt
```

Changes the group owner of `report.txt`.

Useful options:
- `-R`: recurse into a directory tree; use carefully.
- `-v`: report each processed file.

### `chown`

```bash
sudo chown root:projectteam report.txt
```

Changes owner to `root` and group to `projectteam`.

Useful options:
- `user:group`: set both owner and group.
- `:group`: set only group on many GNU/Linux systems.
- `-R`: recursive; high impact if the path is wrong.

### `chmod`

```bash
sudo chmod 2770 /srv/projectteam
```

- `2`: setgid special bit for a directory.
- `7`: owner `rwx`.
- `7`: group `rwx`.
- `0`: others no access.

Verify:

```bash
ls -ld /srv/projectteam
stat -c '%A %a %U %G %n' /srv/projectteam
```

Example output:

```text
drwxrws---. 2770 root projectteam /srv/projectteam
```

The exact `stat` format depends on the command and file state; this example uses GNU `stat`.

## 9. `umask` and shared-file behavior

`umask` removes permissions from the mode requested by an application when creating a file or directory.

```bash
umask
umask -S
```

For collaboration, group ownership alone is not enough. Check:
- the directory's owner/group and mode
- setgid on the shared directory
- the creator's umask and application behavior
- any ACLs or SELinux policy affecting access

Do not assume every file created in a shared directory automatically becomes group-writable.

## 10. Manual pages

```bash
man groupadd
man groupmod
man groupdel
man gpasswd
man chmod
man chgrp
```

Use `q` to quit a manual page. Confirm option availability on your installed RHEL release.
