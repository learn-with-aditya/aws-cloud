# 3. The `grep` Command

## What it does
`grep` reads files or standard input and prints lines matching a pattern. It is useful for logs, configuration, reports, and command output.

## Syntax
```bash
grep [OPTIONS] 'PATTERN' FILE...
```

## Common flags

| Flag | Meaning | Example |
|---|---|---|
| `-i` | Ignore case | `grep -i 'error' app.log` |
| `-n` | Show line numbers | `grep -n 'ERROR' app.log` |
| `-r` | Search directories recursively | `grep -r 'ERROR' .` |
| `-R` | Recursive search and follow symlinks encountered (use with care) | `grep -R 'ERROR' .` |
| `-v` | Print non-matching lines | `grep -v 'INFO' app.log` |
| `-c` | Count matching lines per file | `grep -c 'ERROR' app.log` |
| `-l` | Print only filenames with matches | `grep -l 'ERROR' *.log` |
| `-L` | Print filenames with no matches | `grep -L 'ERROR' *.log` |
| `-w` | Match whole words | `grep -w 'fail' app.log` |
| `-x` | Match a whole line | `grep -x 'READY' status.txt` |
| `-E` | Extended regular expressions | `grep -E 'ERROR|WARN' app.log` |
| `-o` | Print only the matched part | `grep -o '10\\.[0-9.]\\+' access.log` (GNU BRE/ERE details vary; see regex lesson) |
| `-m N` | Stop after N matching lines per file | `grep -m 2 'ERROR' app.log` |
| `-A N` | Print N lines After a match | `grep -A 2 'ERROR' app.log` |
| `-B N` | Print N lines Before a match | `grep -B 2 'ERROR' app.log` |
| `-C N` | Print N lines of Context on each side | `grep -C 2 'ERROR' app.log` |

## Guided examples

### 1. Search for a literal word
```bash
grep 'ERROR' app.log
```
Expected: every line containing uppercase `ERROR`.

### 2. Ignore case
```bash
grep -i 'error' app.log
```
Expected: lines containing `ERROR`, `Error`, `error`, and other case variants.

### 3. Show line numbers
```bash
grep -n 'ERROR' app.log
```
Expected format:
```text
4:2026-10-14 09:02:14 ERROR Payment service timeout
```
The line number depends on the sample data.

### 4. Count matching lines
```bash
grep -c 'ERROR' app.log
```
Expected: a number, one count for this file. It counts matching lines, not necessarily total occurrences within lines.

### 5. Show lines that do not match
```bash
grep -v 'INFO' app.log
```
Expected: every line without `INFO`.

### 6. Search recursively
```bash
grep -rn 'ERROR' .
```
- `-r`: search files in subdirectories.
- `-n`: show line numbers.
Expected: matching lines with filename and line number.

### 7. Search multiple patterns
```bash
grep -E 'ERROR|WARN' app.log
```
Expected: lines containing either `ERROR` or `WARN`.

### 8. Show context around a failure
```bash
grep -n -C 2 'Payment service timeout' app.log
```
Expected: the matching line and up to two surrounding lines.

### 9. Use a pipe
```bash
cat app.log | grep -i 'error'
```
This works, but the shorter form is preferred:
```bash
grep -i 'error' app.log
```
Use pipes when the input comes from another command:
```bash
journalctl -u sshd | grep -i 'failed'
```

## Exit status
- `0`: at least one match was found.
- `1`: no match was found.
- `2` (or another error status): an error occurred, such as an unreadable file or invalid pattern.

A command that prints nothing may simply have found no match; check the pattern and file path before assuming a failure.
