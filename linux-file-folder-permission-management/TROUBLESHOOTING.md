# Troubleshooting

Use this sequence:
```bash
whoami
id
ls -l /path/to/file
ls -ld /path/to/directory
namei -l /path/to/file
getfacl /path/to/file
ls -Z /path/to/file
```
- `chmod`: mode bits; `chown`/`chgrp`: ownership.
- Directories need `x` for traversal.
- Group changes may require a new login session.
- ACLs and SELinux can affect access beyond basic mode bits.
- Never use `chmod -R 777` as a shortcut.
