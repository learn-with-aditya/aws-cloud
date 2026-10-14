# Linux Group Management — RHEL 9

A beginner-friendly, practical guide to Linux groups, shared access, group ownership, and collaborative file permissions.

## Learning path

1. Understand GIDs, primary groups, and supplementary groups.
2. Inspect `/etc/group` and `/etc/gshadow` safely.
3. Create, rename, modify, and remove groups.
4. Add and remove users from groups.
5. Build a shared directory for a team.
6. Understand setgid and the difference between ownership and permissions.
7. Complete the lab and independent exercises.

## Lab environment

- RHEL 9 VM or RHEL 9 EC2 instance.
- A user with `sudo` privileges.
- Use a disposable lab VM; do not experiment on production groups or directories.

> **Safety:** Do not add students to privileged groups such as `wheel` unless the lab explicitly requires it and an administrator approves. Never publish `/etc/gshadow` contents or real user/group inventories.

## Contents

- [`docs/01-group-foundations.md`](docs/01-group-foundations.md) — concepts and account files
- [`docs/02-command-reference.md`](docs/02-command-reference.md) — options and expected output
- [`labs/01-team-shared-directory.md`](labs/01-team-shared-directory.md) — guided shared-folder lab
- [`labs/02-membership-and-permissions.md`](labs/02-membership-and-permissions.md) — membership and permissions lab
- [`exercises/README.md`](exercises/README.md) — practice tasks and answer key
- [`TROUBLESHOOTING.md`](TROUBLESHOOTING.md) — common errors

## Quick start

```bash
# Inspect your current group memberships
id
groups

# Check whether a practice group already exists
getent group projectteam

# Create a group
sudo groupadd projectteam

# Add an existing user to the supplementary group
sudo usermod -aG projectteam labuser

# Verify membership
id labuser
getent group projectteam
```

Expected patterns:
- `groupadd` is usually silent on success.
- `getent group projectteam` prints a record similar to `projectteam:x:1005:labuser`.
- The GID and group member list vary by system.
- A user may need to log out and back in before the new membership is reflected in an existing session.

## Cleanup

Only after confirming these are lab-only objects and no longer needed:

```bash
sudo userdel -r labuser
sudo groupdel projectteam
```

Delete the practice user only if you created it for this lab and have no need for its data. A group cannot normally be deleted while it is the primary group of an existing user.

## Scope note

This repository covers local Linux groups and discretionary access control. Central directory groups, ACLs, SELinux policy, and enterprise identity management are related but separate topics.
