# ACL Exercises — Tasks and Answer Key

Use a disposable VM and lab files.

## Tasks
1. Explain why ACLs are useful beyond standard owner/group/others permissions.
2. Display the ACL for `report.txt`.
3. Give user `anita` read access to `report.txt`.
4. Give group `developers` read/execute access to `project/`.
5. Remove only `anita`'s ACL entry from `report.txt`.
6. Explain `setfacl -b report.txt`.
7. Explain the ACL mask and effective permissions.
8. Configure a default ACL giving group `developers` read/write/execute on new children of `shared/`.
9. Display only a directory's default ACL.
10. Explain why a default ACL does not rewrite existing files.
11. Diagnose why an ACL entry shows `rwx` but effective access is only `r--`.
12. Explain why `chmod` and ACL changes must be verified together.

## Answer key
1. ACLs can grant specific access to named users/groups without changing owner or owning group.
2. `getfacl report.txt`
3. `setfacl -m u:anita:r report.txt`
4. `setfacl -m g:developers:r-x project/`
5. `setfacl -x u:anita report.txt`
6. It removes extended ACL entries; use only when intended.
7. The mask limits effective permissions for named users, named groups, and the owning group entry.
8. `setfacl -m d:g:developers:rwx shared/`
9. `getfacl -d shared/`
10. A default ACL is a template for newly created children.
11. Inspect with `getfacl -e`; the ACL mask may be limiting effective rights.
12. Standard mode bits and ACL mask/entries interact; inspect using `ls -l` and `getfacl -e`.

## Final challenge
Create a lab directory, grant a named user read/write access to one file, grant a group access to the directory, configure a default ACL, and document the output of `getfacl -e` before and after each change.
