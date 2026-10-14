# Linux User Management — RHEL 9

A beginner-friendly, hands-on guide to Linux user accounts. Designed for students learning Linux administration, RHEL 9, AWS EC2, and DevOps.

## Learning path

1. Understand users, UIDs, root, and ordinary accounts.
2. Read the account database files safely.
3. Create users with `useradd`.
4. Set and change passwords with `passwd`.
5. Inspect accounts with `id`, `whoami`, `getent`, and `chage`.
6. Modify, lock, unlock, and remove accounts safely.
7. Complete the labs and self-check questions.

## Lab environment

- RHEL 9 VM or RHEL 9 EC2 instance.
- A terminal and an account with `sudo` privileges.
- Use a disposable lab VM. Do not practise destructive commands on a production server.
- Examples use lowercase usernames such as `riya`, `arjun`, and `labuser`.

> **Safety:** Commands that change system accounts normally require `sudo`. Never share real passwords in screenshots, Git commits, chat, or terminal recordings. Do not copy password hashes from `/etc/shadow`.

## How to use this repository

For each topic, follow **Concept → Example → Command → Expected output → Practice**. Outputs can differ slightly between Linux versions and configurations; use them to understand the pattern, not as byte-for-byte guarantees.

## Contents

- [`docs/01-foundations.md`](docs/01-foundations.md) — users, UIDs, system files
- [`docs/02-command-reference.md`](docs/02-command-reference.md) — commands, options, and expected output
- [`labs/01-create-and-inspect-users.md`](labs/01-create-and-inspect-users.md) — guided lab
- [`labs/02-modify-lock-and-delete.md`](labs/02-modify-lock-and-delete.md) — account lifecycle lab
- [`exercises/README.md`](exercises/README.md) — independent exercises and answer key
- [`TROUBLESHOOTING.md`](TROUBLESHOOTING.md) — common errors and resolutions

## Quick start

```bash
# Confirm your current identity
whoami

# Show your UID, primary GID, and supplementary groups
id

# Look up an account without reading raw account files
getent passwd "$USER"

# Create a practice account (requires sudo)
sudo useradd -m labuser

# Set a password interactively; do not put a password in the command
sudo passwd labuser

# Inspect the new account
id labuser
getent passwd labuser
```

Expected patterns:
- `whoami` prints your login name.
- `id` prints `uid=...`, `gid=...`, and `groups=...`.
- `useradd` is usually silent on success.
- `passwd` prompts for a password and confirmation.
- `getent passwd labuser` prints a colon-separated account record.

## Cleanup

Only if `labuser` was created for this exercise and you no longer need it:

```bash
sudo userdel -r labuser
```

`-r` requests removal of the user's home directory and mail spool. Check the username carefully before running it.

## Scope note

This repository teaches local Linux accounts. Central identity systems such as LDAP, Active Directory, and IAM Identity Center are separate topics.
