# 04 — `umask` and Special Bits

## `umask`
`umask` removes permission bits from modes requested by programs when creating files/directories.

```bash
umask
umask -S
umask 002
touch sample-file
mkdir sample-dir
ls -l sample-file
ls -ld sample-dir
```
`umask` displays the current mask; `-S` shows symbolic form where supported. With common defaults, `umask 022` often results in files `644` and directories `755`; `umask 002` often results in files `664` and directories `775`. Actual results depend on the mode requested by the application.

The setting `umask 002` changes only the current shell's mask. Do not edit global login defaults for a basic exercise.

## Setgid on directories
```bash
chmod 2770 shared/
```
The leading `2` sets setgid. New entries commonly inherit the directory's group. `ls -ld` shows `s` in the group execute position, e.g. `drwxrws---`.

## Sticky bit
```bash
mkdir sticky-demo
chmod 1777 sticky-demo
ls -ld sticky-demo
```
The final `t` indicates the sticky bit. In a shared writable directory it restricts removal/renaming of entries to the file owner, directory owner, or privileged user, subject to system rules. Do not change `/tmp` as an exercise.

## SUID and SGID on executables
- SUID (leading numeric `4`) can make an executable run with the file owner's effective UID, subject to system rules.
- SGID (leading numeric `2`) on an executable can affect its effective group.
- These bits can introduce security risks. Never set them on arbitrary executables.
- SGID on a directory has the separate group-inheritance behavior explained above.

Examples are explanatory; never apply special bits to arbitrary system files.
