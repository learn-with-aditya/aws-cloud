# 1. Linux Search Basics

## Two different questions

Imagine an application support engineer investigating a website issue.

- “Where is `app.log`?” → use `find`.
- “Which lines in `app.log` contain `ERROR`?” → use `grep`.

| Command | Searches | Typical use |
|---|---|---|
| `find` | File system names, types, metadata | Find `.log` files or directories |
| `grep` | Text inside files or input streams | Find `ERROR`, usernames, IP addresses |

## Prepare the lab

From the repository root:
```bash
bash lab/setup-lab.sh
cd lab/sample-data
pwd
ls -R
```

`pwd` prints the current working directory. `ls -R` lists directories recursively. Exact paths depend on where you cloned the repository.

## Relative and absolute paths

- `.` means the current directory.
- `..` means the parent directory.
- `/` is the filesystem root.
- `~/` usually means the current user's home directory.
- A relative path is interpreted from the current directory.
- An absolute path starts at `/`.

Prefer `find . ...` while learning because it limits the search to the practice directory.

## Command pattern

```bash
find <starting-path> <tests-and-actions>
grep [OPTIONS] 'PATTERN' FILE...
```

Quotes matter. Use single quotes around patterns when possible so the shell does not expand special characters before `grep` receives them.

## First practice

```bash
find . -type f
grep 'ERROR' app.log
```

Expected:
- `find` prints file paths beneath the current directory.
- `grep` prints matching lines from `app.log`; if no line matches, it prints nothing and returns a non-zero status.
