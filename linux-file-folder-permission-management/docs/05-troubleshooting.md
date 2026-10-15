# 05 — Troubleshooting Permissions

Diagnose layer by layer; do not jump straight to `chmod 777`.

## 1. Confirm identity
```bash
whoami
id
id targetuser
```

## 2. Inspect target and parents
```bash
ls -l /path/to/file
ls -ld /path/to/directory
namei -l /path/to/file
```
A user needs traverse/search permission on parent directories. Directory `r` lets the user list names; directory `x` permits traversal/search.

## 3. Check group membership
```bash
id targetuser
getent group projectteam
```
After adding a group, an existing login session may need to be restarted before new group credentials are used.

## 4. Check other access-control layers
```bash
getfacl /path/to/file
ls -Z /path/to/file
getenforce
```
`getfacl` shows POSIX ACLs when installed. `ls -Z` shows SELinux labels; `getenforce` reports SELinux mode where available. Do not disable SELinux to hide an unexplained problem.

## Common issues
- **Permission denied:** inspect identity, mode bits, parent directories, ACLs, SELinux, and mount options.
- **Can read but cannot edit:** read permission is not write permission.
- **Can see a directory but cannot enter it:** check `x` on the directory and each parent.
- **Cannot delete a file despite file write permission:** deletion mainly depends on write and execute permission on the containing directory; sticky bit can also matter.
- **Group membership not reflected:** start a new login session and verify with `id`.
- **Operation not permitted:** check privileges, filesystem restrictions, and security policy.

Make the smallest safe correction: `chmod` for mode bits, `chown`/`chgrp` for ownership, group tools for authorized membership, and ACL/SELinux investigation when applicable.
