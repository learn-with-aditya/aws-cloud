# Troubleshooting — Group Management

## `groupadd: group 'projectteam' already exists`

Check it:

```bash
getent group projectteam
```

Choose another practice name or verify whether the existing group is your own lab object before making changes.

## User is not shown in the group output

```bash
id labuser
getent group projectteam
```

Check the command used. `usermod -aG projectteam labuser` appends a supplementary group. `usermod -G projectteam labuser` replaces the supplementary group list.

A current login session may not show new group credentials; log out and back in before testing interactively.

## `groupdel` refuses to delete a group

A group cannot normally be deleted while it is the primary group of an existing user. Inspect account records and dependencies before deciding what to change.

## `Permission denied` in a shared directory

Check each layer:

```bash
id
id labuser
ls -ld /srv/projectteam
ls -l /srv/projectteam
namei -l /srv/projectteam
```

Consider:
1. Is the user a member of the group?
2. Does the user have a fresh login session?
3. Does the directory grant group `w` and `x`?
4. Do parent directories grant traverse (`x`) permission?
5. Is the file owned by the expected group?
6. Could SELinux or an ACL be affecting access?

Do not jump straight to `chmod 777`.

## New files have the wrong group

Check the directory group and setgid bit:

```bash
ls -ld /srv/projectteam
```

The group execute-position `s` indicates setgid on a directory. Also verify which directory the file was created in and whether a mount or application has special behavior.

## Files are not group-writable

Group inheritance is not the same as group write permission. Inspect:

```bash
ls -l /srv/projectteam
umask
```

The process umask and requested creation mode affect permissions. A real shared-workflow may need a carefully designed default ACL or application-specific configuration.

## Group name changed but files still show an unexpected group

Files store numeric GIDs. If a group's GID was changed, existing files may still have the old numeric GID. Audit the affected filesystem and plan a controlled ownership update rather than making a broad recursive change without review.

## General debugging checklist

1. Capture the exact error.
2. Verify the group with `getent group GROUP`.
3. Verify the user's membership with `id USER`.
4. Inspect ownership and permissions with `ls -l` or `ls -ld`.
5. Check parent-directory traversal permissions with `namei -l PATH`.
6. Consider session refresh, ACLs, and SELinux.
7. Read the installed manual page before making broad changes.
