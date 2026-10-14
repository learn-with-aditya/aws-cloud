# Lab 02 — Membership and Permissions

## 1. Inspect membership

```bash
id labuser
groups labuser
getent group projectteam
```

Compare the output. `id` reports primary and supplementary IDs; `getent group` shows the group's database record.

## 2. Add one user to a second group

```bash
sudo groupadd qa-team
sudo usermod -aG qa-team labuser
id labuser
```

Confirm that `labuser` remains in `projectteam` as well as `qa-team`. If you had used `usermod -G qa-team labuser` without `-a`, the other supplementary group could have been removed.

## 3. Remove a user from a group

```bash
sudo gpasswd -d labuser qa-team
id labuser
getent group qa-team
```

Expected: `qa-team` no longer appears in `labuser`'s memberships.

## 4. Change a file's group

```bash
sudo touch /srv/projectteam/review.txt
sudo chgrp projectteam /srv/projectteam/review.txt
ls -l /srv/projectteam/review.txt
```

Expected: the group-owner field shows `projectteam`.

## 5. Compare permission modes

In a safe practice directory, compare:

```bash
chmod 750 sample-dir
chmod 770 sample-dir
chmod 2770 sample-dir
ls -ld sample-dir
```

- `750`: owner full access, group read/traverse, others none.
- `770`: owner and group full access, others none.
- `2770`: same owner/group access as `770`, plus setgid.

Do not apply these commands to `/`, `/home`, or application directories as an experiment.

## 6. Cleanup

Only remove objects created specifically for this lab, and check dependencies first.

```bash
getent passwd labuser
getent passwd anita
getent group projectteam
getent group qa-team
```

After confirming no needed data remains and the lab accounts are disposable:

```bash
sudo userdel -r labuser
sudo userdel -r anita
sudo groupdel projectteam
sudo groupdel qa-team
```

A group may refuse deletion if it remains a user's primary group. Investigate instead of forcing cleanup.
