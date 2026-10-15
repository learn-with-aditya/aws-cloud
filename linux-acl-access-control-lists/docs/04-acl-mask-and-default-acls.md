# 04 — ACL Mask and Default ACLs

## 1. The ACL mask

The mask sets the maximum effective permissions for:
- named users
- named groups
- the owning group entry

It does not limit the file owner entry or the `other` entry.

Example:

```bash
setfacl -m u:anita:rwx,m::r-- report.txt
getfacl -e report.txt
```

The stored entry for `anita` may say `rwx`, but the effective permissions are limited by the mask to read-only (`r--`). `getfacl -e` can show the effective-rights comment.

## 2. Change the mask

```bash
setfacl -m m::rw report.txt
getfacl -e report.txt
```

- `-m`: modify ACL.
- `m::rw`: set the mask to read/write.
- The mask can make named-user/group entries effective up to the permissions allowed by the mask.

Be careful: changing the mask can affect the effective permissions of multiple ACL entries, not only one user.

## 3. Why `ls -l` can look surprising

With an extended ACL, the group permission bits displayed by `ls -l` commonly reflect the ACL mask, not necessarily just the owning group's raw ACL entry. A named user entry may have more permissions recorded than are currently effective.

Use:

```bash
getfacl -e report.txt
```

to understand effective permissions.

## 4. Default ACLs

A default ACL is set on a directory and serves as an access-control template for newly created files and subdirectories. It does not retroactively change existing children.

Example:

```bash
setfacl -m d:u:anita:rwX shared/
getfacl -d shared/
```

- `d:` indicates a default ACL entry.
- `u:anita:rwX` gives the named user read/write and conditional execute/search.
- The actual permissions of new entries are constrained by the mode requested by the creating application.

For a group:

```bash
setfacl -m d:g:developers:rwx shared/
getfacl -d shared/
```

## 5. Access ACL vs default ACL

- Access ACL: affects the existing target.
- Default ACL: template stored on a directory for future children.
- Adding a default ACL does not automatically rewrite the access ACL of every existing file.
- New files do not necessarily receive every permission listed in the default ACL; the creation mode requested by the program can limit the result.

## 6. Remove default ACLs

```bash
setfacl -k shared/
```

- `-k`: remove the directory's default ACL.
- This does not remove the directory itself.
- Use `getfacl -d shared/` to verify.

## 7. Practical design advice

Before configuring default ACLs, decide:
1. Which named users/groups need access?
2. Should new files be readable, writable, or executable by them?
3. Should existing files also be changed?
4. Is setgid needed for group inheritance as well?
5. How will you verify effective permissions?
