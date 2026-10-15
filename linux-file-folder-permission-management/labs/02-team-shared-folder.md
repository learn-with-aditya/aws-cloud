# Lab 02 — User, Group, and Shared Folder

Use a disposable VM. Check for name conflicts before creating lab objects.

## 1. Check names
```bash
getent group permteam
getent passwd permstudent
```
If either exists, inspect it and choose another lab name.

## 2. Create a group and user
```bash
sudo groupadd permteam
sudo useradd -m -s /bin/bash permstudent
sudo passwd permstudent
```
Set a lab-only password interactively.

## 3. Add the user to the group
```bash
sudo usermod -aG permteam permstudent
id permstudent
getent group permteam
```
`-aG` appends supplementary membership. A fresh login session may be needed to see it in an existing shell.

## 4. Create shared directory
```bash
sudo mkdir -p /srv/permteam
sudo chown root:permteam /srv/permteam
sudo chmod 2770 /srv/permteam
ls -ld /srv/permteam
```
Expected pattern: `drwxrws---. ... root permteam ... /srv/permteam`.

## 5. Test file creation
```bash
sudo -u permstudent touch /srv/permteam/student-file.txt
ls -l /srv/permteam
```
The file's group commonly inherits `permteam`. Write bits still depend on the requested mode and umask.

## Cleanup — only lab objects
Inspect first:
```bash
getent passwd permstudent
getent group permteam
ls -ld /srv/permteam
```
If the objects and data are only from this lab:
```bash
sudo rm -f /srv/permteam/student-file.txt
sudo rmdir /srv/permteam
sudo userdel -r permstudent
sudo groupdel permteam
```
If a command fails because data or dependencies remain, stop and investigate.
