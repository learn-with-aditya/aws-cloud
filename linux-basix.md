Absolutely. For **Day 1 of RHEL/Linux**, let’s focus on commands you will actually use as an administrator—not hundreds of commands to memorize.

## 🐧 Day 1 — RHEL/Linux Command Revision

### 1. Know where you are

```bash
pwd
```
Shows your current directory.

```bash
whoami
```
Shows the currently logged-in user.

```bash
hostname
```
Shows the system hostname.

```bash
date
```
Shows current date and time.

```bash
uname -r
```
Shows the running kernel version.

```bash
cat /etc/redhat-release
```
Shows the RHEL version.

---

# 2. Navigation — Most Important

### List files

```bash
ls
```

```bash
ls -l
```
Detailed listing.

```bash
ls -la
```
Detailed listing including hidden files.

```bash
ls -lh
```
Human-readable file sizes.

### Change directory

```bash
cd /etc
```

```bash
cd ..
```
Go one directory up.

```bash
cd ~
```
Go to your home directory.

```bash
cd -
```
Go back to the previous directory.

### Example

```bash
cd /var/log
pwd
ls -lh
```

This is a very common administrator workflow.

---

# 3. Creating Files & Directories

### Create directory

```bash
mkdir test
```

Multiple levels:

```bash
mkdir -p project/app/logs
```

### Create empty file

```bash
touch file.txt
```

### Create multiple files

```bash
touch file1.txt file2.txt file3.txt
```

---

# 4. Read Files

### Display entire file

```bash
cat file.txt
```

### Read large files

```bash
less file.txt
```

Very useful for logs.

Inside `less`:

```text
Space  → next page
b      → previous page
/word  → search
q      → quit
```

### First 10 lines

```bash
head file.txt
```

### Last 10 lines

```bash
tail file.txt
```

### Follow a log continuously

```bash
tail -f /var/log/messages
```

🔥 **Very important for troubleshooting.**

---

# 5. Copy, Move & Delete

### Copy

```bash
cp file.txt backup.txt
```

Directory:

```bash
cp -r project project_backup
```

### Move / Rename

```bash
mv file.txt newfile.txt
```

Move into directory:

```bash
mv file.txt /tmp/
```

### Delete file

```bash
rm file.txt
```

Delete directory:

```bash
rm -r project
```

⚠️ Be extremely careful with:

```bash
rm -rf
```

Especially:

```bash
rm -rf /
```

Never experiment with destructive commands as root.

---

# 6. Finding Files

### Find by name

```bash
find /etc -name "sshd_config"
```

Find `.log` files:

```bash
find /var/log -name "*.log"
```

Find files modified recently:

```bash
find /var/log -type f -mtime -1
```

---

# 7. Searching Inside Files

This is one of the **most important Linux skills**.

```bash
grep "error" logfile.txt
```

Case-insensitive:

```bash
grep -i "error" logfile.txt
```

Search recursively:

```bash
grep -r "Listen" /etc/
```

Example:

```bash
grep -i "failed" /var/log/secure
```

This is extremely useful when troubleshooting authentication problems.

---

# 8. File Permissions — Basic

Check permissions:

```bash
ls -l
```

Example:

```text
-rw-r--r--  user user  file.txt
```

Remember:

```text
r = read
w = write
x = execute
```

### chmod

```bash
chmod 755 script.sh
```

Common permissions:

```text
755 → rwxr-xr-x
644 → rw-r--r--
700 → rwx------
```

### Change owner

```bash
chown user:user file.txt
```

Directory recursively:

```bash
chown -R user:user project/
```

---

# 9. Users — Basic Commands

Current user:

```bash
whoami
```

See logged-in users:

```bash
who
```

More detailed:

```bash
w
```

Create user:

```bash
sudo useradd john
```

Set password:

```bash
sudo passwd john
```

Switch user:

```bash
su - john
```

Become root:

```bash
sudo -i
```

---

# 10. System Information

### Memory

```bash
free -h
```

### CPU/load

```bash
uptime
```

```bash
top
```

On RHEL, you may also use:

```bash
htop
```

if installed.

### Disk space

```bash
df -h
```

### Directory size

```bash
du -sh /var/log
```

### Block devices

```bash
lsblk
```

These commands are essential for server troubleshooting.

---

# 11. Networking — Day 1 Basics

### Show IP addresses

```bash
ip addr
```

Short version:

```bash
ip a
```

### Show routing table

```bash
ip route
```

### Test connectivity

```bash
ping 8.8.8.8
```

### DNS test

```bash
ping google.com
```

### Check DNS resolution

```bash
nslookup google.com
```

or:

```bash
dig google.com
```

if installed.

### Check listening ports

```bash
ss -tulnp
```

🔥 Very important when deploying applications.

For example, if your Nginx server should listen on port 80:

```bash
ss -tulnp | grep :80
```

---

# 12. Package Management in RHEL

RHEL uses **DNF**.

Search:

```bash
dnf search nginx
```

Install:

```bash
sudo dnf install nginx
```

Remove:

```bash
sudo dnf remove nginx
```

Update packages:

```bash
sudo dnf update
```

Check installed package:

```bash
rpm -q nginx
```

---

# 13. Services — Very Important for RHEL

RHEL uses **systemd**.

Check service:

```bash
systemctl status nginx
```

Start:

```bash
sudo systemctl start nginx
```

Stop:

```bash
sudo systemctl stop nginx
```

Restart:

```bash
sudo systemctl restart nginx
```

Enable at boot:

```bash
sudo systemctl enable nginx
```

Check whether enabled:

```bash
systemctl is-enabled nginx
```

🔥 Memorize this pattern:

```text
status
start
stop
restart
enable
disable
```

---

# 14. Logs — Essential Admin Skill

View system logs:

```bash
journalctl
```

Recent logs:

```bash
journalctl -n 50
```

Follow logs:

```bash
journalctl -f
```

Logs for a service:

```bash
journalctl -u nginx
```

Follow Nginx logs:

```bash
journalctl -u nginx -f
```

Logs since today:

```bash
journalctl --since today
```

---

# 🎯 Day 1 Commands to Memorize

Don't try to memorize everything above today.

Master these **30 commands**:

```text
pwd
ls
ls -la
cd
cd ..
cd ~
mkdir
touch
cat
less
head
tail
tail -f
cp
mv
rm
find
grep
chmod
chown
whoami
su
sudo
free -h
df -h
du -sh
ip a
ip route
ss -tulnp
systemctl
journalctl
```

### Your mental model

Think of Linux administration as:

```text
Navigate
   ↓
Inspect
   ↓
Create / Modify
   ↓
Permissions
   ↓
Users
   ↓
Processes
   ↓
Networking
   ↓
Services
   ↓
Logs
   ↓
Troubleshoot
```

For your **RHEL/AWS trainer preparation**, I recommend we make Day 1 practical rather than just memorizing commands. Next, we can do a **30–45 minute hands-on lab** where you create users, directories, files, permissions, find/search files, inspect memory/disk, check networking, and troubleshoot a service on your RHEL VM.
