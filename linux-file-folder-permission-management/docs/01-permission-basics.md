# 01 — Permission Basics

## Owner, group, others
- **User/owner (`u`)**: the file's owning user.
- **Group (`g`)**: users matching the file's owning group.
- **Others (`o`)**: everyone else.
- **All (`a`)**: all three classes in symbolic `chmod`.

## Read, write, execute

| Bit | Regular file | Directory |
|---|---|---|
| `r` | Read contents | List entry names |
| `w` | Change contents | Create, remove, or rename entries (normally with `x`) |
| `x` | Execute as a program when applicable | Traverse/search the directory |

Directory `x` is not the same as executing a program. To access a path, the user usually needs search/traverse permission on every parent directory.

## Read `ls -l`
```bash
ls -l /etc/hosts
```
Example pattern:
```text
-rw-r--r--. 1 root root 227 Oct 15 09:00 /etc/hosts
```
- `-`: regular file; `d` means directory; `l` means symbolic link.
- `rw-`: owner can read/write.
- `r--`: group can read.
- `r--`: others can read.
- `root`: owner, then owning group.
- Remaining fields show link count, size, timestamp, and path.
- Trailing `.` or `+` may indicate additional security metadata.

Inspect a directory itself:
```bash
ls -ld /tmp
```
Without `-d`, `ls -l /tmp` lists the contents rather than the directory entry itself.

## Ownership and permissions are different
Example:
```text
-rw-r----- 1 riya projectteam 1200 report.txt
```
Owner `riya` can read/write; group `projectteam` can read; others have no basic mode-bit access. ACLs, SELinux, parent directories, and mount options may also affect access.

## Useful diagnostics
```bash
whoami
id
groups
namei -l /path/to/file
```
`id` shows UID, primary GID, and supplementary groups. `namei -l` displays permissions along a path and helps find a parent directory that blocks traversal.
