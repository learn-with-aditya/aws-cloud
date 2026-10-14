# 2. The `find` Command

## What it does
`find` walks through a directory tree and tests each filesystem object against conditions you specify. It can print paths, filter by metadata, or perform actions.

## Syntax
```bash
find STARTING_PATH TESTS ACTIONS
```
If no action is supplied, `find` normally prints matching paths.

## Essential options and tests

| Test / option | Meaning | Example |
|---|---|---|
| `-name` | Match basename, case-sensitive | `find . -name 'app.log'` |
| `-iname` | Match basename, case-insensitive | `find . -iname '*.LOG'` |
| `-type f` | Regular files | `find . -type f` |
| `-type d` | Directories | `find . -type d` |
| `-type l` | Symbolic links | `find . -type l` |
| `-name '*.log'` | Match names ending in `.log` | `find . -type f -name '*.log'` |
| `-size +1k` | Size greater than 1 KiB (GNU find uses 1 KiB units for `k`) | `find . -type f -size +1k` |
| `-size -1k` | Size below the specified threshold | `find . -type f -size -1k` |
| `-mtime -1` | Modified less than 1 day ago | `find . -type f -mtime -1` |
| `-mtime +6` | Modified at least roughly 7 days ago, using rounded 24-hour periods | `find . -type f -mtime +6` |
| `-empty` | Empty file or directory | `find . -empty` |
| `-maxdepth 2` | Do not descend more than 2 levels | `find . -maxdepth 2 -type f` |
| `-mindepth 2` | Do not test starting path itself; begin testing at depth 2 | `find . -mindepth 2 -type f` |
| `-user USER` | Objects owned by a user | `find . -user "$USER"` |
| `-perm MODE` | Match permissions | `find . -type f -perm 644` |
| `-exec CMD {} \\;` | Run a command for each match | `find . -type f -name '*.tmp' -exec ls -l {} \\;` |
| `-print` | Print matching path | `find . -type f -name '*.log' -print` |

### Important quoting rule
Use:
```bash
find . -type f -name '*.log'
```
Do not normally write `-name *.log` unquoted. The shell may expand `*.log` in the current directory before `find` receives it.

## Guided examples

### 1. Find a specific file
```bash
find . -type f -name 'app.log'
```
Expected path includes:
```text
./app.log
```

### 2. Find every log file
```bash
find . -type f -name '*.log'
```
Expected: paths for `app.log`, `access.log`, and `error.log` (plus any nested `.log` files).

### 3. Find directories
```bash
find . -type d
```
Expected: `.` and directories such as `./nested` and `./nested/archive`.

### 4. Find files without caring about extension case
```bash
find . -type f -iname '*.LOG'
```
Expected: `.log` and `.LOG` files.

### 5. Find empty files
```bash
find . -type f -empty
```
Expected includes `./empty.txt`.

### 6. Limit search depth
```bash
find . -maxdepth 1 -type f
```
Expected: files directly in the current directory, not files in subdirectories.

### 7. Find larger files
```bash
find . -type f -size +1k
```
Expected: files larger than the threshold. Exact results depend on sample-data content and GNU `find` size units.

### 8. Find files changed in the last 24 hours
```bash
find . -type f -mtime -1
```
Expected: files whose modification time is less than one 24-hour period ago. Setup or editing the lab may affect results.

### 9. Run a command on every match
```bash
find . -type f -name '*.log' -exec wc -l {} \;
```
- `{}` is replaced by the current matched path.
- `\;` ends the `-exec` action; the backslash protects the semicolon from the shell.
- `wc -l` counts lines.

### 10. Combine conditions
```bash
find . -type f \( -name '*.log' -o -name '*.txt' \)
```
- `-o` means OR.
- `\(` and `\)` group conditions; escape them so the shell passes them to `find`.

## Safety notes
- Understand a command before adding `-delete`.
- Test a search first with `-print`.
- Avoid broad commands such as `find / -type f` as a first exercise; they can be slow and produce permission errors.
