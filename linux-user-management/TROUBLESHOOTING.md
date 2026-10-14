# Troubleshooting — User Management

## `useradd: user 'labuser' already exists`

The username is already present.

```bash
getent passwd labuser
id labuser
```

Use a different practice username or deliberately clean up the lab account after confirming it is safe to remove.

## `Permission denied` or `Permission denied to perform this operation`

Account administration generally requires elevated privileges.

```bash
sudo useradd -m labuser
```

If `sudo` says the user is not allowed, ask the lab administrator. Do not try to bypass the policy.

## `useradd: group 'developers' does not exist`

The requested primary group is missing.

```bash
getent group developers
```

Create the group only if the exercise calls for it. See the companion Linux Group Management repository.

## Home directory was not created

Check the command used and the home path:

```bash
getent passwd labuser
ls -ld /home/labuser
```

Use `-m` at creation when a home directory is required. If the account already exists, plan a safe correction rather than blindly rerunning `useradd`.

## `usermod -aG` changes do not appear in the current terminal

The current login session may have old group credentials. Log out and back in, then verify:

```bash
id
id labuser
```

## `userdel` reports that the user is in use

The account may own running processes or have an active session. Inspect before taking action:

```bash
who
ps -u labuser
```

Do not kill processes or delete the account until you understand what is running and have authorization.

## `passwd` reports authentication token manipulation error

Possible causes include missing privileges, an account database problem, filesystem or security-policy issues, or an invalid account state. Verify the exact command, check `sudo` authorization, and review system logs with the lab administrator.

## `getent` returns no result

The account may not exist in the configured identity sources, or the lookup name may be incorrect.

```bash
getent passwd labuser
grep '^labuser:' /etc/passwd
```

The second command checks local `/etc/passwd` only; `getent` can also consult configured external sources.

## General debugging checklist

1. Copy the exact error message.
2. Check the username spelling.
3. Check the current identity with `whoami`.
4. Check the account with `getent` and `id`.
5. Read `man COMMAND` and confirm options for this RHEL version.
6. Avoid repeating destructive commands until the state is understood.
