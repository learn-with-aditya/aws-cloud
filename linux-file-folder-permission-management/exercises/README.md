# Exercises — File and Folder Permissions

Try first, then check the answer key. Use a disposable VM.

## Tasks
1. Explain `-rw-r----- 1 riya projectteam 1200 report.txt`.
2. Set a file to owner read/write, group read, others none.
3. Add execute permission for the owner only.
4. Remove group write permission.
5. Why is `chmod 644 directory` usually unsuitable?
6. Change a file's group to `projectteam`.
7. Show symbolic and numeric permissions with `stat`.
8. Explain `chmod 2770 /srv/projectteam`.
9. Explain `chown riya:projectteam file` versus `chmod 640 file`.
10. What does `umask 002` commonly achieve?
11. What does the sticky bit do in a shared writable directory?
12. Which command shows parent-directory permissions along a path?
13. Why is `chmod -R 777 /var/www` dangerous?
14. Create a shared directory and test group access.

## Answer key
1. File type, owner/group/others mode bits, link count, owner, group, size, name.
2. `chmod 640 file`
3. `chmod u+x file`
4. `chmod g-w file`
5. Directories need execute/search for traversal.
6. `sudo chgrp projectteam file`
7. `stat -c '%A %a %U %G %n' file`
8. Setgid + owner `rwx` + group `rwx` + others `---`.
9. `chown` changes ownership; `chmod` changes permission bits.
10. It commonly allows group write where the application requests it; actual modes depend on requested mode.
11. It restricts removal/renaming of entries to the file owner, directory owner, or privileged user, subject to system rules.
12. `namei -l /path/to/file`
13. It recursively grants broad access and can make files executable when they should not be.
14. Follow `labs/02-team-shared-folder.md`.

## Final challenge
Create `release-notes.txt` with mode `640`, group-owned by `permteam`; create `/srv/permteam` with mode `2770`. Explain and verify every digit.
