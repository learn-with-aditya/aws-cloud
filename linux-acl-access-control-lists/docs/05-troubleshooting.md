# 05 — ACL Troubleshooting

## Diagnostic sequence

```bash
whoami
id
ls -l /path/to/file
namei -l /path/to/file
getfacl -e /path/to/file
```

If SELinux may be involved:

```bash
ls -Z /path/to/file
getenforce
```

## Common issues

### `setfacl: command not found`
On RHEL, install the ACL utilities if permitted:

```bash
sudo dnf install acl
```

### `Operation not supported`
The filesystem or mount may not support ACLs as configured. Check the exact mount and filesystem setup with your administrator.

### User ACL appears to grant `rwx`, but user cannot write
Check the ACL mask:

```bash
getfacl -e file.txt
```

The mask can reduce effective permissions.

### ACL looks correct but path access fails
Check parent directories:

```bash
namei -l /path/to/file
```

The user needs traversal/search permission on each parent directory.

### New files do not have expected ACLs
Check the directory's default ACL:

```bash
getfacl -d shared/
```

Default ACLs affect new children, not files that already existed. The creating program's requested mode can also limit the resulting permissions.

### `ls -l` shows `+`
The file has additional ACL/security metadata. Inspect the actual ACL using `getfacl`.

### Group membership was just changed
A new login session may be required before a running process receives updated group credentials.

### SELinux denial
ACLs do not override SELinux policy. Inspect labels and policy/logs; do not disable SELinux as a shortcut.

## Safe remediation

1. Capture the exact error.
2. Inspect owner, group, mode, ACL entries, and mask.
3. Inspect parent directories.
4. Check SELinux and filesystem support where relevant.
5. Make the smallest required change.
6. Verify using `getfacl -e` and a real test as the intended user.
