# 03 — `setfacl`: Add, Change, and Remove ACLs

## 1. Syntax

```bash
setfacl [OPTIONS] ACL_SPEC FILE
```

The most common change option is `-m` (modify/add entries).

## 2. Grant a named user permissions

```bash
setfacl -m u:anita:rw report.txt
getfacl report.txt
```

- `-m`: modify ACL.
- `u:anita:rw`: grant named user `anita` read and write.
- `report.txt`: target file.

The user `anita` must exist for normal user-name resolution. Verify the result with `getfacl`.

## 3. Grant a named group permissions

```bash
setfacl -m g:developers:r-x project/
getfacl project/
```

- `g:developers:r-x`: grant the named group read and execute/search.
- For a directory, `x` allows traversal/search.
- To create or delete entries inside a directory, write and execute on the directory are normally both needed.

## 4. Add multiple entries

```bash
setfacl -m u:anita:rw,g:developers:r-x report.txt
```

This adds/modifies both entries. Verify with `getfacl report.txt`.

## 5. Remove one named ACL entry

```bash
setfacl -x u:anita report.txt
setfacl -x g:developers report.txt
```

- `-x`: remove the specified ACL entry.
- This does not delete the user or group; it only removes that ACL entry from the target.

## 6. Remove extended ACL entries

```bash
setfacl -b report.txt
```

- `-b`: remove all extended ACL entries.
- This can remove carefully configured access. Use only on a lab file or after reviewing the ACL.
- It does not delete the file.

## 7. Recursive ACL changes

```bash
setfacl -R -m g:developers:r-X project/
```

- `-R`: recurse through the directory tree.
- `-m`: modify entries.
- `g:developers:r-X`: grant read and conditional execute/search. Capital `X` adds execute to directories and to files that already have some execute bit.

Recursive changes can affect many files. Inspect the tree and verify the outcome before using this on real data.

## 8. Copy ACLs from one file to another

```bash
getfacl source.txt | setfacl --set-file=- target.txt
```

This pipes the ACL from `source.txt` into `target.txt`. Review both files first; copying ACLs can change the target's access policy. Some file metadata/comments are handled specially by the tools.

## 9. Verify after every change

```bash
getfacl report.txt
ls -l report.txt
```

`getfacl` is the authoritative view of ACL entries. Remember that the mask may reduce effective permissions.
