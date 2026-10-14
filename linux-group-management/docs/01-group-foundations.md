# 01 — Group Management Foundations

## 1. What is a Linux group?

A group is a named collection of users identified internally by a numeric **GID** (Group ID). Groups make it easier to grant the same file access to several users without setting permissions user by user.

### Office analogy

Imagine a company project room:
- users are employees
- a group is the project team
- group ownership identifies the team responsible for a file or directory
- group permissions determine what team members can do
- the setgid bit on a shared directory helps new files inherit the directory's group

## 2. Primary vs supplementary groups

- **Primary group:** The default group identity for files a user creates, unless directory inheritance or other mechanisms change the result.
- **Supplementary group:** An additional group membership that can provide access to files and services.
- A user has one primary group at a time, but can belong to multiple supplementary groups.
- On many RHEL configurations, a user's initial primary group has the same name as the username. This is a default, not a universal rule.

Inspect a user:

```bash
id labuser
groups labuser
```

Example:

```text
uid=1002(labuser) gid=1002(labuser) groups=1002(labuser),1005(projectteam)
```

Interpretation:
- UID 1002 identifies `labuser`.
- GID 1002 is the primary group.
- GID 1005 is a supplementary group.

## 3. Group database files

### `/etc/group`

Example record:

```text
projectteam:x:1005:labuser,anita
```

Fields:
1. Group name: `projectteam`
2. Password placeholder: `x`
3. GID: `1005`
4. Comma-separated supplementary members listed in the file

A user's primary-group relationship is recorded by GID in the user's account record; the user may not appear in the member list for that primary group.

Use:

```bash
getent group projectteam
```

### `/etc/gshadow`

Contains protected group administration information. Do not expose or commit its contents.

```bash
sudo getent gshadow projectteam
```

Shown for awareness; routine student labs should use `getent group`, `groups`, `id`, and group-management commands instead.

## 4. Group ownership vs group membership

These are related but different:
- **Membership:** Which users belong to a group.
- **Ownership:** Which group owns a file or directory.
- **Permissions:** What the owner, group, and others may do.

Example:

```bash
ls -ld /srv/projectteam
```

Possible output:

```text
drwxrws---. 2 root projectteam 6 Oct 14 10:30 /srv/projectteam
```

Interpretation:
- `root` is the owner user.
- `projectteam` is the owning group.
- `rwx` for owner: read, write, traverse directory.
- `rws` for group: read, write, traverse, plus setgid.
- `---` for others: no permissions.

Directory permissions mean:
- `r` = list directory entries
- `w` = create/remove/rename entries (usually also requires `x`)
- `x` = traverse/search the directory

## 5. `chmod`, `chgrp`, and `chown`

- `chgrp projectteam file.txt`: change the owning group.
- `chown root:projectteam file.txt`: change owner and group.
- `chmod 2770 /srv/projectteam`: owner and group get full access, others get none, and setgid is enabled on the directory.

Numeric permissions:
- `r = 4`
- `w = 2`
- `x = 1`
- `7 = 4+2+1 = rwx`
- `6 = 4+2 = rw-`
- `5 = 4+1 = r-x`
- `0 = ---`

The leading `2` in `2770` enables setgid on a directory. Newly created files and subdirectories normally inherit the directory's group, subject to filesystem and application behavior. Setgid does not automatically make every new file group-writable; default permissions and umask still matter.

## 6. Least privilege

- Grant only the group access required for the task.
- Avoid using `chmod 777` as a shortcut.
- Avoid adding users to `wheel` or other privileged groups unless required and approved.
- Check permissions with `ls -l`, `ls -ld`, `id`, and `getent`.
- For more complex per-user access, POSIX ACLs may be appropriate, but learn standard owner/group/other permissions first.
