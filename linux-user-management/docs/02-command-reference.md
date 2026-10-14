# 02 — User Management Command Reference

Examples use a disposable account named `riya`. Check whether it already exists before creating it.

## 1. `useradd` — create a user

**Syntax**

```bash
sudo useradd [options] USERNAME
```

| Option | Meaning | Example |
|---|---|---|
| `-m` | Create the home directory if needed | `sudo useradd -m riya` |
| `-M` | Do not create a home directory | `sudo useradd -M service-demo` |
| `-d PATH` | Set the home directory path | `sudo useradd -m -d /home/riya riya` |
| `-s SHELL` | Set the login shell | `sudo useradd -m -s /bin/bash riya` |
| `-c COMMENT` | Set the comment/GECOS field | `sudo useradd -m -c "Riya Sharma" riya` |
| `-u UID` | Request a specific UID | `sudo useradd -m -u 1505 riya` |
| `-g GROUP` | Set an existing primary group | `sudo useradd -m -g developers riya` |
| `-G GROUPS` | Set supplementary groups at creation | `sudo useradd -m -G wheel riya` |
| `-r` | Create a system account | `sudo useradd -r service-demo` |
| `-e YYYY-MM-DD` | Set account expiration date | `sudo useradd -m -e 2026-12-31 tempuser` |
| `-N` | Do not create a same-name group | `sudo useradd -N -m riya` |

Important:
- `-G` can grant powerful access. Do not use `wheel` in a student lab unless sudo access is specifically required and approved.
- `-r` is for service/system-account scenarios, not the normal way to create a human user.
- Some options interact with local defaults. Check `man useradd` on your system.
- On many RHEL systems, `useradd riya` creates a home directory only if defaults say to; use `-m` when you explicitly want one.

**Expected output:** `useradd` is usually silent on success.

Verify:

```bash
id riya
getent passwd riya
ls -ld /home/riya
```

Example output patterns:

```text
uid=1002(riya) gid=1002(riya) groups=1002(riya)
riya:x:1002:1002:Riya Sharma:/home/riya:/bin/bash
drwx------. 2 riya riya 62 Oct 14 10:30 /home/riya
```

UIDs, timestamps, permissions, and SELinux markers may differ.

## 2. `passwd` — set or change a password

```bash
sudo passwd riya
```

- Prompts interactively for a new password and confirmation.
- Input is not displayed while typing.
- A successful change commonly prints `all authentication tokens updated successfully`.
- Never write a real password directly into a shell command or source-control file.

Useful options:

| Option | Meaning | Example |
|---|---|---|
| `-S` | Show password/account status | `sudo passwd -S riya` |
| `-l` | Lock password authentication | `sudo passwd -l riya` |
| `-u` | Unlock password authentication | `sudo passwd -u riya` |
| `-d` | Delete password (potentially unsafe) | Avoid in routine labs |

A password lock is not the same as fully disabling every possible access method. SSH keys or other authentication mechanisms may still matter. For account lifecycle exercises, combine checks with `usermod -L/-U` or an explicit account-expiration policy as appropriate.

## 3. `id` — inspect identity and groups

```bash
id riya
id -u riya
id -g riya
id -Gn riya
```

- No option: show UID, primary GID, and group memberships.
- `-u`: print UID.
- `-g`: print primary GID.
- `-G`: print all numeric group IDs.
- `-n`: with an ID option, print names instead of numbers.

Expected output pattern:

```text
uid=1002(riya) gid=1002(riya) groups=1002(riya)
```

If the user is not found, `id` reports an error such as `no such user`.

## 4. `getent` — query account databases

```bash
getent passwd riya
getent passwd
getent group
```

- `getent passwd riya`: look up one account.
- `getent passwd`: list account records available through the configured Name Service Switch.
- `getent group`: list groups.
- Prefer `getent` for lookups because systems may use local files or network identity sources.

Large listing commands can produce lots of output. Filter carefully:

```bash
getent passwd | grep '^riya:'
```

## 5. `usermod` — modify an account

**Syntax**

```bash
sudo usermod [options] USERNAME
```

| Option | Meaning | Example |
|---|---|---|
| `-c COMMENT` | Change comment field | `sudo usermod -c "Riya S" riya` |
| `-d PATH` | Change home path field | `sudo usermod -d /home/riya2 riya` |
| `-m` | Move home contents when used with `-d` | `sudo usermod -d /home/riya2 -m riya` |
| `-s SHELL` | Change login shell | `sudo usermod -s /bin/bash riya` |
| `-l NEWNAME` | Change login name | `sudo usermod -l riya2 riya` |
| `-aG GROUPS` | Append supplementary groups | `sudo usermod -aG developers riya` |
| `-G GROUPS` | Replace supplementary group list | `sudo usermod -G developers riya` |
| `-L` | Lock password authentication | `sudo usermod -L riya` |
| `-U` | Unlock password authentication | `sudo usermod -U riya` |
| `-e DATE` | Set account expiration date | `sudo usermod -e 2026-12-31 riya` |
| `-e ""` | Clear account expiration date | `sudo usermod -e "" riya` |

**Critical distinction: `-aG` vs `-G`**
- `-aG developers` appends `developers` to supplementary memberships.
- `-G developers` replaces the existing supplementary group list with the listed groups. This can remove access unexpectedly.
- Always verify with `id riya` after a membership change.
- Existing login sessions may not immediately reflect changed groups; log out and back in for a fresh session.

## 6. `chage` — password aging and account aging

```bash
sudo chage -l riya
```

Lists password-aging information, including last password change and configured expiration settings.

| Option | Meaning | Example |
|---|---|---|
| `-l` | List aging information | `sudo chage -l riya` |
| `-m DAYS` | Minimum days between password changes | `sudo chage -m 1 riya` |
| `-M DAYS` | Maximum password age | `sudo chage -M 90 riya` |
| `-W DAYS` | Warning days before password expiration | `sudo chage -W 7 riya` |
| `-I DAYS` | Inactivity period after password expiration | `sudo chage -I 14 riya` |
| `-E DATE` | Account expiration date | `sudo chage -E 2026-12-31 riya` |
| `-E -1` | Remove account expiration date | `sudo chage -E -1 riya` |
| `-d 0` | Require password change at next password-based login | `sudo chage -d 0 riya` |

Use an organization's current password policy rather than blindly applying sample values.

## 7. `userdel` — delete a user

```bash
sudo userdel riya
```

- Removes the account record.
- Does not normally remove the home directory by default.
- `-r` requests removal of the home directory and mail spool: `sudo userdel -r riya`.
- Check for running processes, scheduled jobs, owned files, and dependencies before deletion.
- UID-owned files outside the home directory may remain. Do not use broad deletion commands to clean them up without a reviewed plan.

Verify after deletion:

```bash
getent passwd riya
id riya
```

If the account is gone, these commands normally report that it cannot be found.

## 8. `su` and `sudo` — identity and privilege

```bash
su - riya
sudo id
sudo -l
```

- `su - riya`: start a login shell as `riya`; authentication policy applies.
- `sudo id`: run `id` with elevated privileges if authorized.
- `sudo -l`: list commands the current user is allowed to run through sudo.
- Do not give a user administrator access merely to make a practice command work.

## 9. Help and manual pages

```bash
man useradd
useradd --help
man usermod
man chage
```

- `man COMMAND`: full manual; navigate with arrow keys/Page Up/Page Down, search with `/word`, quit with `q`.
- `COMMAND --help`: concise option summary.
- Options and defaults may vary by distribution/version; the installed manual is authoritative for your machine.
