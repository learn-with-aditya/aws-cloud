# Lab 01 — Build a Team Shared Directory

## Goal

Create a group called `projectteam`, add two lab users, and create a shared directory with group inheritance.

> Use a disposable VM. The commands create accounts and modify permissions.

## Step 0 — Check for name conflicts

```bash
getent group projectteam
getent passwd labuser
getent passwd anita
```

If any name already exists, inspect it and use alternative lab names rather than changing an existing account.

## Step 1 — Create the group

```bash
sudo groupadd projectteam
getent group projectteam
```

Expected output pattern:

```text
projectteam:x:1005:
```

The GID varies.

## Step 2 — Create two practice users

```bash
sudo useradd -m -s /bin/bash labuser
sudo useradd -m -s /bin/bash anita
sudo passwd labuser
sudo passwd anita
```

Set lab-only passwords interactively.

## Step 3 — Add both users to the group

```bash
sudo usermod -aG projectteam labuser
sudo usermod -aG projectteam anita
```

Verify:

```bash
id labuser
id anita
getent group projectteam
```

Expected: `projectteam` appears as a supplementary group for both users. The GID and output ordering can differ.

## Step 4 — Create a shared directory

```bash
sudo mkdir -p /srv/projectteam
sudo chown root:projectteam /srv/projectteam
sudo chmod 2770 /srv/projectteam
ls -ld /srv/projectteam
```

Expected permission pattern:

```text
drwxrws---. 2 root projectteam ... /srv/projectteam
```

Meaning:
- `root` owns the directory.
- `projectteam` is the owning group.
- owner and group have read/write/traverse access.
- others have no access.
- `s` in the group execute position indicates setgid.

## Step 5 — Test access as a team member

```bash
sudo -u labuser touch /srv/projectteam/labuser-file.txt
ls -l /srv/projectteam
```

Expected: the file should be owned by `labuser` and normally have group `projectteam`, because the directory has setgid. Its permissions depend on the user's umask and file-creation behavior.

Repeat as `anita`:

```bash
sudo -u anita touch /srv/projectteam/anita-file.txt
ls -l /srv/projectteam
```

## Step 6 — Understand group write access

The setgid bit helps group inheritance, but does not guarantee group write permission on every file. Inspect:

```bash
umask
ls -l /srv/projectteam
```

For a real shared-workflow design, decide whether group members need to edit one another's files, and test with the actual intended permissions. Avoid setting broad permissions without a requirement.

## Questions

1. Why is the directory owned by `root` rather than `labuser`?
2. What does `2770` mean?
3. What is the purpose of setgid on a directory?
4. Why might a new file not be group-writable even if its group is `projectteam`?
5. Why should we verify `id anita` after changing membership?
