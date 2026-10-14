# Linux `find` and `grep` Practice Lab

A beginner-friendly, hands-on repository for learning Linux file discovery and text searching. Written for RHEL 9 and suitable for most Linux distributions.

## Learning outcomes
By completing this repository, you will be able to:
- Find files and directories by name, type, size, and modification time.
- Search file contents using `grep`, including case-insensitive, recursive, inverted, counted, and line-numbered searches.
- Use basic regular expressions and combine commands with pipes.
- Investigate application logs and configuration files safely.

## Requirements
- RHEL 9, Rocky Linux 9, AlmaLinux 9, Fedora, or Ubuntu.
- A terminal and a normal user account.
- `bash`, `find` (GNU findutils), and `grep` (GNU grep).

## Quick start
```bash
git clone <YOUR-REPOSITORY-URL>
cd linux-find-grep-practice
bash lab/setup-lab.sh
cd lab/sample-data
```
The setup script creates or refreshes only this repository's sample data. It does not need `sudo` and does not modify system directories.

## Recommended learning path
1. Read `docs/01-linux-search-basics.md`.
2. Work through `docs/02-find-command.md`.
3. Work through `docs/03-grep-command.md`.
4. Study `docs/04-regular-expressions.md`.
5. Complete the exercises before opening `solutions/`.

## Safety
- Practise on `lab/sample-data/`, not on system directories.
- Do not run destructive `find -delete` commands during beginner practice.
- Searching `/etc`, `/var/log`, or other protected locations may show `Permission denied`; this is normal for a non-root user.
- Never use `sudo` just to make a practice command work unless an instructor explicitly explains why it is needed.

## Main difference
- `find` searches for filesystem objects (files and directories).
- `grep` searches for matching text inside files.

Example:
```bash
find . -type f -name "*.log"
grep -n "ERROR" app.log
```

## Repository map
- `docs/`: lessons and command reference
- `lab/`: safe sample environment and setup scripts
- `exercises/`: questions without answers
- `solutions/`: answer keys; attempt exercises first
- `scripts/`: validation helper

## Verify the lab
```bash
bash scripts/verify-lab.sh
```

## Suggested classroom rule
For each task, write down: **purpose → command → flag meaning → predicted output → actual output → explanation**.

## License
MIT. See `LICENSE`.
