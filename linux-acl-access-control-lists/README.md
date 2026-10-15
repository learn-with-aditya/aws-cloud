# Linux ACL (Access Control Lists) — RHEL 9

A beginner-friendly, hands-on repository for learning Linux Access Control Lists (ACLs). ACLs extend standard owner/group/others permissions when the basic permission model is not enough.

## Learning outcomes

By completing this repository, students will be able to:
- Explain standard permissions versus ACLs.
- Inspect ACLs with `getfacl`.
- Grant and remove named-user and named-group ACL entries with `setfacl`.
- Understand the ACL mask and effective permissions.
- Configure default ACLs on directories.
- Apply ACLs recursively with care.
- Diagnose access failures involving permissions, ACLs, parent directories, and SELinux.
- Complete practical labs and independent exercises.

## Requirements and safety

- RHEL 9 or a compatible Linux distribution.
- A terminal; `sudo` access is needed for some ownership and system-level tasks.
- `acl` utilities (`getfacl`, `setfacl`) should be installed. On RHEL, if missing, try `sudo dnf install acl`.
- Use a disposable training VM. Do not practise on production files.
- Never use recursive ACL changes on a system directory without a reviewed plan.
- Do not use `setfacl -b` or recursive commands on real data unless you understand the consequences.

## Learning sequence

1. `docs/01-acl-fundamentals.md`
2. `docs/02-getfacl-reference.md`
3. `docs/03-setfacl-reference.md`
4. `docs/04-acl-mask-and-default-acls.md`
5. `docs/05-troubleshooting.md`
6. Complete the labs and exercises.

## Repository structure

- `docs/` — concepts, commands, ACL mask, default ACLs, troubleshooting
- `labs/01-named-user-acl.md` — grant specific-user access
- `labs/02-group-and-default-acl.md` — team directory and inheritance
- `labs/03-mask-and-removal.md` — effective permissions and safe cleanup
- `exercises/README.md` — practice tasks and answer key
- `scripts/setup-lab.sh` — creates a dedicated workspace and sample files
- `scripts/verify-lab.sh` — inspects lab permissions and ACLs
- `scripts/cleanup-lab.sh` — removes only the dedicated lab workspace

## Quick start

```bash
# Check whether tools are available
getfacl --version
setfacl --version

# Create a temporary practice file
mkdir -p ~/acl-practice
cd ~/acl-practice
touch report.txt

# Inspect current ACL
getfacl report.txt

# Grant a named user read/write access (replace anita with a real lab user)
sudo setfacl -m u:anita:rw report.txt

# Verify
getfacl report.txt
```

The example works only if the named user exists. Use a disposable user created for your lab.

## Important principle

**ACL entries grant additional, specific access, but the ACL mask can limit effective permissions.** Always verify with `getfacl`; do not rely only on `ls -l`.

## Suggested teaching plan

1. ACL purpose and standard permissions.
2. Read ACL output line by line.
3. Named user and named group ACL entries.
4. ACL mask and effective permissions.
5. Default ACLs and directory inheritance.
6. Recursive ACLs, removal, and troubleshooting.
