# Lab 01 — Create and Inspect Users

## Goal

Create a normal user, understand its account record, set a password, and verify the result.

## Step 0 — Pre-flight checks

```bash
whoami
cat /etc/redhat-release
getent passwd labuser
```

Expected:
- `whoami` prints your current login name.
- `/etc/redhat-release` identifies the installed RHEL release.
- If `getent` prints nothing, `labuser` is probably not present in the configured account database. If it prints a record, choose another lab username.

## Step 1 — Create the user and home directory

```bash
sudo useradd -m -s /bin/bash -c "Practice User" labuser
```

Explanation:
- `sudo`: request administrative privileges.
- `useradd`: create a local user according to system policy.
- `-m`: create the home directory.
- `-s /bin/bash`: choose Bash as login shell.
- `-c "Practice User"`: add a descriptive comment.
- `labuser`: account name.

Expected output: normally no output if successful.

## Step 2 — Set the password

```bash
sudo passwd labuser
```

Type a lab-only password twice when prompted. Characters will not appear on screen.

Expected success message commonly resembles:

```text
passwd: all authentication tokens updated successfully.
```

The exact wording may vary.

## Step 3 — Verify identity

```bash
id labuser
getent passwd labuser
ls -ld /home/labuser
```

Look for:
- A numeric UID and primary GID in `id`.
- `/home/labuser` and `/bin/bash` in the account record.
- A directory owned by `labuser` in the `ls -ld` output.

## Step 4 — Inspect starter files

```bash
ls -la /home/labuser
ls -la /etc/skel
```

`/etc/skel` contains template files that may be copied to a newly created home directory. The exact files vary.

## Step 5 — Switch identity for a test

```bash
su - labuser
whoami
pwd
id
exit
```

Expected:
- `whoami` prints `labuser`.
- `pwd` normally prints `/home/labuser`.
- `exit` returns you to the previous shell.

Depending on system policy, `su` may ask for the target user's password. Use only your lab password.

## Step 6 — Check password aging

```bash
sudo chage -l labuser
```

Read the fields. Defaults vary, so do not assume a fixed expiration date.

## Student reflection

1. Why is a UID needed if the system already has a username?
2. What does `-m` change?
3. Why did `useradd` not ask you for a password?
4. What is the difference between `id labuser` and `whoami`?
5. Which file provides the user's home directory and shell fields?
