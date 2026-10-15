# Lab 01 — Files and Directories

## Goal
Observe `rwx` on files and directories in a dedicated workspace.

## 1. Create the workspace
From the repository root:
```bash
chmod +x scripts/*.sh
./scripts/setup-lab.sh
cd /tmp/linux-permission-lab
```

## 2. Inspect permissions
```bash
ls -la
ls -ld .
stat -c '%A %a %U %G %n' notes.txt
```
Record the current modes.

## 3. Change a file mode
```bash
chmod 600 notes.txt
ls -l notes.txt
chmod 644 notes.txt
ls -l notes.txt
```
Expected patterns: `-rw-------`, then `-rw-r--r--`.

## 4. Test directory execute/search
```bash
mkdir demo-dir
touch demo-dir/example.txt
chmod 600 demo-dir
ls demo-dir
```
Access/listing should be restricted because the directory has no `x`. Restore your own lab directory:
```bash
chmod 700 demo-dir
ls demo-dir
```

## 5. Symbolic modes
```bash
chmod u+x notes.txt
chmod g-r notes.txt
chmod o-rwx notes.txt
ls -l notes.txt
```

## Questions
1. Why does a directory need `x`?
2. What does `600` mean?
3. Does `chmod` change ownership?
4. Why use `ls -ld directory`?
