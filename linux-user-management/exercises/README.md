# Independent Exercises — User Management

Try these without looking at the answer key first. Use a disposable RHEL 9 VM.

## Tasks

1. Display your current username and numeric UID.
2. Look up the `root` account with `getent`.
3. Create `anita` with a home directory and `/bin/bash` shell.
4. Set a password interactively.
5. Display `anita`'s UID, primary GID, and groups.
6. Change the account comment to `Cloud Student`.
7. Find the password-aging settings for `anita`.
8. Lock the password and inspect the account status.
9. Unlock it and verify the status.
10. Explain the difference between `userdel anita` and `userdel -r anita`.
11. Explain why `usermod -G developers anita` may be risky.
12. Find the command manual for `useradd`.

## Answer key

1. `whoami` and `id -u`
2. `getent passwd root`
3. `sudo useradd -m -s /bin/bash anita`
4. `sudo passwd anita`
5. `id anita`
6. `sudo usermod -c "Cloud Student" anita`
7. `sudo chage -l anita`
8. `sudo usermod -L anita && sudo passwd -S anita`
9. `sudo usermod -U anita && sudo passwd -S anita`
10. Without `-r`, the home directory is normally retained; with `-r`, removal of the home directory and mail spool is requested.
11. `-G` replaces the supplementary group list; use `-aG` to append a group.
12. `man useradd` or `useradd --help`

## Final challenge

Create `devintern`, set a lab password, verify its account record, set an account expiration date of `2026-12-31`, and explain what you would check before deleting it.

Possible command sequence:

```bash
sudo useradd -m -s /bin/bash devintern
sudo passwd devintern
id devintern
getent passwd devintern
sudo chage -E 2026-12-31 devintern
sudo chage -l devintern
```

Do not run the challenge on a real user account.
