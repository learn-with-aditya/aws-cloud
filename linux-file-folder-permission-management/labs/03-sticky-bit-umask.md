# Lab 03 — Sticky Bit and Umask

## Umask
Run inside your lab workspace:
```bash
cd /tmp/linux-permission-lab
umask
umask 002
touch umask-file.txt
mkdir umask-dir
ls -l umask-file.txt
ls -ld umask-dir
```
With common GNU/Linux defaults, the resulting modes are often `664` and `775`; the creating program's requested mode can change the result. `umask 002` applies to the current shell. Open a new shell or restore the original mask after the experiment.

## Sticky bit
```bash
mkdir sticky-demo
chmod 1777 sticky-demo
ls -ld sticky-demo
```
Expected pattern: `drwxrwxrwt`. The final `t` indicates the sticky bit. Practise only in your own lab folder; do not change `/tmp`.

## Review
Explain the leading `1` in `1777`, the leading `2` in `2770`, and why setting SUID on arbitrary executables is unsafe.
