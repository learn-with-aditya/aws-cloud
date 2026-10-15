# 01 — ACL Fundamentals

## 1. What is an ACL?

An Access Control List (ACL) lets an administrator grant permissions to specific users or groups beyond the standard owner/group/others permission classes.

### Standard permissions

A file might have mode `640`:

```text
-rw-r-----
```

- Owner: read/write
- Owning group: read
- Others: no access

This cannot directly describe a separate permission for one named user who is neither the owner nor a member of the owning group.

### ACL solution

```bash
setfacl -m u:anita:rw report.txt
getfacl report.txt
```

This adds a named-user ACL entry for `anita`. The owner and owning group do not need to change.

## 2. When are ACLs useful?

- Give one auditor read access to a report without changing the owning group.
- Give a specific contractor access to a project directory.
- Give a team group access to a shared folder.
- Set default permissions for new entries inside a directory.

ACLs do not replace standard permissions, groups, or SELinux. They complement them.

## 3. ACL terminology

- **Access ACL:** Permissions applied to an existing file or directory.
- **Default ACL:** A directory-level template used when new children are created; supported on directories.
- **Named user entry:** Permissions for a particular user, e.g. `user:anita:rw-`.
- **Named group entry:** Permissions for a particular group, e.g. `group:developers:r-x`.
- **ACL mask:** Maximum effective permissions for named users, named groups, and the owning group class.
- **Effective permissions:** What the ACL entry allows after the mask is applied.

## 4. Install the ACL utilities

Check:

```bash
command -v getfacl
command -v setfacl
```

If commands are missing on RHEL:

```bash
sudo dnf install acl
```

- `dnf`: package manager.
- `install`: install the requested package.
- `acl`: package that supplies ACL utilities on RHEL-family systems.

Expected output: package-manager output describing installation or that the package is already installed. Network/repository configuration can affect the result.

## 5. Important filesystem note

Most common RHEL Linux filesystems support POSIX ACLs, but behavior can depend on filesystem and mount configuration. If ACL commands fail, inspect the error and filesystem rather than assuming every mount supports ACLs.
