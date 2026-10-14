# Independent Exercises — Group Management

Complete these on a disposable RHEL 9 VM.

## Tasks

1. Display your current group memberships.
2. Look up the `wheel` group without changing it.
3. Create a group called `frontend`.
4. Create a lab user called `meera`.
5. Add `meera` to `frontend` without removing other supplementary groups.
6. Verify membership using two different commands.
7. Create `/srv/frontend` owned by `root:frontend`.
8. Set permissions to `2770` and explain each digit.
9. Create a file as `meera` inside `/srv/frontend` and inspect its group.
10. Remove `meera` from `frontend` without deleting the account.
11. Explain why group ownership and group membership are different.
12. Explain why `chmod 777` is usually a poor default.

## Answer key

1. `id` or `groups`
2. `getent group wheel`
3. `sudo groupadd frontend`
4. `sudo useradd -m meera`
5. `sudo usermod -aG frontend meera`
6. `id meera` and `getent group frontend`
7. `sudo mkdir -p /srv/frontend && sudo chown root:frontend /srv/frontend`
8. `sudo chmod 2770 /srv/frontend`; setgid + owner rwx + group rwx + no permissions for others.
9. Start a fresh session if needed, then `sudo -u meera touch /srv/frontend/test.txt`; inspect with `ls -l`.
10. `sudo gpasswd -d meera frontend`
11. Membership identifies who belongs to the group; ownership identifies which group is attached to a file or directory.
12. It grants all local users read/write/execute permissions where applicable and violates least privilege.

## Final challenge

Create `design-team`, add two lab users, configure a shared directory, prove both can create files, and write down the exact owner, group, and permission bits you observed. Clean up only the objects created for the challenge.
