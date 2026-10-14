# 01 — User Management Foundations

## 1. What is a Linux user?

A Linux user is an identity the operating system uses to associate processes and files with an account. Linux permissions use numeric IDs, not just the visible username.

- **Username:** Human-readable label, e.g. `riya`.
- **UID (User ID):** Numeric user identity.
- **Primary group:** The account's default group identity (GID).
- **Supplementary groups:** Additional groups that can grant access.
- **Home directory:** Commonly `/home/riya` for ordinary users.
- **Login shell:** Program started for interactive shell logins, commonly `/bin/bash`.
- **Root:** The superuser, UID `0`, with broad administrative powers.
- **System/service account:** An account intended to run a service or system task rather than represent a person. UID ranges and creation defaults depend on system configuration.

### Analogy

Think of a Linux server as an office:
- username = employee's display name
- UID = unique employee number
- groups = teams or departments
- permissions = which rooms or files the employee can access
- root = highly privileged administrator

## 2. Inspect your current identity

```bash
whoami
id
id -u
id -g
groups
```

| Command | Meaning | Typical output pattern |
|---|---|---|
| `whoami` | Print effective username | `student` |
| `id` | Show UID, primary GID, and groups | `uid=1000(student) gid=1000(student) groups=1000(student)` |
| `id -u` | Print numeric UID only | `1000` |
| `id -g` | Print primary GID only | `1000` |
| `groups` | Print group memberships | `student wheel` |

Numbers and group names vary by machine.

## 3. Important account database files

Use `getent` for normal lookups. You can inspect public account metadata, but never publish sensitive contents.

### `/etc/passwd`

Stores one account record per line. Despite its name, modern systems do not normally store usable password hashes here.

```bash
getent passwd riya
```

Example record:

```text
riya:x:1002:1002:Riya Sharma:/home/riya:/bin/bash
```

Fields, separated by colons:
1. `riya` — username
2. `x` — password information is stored elsewhere
3. `1002` — UID
4. `1002` — primary GID
5. `Riya Sharma` — GECOS/comment field
6. `/home/riya` — home directory
7. `/bin/bash` — login shell

### `/etc/shadow`

Contains password-aging and protected password-hash information. Access is restricted. Do not paste or commit its contents to Git.

```bash
sudo getent shadow riya
```

This is shown for awareness only. In normal student exercises, use `passwd` and `chage` instead of viewing shadow records.

### `/etc/group`

Contains group metadata and listed supplementary members. Group administration is covered in the companion Group Management repository.

```bash
getent group wheel
```

### `/etc/login.defs`

Contains defaults used by account-management tools, including some UID/GID and password-aging defaults. Actual behavior can also depend on PAM, `/etc/default/useradd`, command options, and distribution configuration.

```bash
grep -E '^(UID_MIN|UID_MAX|PASS_MAX_DAYS|PASS_MIN_DAYS|PASS_WARN_AGE)' /etc/login.defs
```

Expected output is a set of configured values; exact numbers vary.

### `/etc/default/useradd`

May contain defaults used by `useradd`, such as the default shell and home-directory behavior.

```bash
grep -E '^(SHELL|HOME|INACTIVE|EXPIRE|SKEL)' /etc/default/useradd
```

A line may be absent on some installations. That does not automatically indicate a problem.

## 4. What happens when a user is created?

For a typical ordinary account, a command such as:

```bash
sudo useradd -m riya
```

may:
1. Create the account record.
2. Allocate a UID.
3. Set a primary group according to local defaults.
4. Create `/home/riya` because `-m` was specified.
5. Copy starter files from `/etc/skel` when configured.
6. Select a login shell according to defaults.

It does **not** necessarily set a usable password. Set one separately with `sudo passwd riya`.

## 5. Root and sudo

- `root` is UID 0 and can make system-wide changes.
- `sudo command` asks an authorized user to run a command with elevated privileges.
- Use the least privilege needed; avoid logging in as root for routine work.
- On RHEL, membership in the `wheel` group is commonly used for sudo access, but the effective policy depends on sudoers configuration.
- Never add users to privileged groups merely to make an error disappear. Understand why access is required first.

## 6. Verify before changing

Before modifying an account, inspect it:

```bash
id riya
getent passwd riya
sudo passwd -S riya
```

`passwd -S` reports password/account status in a short summary; exact status labels can vary. Do not infer every detail from one command alone.
