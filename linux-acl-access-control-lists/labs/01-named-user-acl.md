# Lab 01 — Grant a Named User Access

## Goal
Grant a specific user read/write access to a file without changing its owner or owning group.

## Step 1 — Check the lab user
Use an existing disposable user or ask your instructor to create one. Example username: `anita`.

```bash
id anita
```

If the user does not exist, do not continue with that name.

## Step 2 — Create a lab file
```bash
mkdir -p ~/acl-lab
cd ~/acl-lab
printf 'Confidential training report\n' > report.txt
chmod 640 report.txt
ls -l report.txt
```

Expected basic mode: `-rw-r-----`. Your username/group and file size will differ.

## Step 3 — Inspect its ACL
```bash
getfacl report.txt
```

Before adding an ACL, the output commonly includes owner, owning group, `user::rw-`, `group::r--`, and `other::---`.

## Step 4 — Grant `anita` read/write
```bash
setfacl -m u:anita:rw report.txt
getfacl report.txt
ls -l report.txt
```

Expected: a named user entry for `anita` appears. `ls -l` often shows a `+` after the permission bits.

## Step 5 — Verify effective rights
```bash
getfacl -e report.txt
```

Read the `user:anita` entry and any effective-rights note. The mask may limit the effective permission.

## Step 6 — Remove only the named ACL entry
```bash
setfacl -x u:anita report.txt
getfacl report.txt
```

This removes the ACL entry, not the account.

## Questions
1. Did the owner or group change?
2. What does the `+` in `ls -l` indicate?
3. Which command shows the complete ACL?
4. What is the difference between `setfacl -x` and `setfacl -b`?
