# Lab 02 — Group ACL and Default ACL

## Goal
Grant a team group access to a directory and configure a default ACL for new children.

Use a disposable directory and an existing lab group, such as `developers`. Check first:

```bash
getent group developers
```

If it does not exist, ask the instructor to create a lab group; do not modify an unrelated group.

## Step 1 — Create a workspace
```bash
mkdir -p ~/acl-lab/shared
chmod 700 ~/acl-lab/shared
```

## Step 2 — Grant group access to the existing directory
```bash
setfacl -m g:developers:rwx ~/acl-lab/shared
getfacl -e ~/acl-lab/shared
```

The named group entry should appear. Effective permissions can be limited by the ACL mask.

## Step 3 — Add a default ACL
```bash
setfacl -m d:g:developers:rwx ~/acl-lab/shared
getfacl -d ~/acl-lab/shared
```

This creates a default group ACL for new children. It does not rewrite existing files.

## Step 4 — Create a new child
```bash
touch ~/acl-lab/shared/new-report.txt
mkdir ~/acl-lab/shared/new-folder
getfacl ~/acl-lab/shared/new-report.txt
getfacl ~/acl-lab/shared/new-folder
```

Inspect the inherited ACL entries. Actual effective permissions depend on the creation mode and umask.

## Step 5 — Remove the default ACL
```bash
setfacl -k ~/acl-lab/shared
getfacl -d ~/acl-lab/shared
```

`-k` removes the directory's default ACL. It does not remove access ACL entries from existing children.

## Questions
1. How does a default ACL differ from an access ACL?
2. Does a default ACL modify existing files?
3. Why must you inspect effective permissions?
