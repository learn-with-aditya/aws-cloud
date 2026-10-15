# Linux File & Folder Permission Management (RHEL 9)

A student-friendly, hands-on guide to Linux permissions, ownership, and shared folders.

## Learning path
1. Read `docs/01-permission-basics.md`.
2. Learn symbolic and numeric `chmod` in `docs/02-chmod.md`.
3. Learn ownership and shared groups in `docs/03-ownership-shared-folders.md`.
4. Learn `umask`, setgid, and sticky bit in `docs/04-umask-special-bits.md`.
5. Complete the labs and exercises, then use `docs/05-troubleshooting.md`.

## Requirements and safety
- RHEL 9 or compatible Linux VM; sudo access for ownership changes.
- Practise on a disposable VM, never on production paths.
- Never use `chmod -R 777` as a shortcut.
- Review every command before running it.

## Teaching pattern
**Concept → Predict output → Run command → Verify → Explain → Practise.**

## Quick start
```bash
ls -l /etc/hosts
ls -ld /tmp
id
man chmod
```

## Contents
- `docs/` — concept notes and command reference
- `labs/` — guided hands-on activities
- `exercises/README.md` — tasks and answer key
- `scripts/` — optional safe lab setup, verification, cleanup
