# 03 — Ownership and Shared Folders

## `chown`: change owner and/or group
Syntax: `chown [OPTIONS] OWNER[:GROUP] FILE`

```bash
sudo chown riya report.txt
sudo chown riya:projectteam report.txt
sudo chown :projectteam report.txt
```
- `riya`: set owner.
- `riya:projectteam`: set owner and group.
- `:projectteam`: set group only on GNU/Linux.

Options:
- `-R`: recursive; high impact.
- `-v`: report processed files.
- `--reference=FILE`: copy owner/group from a reference file.

## `chgrp`: change group owner
```bash
sudo chgrp projectteam report.txt
sudo chgrp -v projectteam report.txt
```
`-R` is recursive. Verify with `ls -l report.txt`.

## Shared team directory
Assuming group `projectteam` already exists:
```bash
sudo mkdir -p /srv/projectteam
sudo chown root:projectteam /srv/projectteam
sudo chmod 2770 /srv/projectteam
ls -ld /srv/projectteam
```
Expected pattern:
```text
drwxrws---. 2 root projectteam ... /srv/projectteam
```
`2770` means setgid + owner `rwx` + group `rwx` + others `---`. Setgid on a directory usually makes new entries inherit the directory's group.

Add a user only if authorized:
```bash
sudo usermod -aG projectteam labuser
id labuser
```
`-aG` appends a supplementary group. `usermod -G projectteam labuser` without `-a` can replace the user's supplementary group list.

## Important
Setgid helps group inheritance but does not guarantee each new file is group-writable. The creating program's mode and umask still matter. For advanced collaboration, a carefully designed default ACL may be appropriate.

## Recursive changes
Before `chown -R` or `chmod -R`:
1. Confirm the path with `pwd` and `ls`.
2. Inspect current ownership/modes.
3. Confirm scope and business need.
4. Avoid system paths and production data.
5. Verify the result.
