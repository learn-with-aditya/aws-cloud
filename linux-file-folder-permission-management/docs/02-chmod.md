# 02 — `chmod`: Change Permissions

## Syntax
```bash
chmod [OPTIONS] MODE FILE
```
`chmod` changes mode bits; it does not change owner or group.

## Numeric permissions
`r=4`, `w=2`, `x=1`. Add the values for each class. Three digits mean owner, group, others.

| Mode | Meaning |
|---:|---|
| `7` | `rwx` |
| `6` | `rw-` |
| `5` | `r-x` |
| `4` | `r--` |
| `0` | `---` |

Examples:
```bash
chmod 644 notes.txt
chmod 600 private.txt
chmod 755 script.sh
chmod 750 team-script.sh
chmod 700 private-dir
```
- `644`: owner read/write; group and others read.
- `600`: owner read/write only.
- `755`: owner full access; group/others read and execute.
- `750`: owner full; group read/execute; others none.
- `700`: owner full; group/others none.

`chmod` is usually silent on success. Verify using `ls -l FILE`.

## Symbolic mode
Classes: `u`, `g`, `o`, `a`; operators: `+` add, `-` remove, `=` set exactly.

```bash
chmod u+x script.sh
chmod g-w report.txt
chmod o-rwx private.txt
chmod u=rw,g=r,o= notes.txt
chmod a+r public-info.txt
```
- `u+x`: add execute for owner.
- `g-w`: remove group write.
- `o-rwx`: remove all basic permissions from others.
- `u=rw,g=r,o=`: owner `rw-`, group `r--`, others `---`.
- `a+r`: add read for all classes.

## Useful options
| Option | Meaning | Example |
|---|---|---|
| `-R` | Recursively change a tree | `chmod -R u+rwX project/` |
| `-v` | Report each processed file | `chmod -v 640 report.txt` |
| `-c` | Report only when a change occurs | `chmod -c 640 report.txt` |
| `--reference=FILE` | Copy mode from a reference | `chmod --reference=template.txt copy.txt` |

Use `-R` carefully. Capital `X` adds execute/search to directories and to files that already have some execute bit; still inspect the tree first.

## Verify
```bash
stat -c '%A %a %U %G %n' notes.txt
```
Example pattern: `-rw-r--r-- 644 student student notes.txt`.

## Common mistakes
- `chmod 777`: grants broad access and is usually unsafe.
- `chmod 644 directory`: removes directory execute/search and can block traversal.
- `chmod` does not fix a missing `x` on a parent directory.
