# 02 — `getfacl`: Read ACLs

## 1. Syntax

```bash
getfacl [OPTIONS] FILE
```

Example:

```bash
getfacl report.txt
```

Sample output:

```text
# file: report.txt
# owner: riya
# group: projectteam
user::rw-
user:anita:rw-
group::r--
mask::rw-
other::---
```

Interpretation:
- `user::rw-`: file owner's permissions.
- `user:anita:rw-`: named ACL for `anita`.
- `group::r--`: owning group's ACL entry.
- `mask::rw-`: maximum effective permissions for named users, named groups, and owning group.
- `other::---`: permissions for everyone outside those classes.

Output varies with file mode, ACL entries, and system configuration.

## 2. Useful options

| Option | Meaning | Example |
|---|---|---|
| `-d` | Show a directory's default ACL | `getfacl -d shared/` |
| `-R` | Recursively inspect a tree | `getfacl -R project/` |
| `-p` | Do not strip leading `/` from path names in output | `getfacl -p /srv/project/report.txt` |
| `-c` | Omit comment header lines | `getfacl -c report.txt` |
| `-e` | Show effective rights comments for entries limited by mask | `getfacl -e report.txt` |

Use `-R` on large trees only when you expect the volume of output.

## 3. ACL versus `ls -l`

```bash
ls -l report.txt
getfacl report.txt
```

When extended ACLs exist, `ls -l` commonly shows a `+` after the basic permission bits, such as:

```text
-rw-rw----+ 1 riya projectteam 1200 report.txt
```

The `+` indicates additional ACL/security information; it does not show the full ACL. Use `getfacl` to inspect the entries.

## 4. Check default ACLs

```bash
getfacl -d shared/
```

This prints the directory's default ACL, if one exists. If no default ACL is configured, there may be no default entries to display.
