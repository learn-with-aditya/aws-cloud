## RPM vs YUM vs DNF

Think of them as three layers:

```text
                 RHEL Package Management
                         │
              ┌──────────┴──────────┐
              │                     │
             RPM                  DNF/YUM
        Low-level tool        High-level tools
              │                     │
        .rpm packages          Repositories
                                  │
                           Dependencies
                                  │
                         Install / Update
```

### 1. `rpm` — Low-level package manager

RPM works directly with **`.rpm` package files** and the local RPM database.

Example:

```bash
rpm -ivh nginx.rpm
```

Check whether a package is installed:

```bash
rpm -q nginx
```

Get package information:

```bash
rpm -qi nginx
```

List files installed by a package:

```bash
rpm -ql nginx
```

Find which package owns a file:

```bash
rpm -qf /usr/sbin/nginx
```

### Important limitation

`rpm` **does not automatically resolve dependencies**.

For example, if `nginx.rpm` requires:

```text
package-A
package-B
package-C
```

RPM may fail unless those dependencies are already installed.

---

# 2. `dnf` — Modern RHEL package manager

`dnf` is the **preferred package management tool in modern RHEL**.

It works with repositories and automatically handles dependencies.

Install:

```bash
sudo dnf install nginx
```

Remove:

```bash
sudo dnf remove nginx
```

Update:

```bash
sudo dnf update
```

Search:

```bash
dnf search nginx
```

Show information:

```bash
dnf info nginx
```

List installed packages:

```bash
dnf list installed
```

### Why DNF is better for normal administration

Suppose you run:

```bash
sudo dnf install nginx
```

DNF can:

```text
Find nginx
   ↓
Find required dependencies
   ↓
Download packages
   ↓
Install dependencies
   ↓
Install nginx
```

So for **normal RHEL administration → use DNF**.

---

# 3. `yum` — Older package manager

`yum` stands for:

**Yellowdog Updater, Modified**

Historically, YUM was the standard high-level package manager on RHEL/CentOS.

Example:

```bash
yum install nginx
```

```bash
yum update
```

```bash
yum remove nginx
```

### But here's the important part

Modern RHEL uses **DNF underneath**.

On newer RHEL versions, `yum` is essentially maintained as a compatibility interface to DNF.

So:

```bash
yum install nginx
```

and

```bash
dnf install nginx
```

are generally using the same modern package-management infrastructure.

---

# 🔥 So when should YOU use what?

| Tool | Use it when |
|---|---|
| **rpm** | Working directly with `.rpm` files or querying package information |
| **dnf** | Normal package installation, removal, updates, dependencies |
| **yum** | Legacy systems/scripts or when documentation specifically uses YUM |

### For your RHEL learning:

**Prefer:**

```bash
dnf
```

Learn:

```bash
rpm
```

Understand:

```bash
yum
```

---

## Practical example

Imagine you downloaded:

```text
nginx-1.28.x.rpm
```

### Option 1 — RPM

```bash
sudo rpm -ivh nginx-1.28.x.rpm
```

If dependencies are missing, you may get an error.

### Option 2 — DNF

```bash
sudo dnf install ./nginx-1.28.x.rpm
```

DNF can resolve the dependencies.

**This is a very useful distinction.**

---

## 🧠 Easy interview answer

If an interviewer asks:

> **"What is the difference between RPM, YUM and DNF?"**

Say:

> **RPM is a low-level package management tool used to install and query individual `.rpm` packages, while YUM and DNF are high-level package managers that work with repositories and resolve dependencies. DNF is the modern package manager used in current RHEL versions, while YUM is primarily retained for compatibility with older systems and commands.**

### One-line memory trick

```text
RPM  → Individual .rpm package
YUM  → Older high-level package manager
DNF  → Modern high-level package manager
```
