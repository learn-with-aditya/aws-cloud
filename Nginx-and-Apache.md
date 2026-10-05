# AWS EC2 RHEL — Apache + Nginx Deployment Guide

## 1. Architecture

```text
                    Internet
                       │
                       ▼
              ┌─────────────────┐
              │   AWS Route 53  │
              │   example.com   │
              └────────┬────────┘
                       │
                       ▼
              ┌─────────────────┐
              │   EC2 - RHEL    │
              │ Public IP / EIP  │
              └────────┬────────┘
                       │
                  Port 80/443
                       │
                       ▼
              ┌─────────────────┐
              │      NGINX      │
              │ Reverse Proxy   │
              └────────┬────────┘
                       │
                    Port 8080
                       │
                       ▼
              ┌─────────────────┐
              │     Apache      │
              │     httpd       │
              └────────┬────────┘
                       │
                       ▼
              /var/www/mywebsite
```

### Why use both?

| Component | Responsibility |
|---|---|
| Nginx | Public-facing web server/reverse proxy |
| Apache | Application/web server |
| RHEL | Operating system |
| EC2 | Compute server |
| Route 53 | DNS |
| Security Group | Network firewall |
| Certbot/Let's Encrypt | HTTPS certificate |

For a simple static website, using both Apache and Nginx is unnecessary. But for **learning, reverse proxy architecture, PHP/Apache applications, or mixed workloads**, it is a useful setup.

---

# 2. Create EC2 Instance

Go to:

**AWS Console → EC2 → Launch Instance**

Select:

```text
AMI:
Red Hat Enterprise Linux

Architecture:
64-bit x86

Instance:
t3.micro
```

For a training/demo server, `t3.micro` is usually enough.

For a real application, choose according to workload.

---

# 3. Configure Security Group

Create a security group such as:

```text
RHEL-WebServer-SG
```

Inbound rules:

| Type | Port | Source |
|---|---:|---|
| SSH | 22 | My IP |
| HTTP | 80 | 0.0.0.0/0 |
| HTTPS | 443 | 0.0.0.0/0 |

### Important

Do **not** expose Apache port `8080` publicly.

We want:

```text
Internet → 80/443 → Nginx → 8080 → Apache
```

not:

```text
Internet → 8080 → Apache
```

---

# 4. Connect to RHEL

RHEL EC2 commonly uses the `ec2-user` account.

From your terminal:

```bash
ssh -i my-key.pem ec2-user@YOUR_PUBLIC_IP
```

Example:

```bash
ssh -i aws-key.pem ec2-user@13.233.xx.xx
```

Check the OS:

```bash
cat /etc/redhat-release
```

Check kernel:

```bash
uname -r
```

Check current user:

```bash
whoami
```

---

# 5. Update RHEL

First update packages:

```bash
sudo dnf update -y
```

You can also check available packages:

```bash
sudo dnf check-update
```

---

# 6. Install Apache

On RHEL, Apache is provided by the `httpd` package.

```bash
sudo dnf install httpd -y
```

Check:

```bash
httpd -v
```

Start Apache:

```bash
sudo systemctl start httpd
```

Enable it at boot:

```bash
sudo systemctl enable httpd
```

Check status:

```bash
sudo systemctl status httpd
```

---

# 7. Test Apache

Apache normally listens on:

```text
Port 80
```

Check:

```bash
sudo ss -lntp | grep httpd
```

You should see something similar to:

```text
LISTEN 0 511 0.0.0.0:80
```

However, we eventually want **Nginx on port 80**, so Apache must move to `8080`.

---

# 8. Configure Apache on Port 8080

Open Apache configuration:

```bash
sudo vi /etc/httpd/conf/httpd.conf
```

Find:

```apache
Listen 80
```

Change to:

```apache
Listen 8080
```

Save.

Now restart Apache:

```bash
sudo systemctl restart httpd
```

Check:

```bash
sudo ss -lntp | grep 8080
```

Expected:

```text
LISTEN 0 511 0.0.0.0:8080
```

---

# 9. Create Website Directory

Instead of putting your application directly into `/var/www/html`, create a dedicated directory:

```bash
sudo mkdir -p /var/www/mywebsite
```

Create a test page:

```bash
sudo vi /var/www/mywebsite/index.html
```

Put:

```html
<!DOCTYPE html>
<html>
<head>
    <title>My RHEL Website</title>
</head>
<body>
    <h1>Hello from RHEL + Apache + Nginx</h1>
    <p>Website successfully deployed.</p>
</body>
</html>
```

---

# 10. Configure Apache Virtual Host

Create:

```bash
sudo vi /etc/httpd/conf.d/mywebsite.conf
```

Add:

```apache
<VirtualHost *:8080>

    ServerName example.com
    ServerAlias www.example.com

    DocumentRoot /var/www/mywebsite

    <Directory /var/www/mywebsite>
        AllowOverride All
        Require all granted
    </Directory>

    ErrorLog /var/log/httpd/mywebsite_error.log
    CustomLog /var/log/httpd/mywebsite_access.log combined

</VirtualHost>
```

Replace:

```text
example.com
```

with your actual domain.

---

# 11. Test Apache Configuration

Very important:

```bash
sudo apachectl configtest
```

Expected:

```text
Syntax OK
```

Then:

```bash
sudo systemctl restart httpd
```

---

# 12. Fix RHEL SELinux Context

This is an important difference when working with RHEL.

Check SELinux:

```bash
getenforce
```

If you get:

```text
Enforcing
```

set the correct context for your website:

```bash
sudo semanage fcontext -a -t httpd_sys_content_t "/var/www/mywebsite(/.*)?"
```

Then:

```bash
sudo restorecon -Rv /var/www/mywebsite
```

If `semanage` is not installed:

```bash
sudo dnf install policycoreutils-python-utils -y
```

Then run the `semanage` command again.

---

# 13. Set File Permissions

Set ownership:

```bash
sudo chown -R apache:apache /var/www/mywebsite
```

Set directory permissions:

```bash
sudo find /var/www/mywebsite -type d -exec chmod 755 {} \;
```

Set file permissions:

```bash
sudo find /var/www/mywebsite -type f -exec chmod 644 {} \;
```

---

# 14. Test Apache Locally

Before installing Nginx, test Apache directly from the server:

```bash
curl http://localhost:8080
```

You should get:

```html
<h1>Hello from RHEL + Apache + Nginx</h1>
```

This is a very important troubleshooting principle:

> **First make Apache work. Then configure Nginx.**

---

# 15. Install Nginx

Install:

```bash
sudo dnf install nginx -y
```

Check:

```bash
nginx -v
```

---

# 16. Start Nginx

```bash
sudo systemctl start nginx
```

Enable at boot:

```bash
sudo systemctl enable nginx
```

Check:

```bash
sudo systemctl status nginx
```

---

# 17. Configure Nginx Reverse Proxy

Create configuration:

```bash
sudo vi /etc/nginx/conf.d/mywebsite.conf
```

Add:

```nginx
server {

    listen 80;
    server_name example.com www.example.com;

    location / {

        proxy_pass http://127.0.0.1:8080;

        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

Replace:

```text
example.com
```

with your actual domain.

---

# 18. Test Nginx Configuration

Always test before restarting:

```bash
sudo nginx -t
```

Expected:

```text
syntax is ok
test is successful
```

Then:

```bash
sudo systemctl restart nginx
```

---

# 19. Check Ports

Now run:

```bash
sudo ss -lntp
```

You should have approximately:

```text
:80      nginx
:8080    httpd
```

Architecture:

```text
          Port 80
             │
             ▼
          NGINX
             │
             │ proxy
             ▼
        127.0.0.1:8080
             │
             ▼
          APACHE
             │
             ▼
       /var/www/mywebsite
```

---

# 20. Important RHEL SELinux Setting for Nginx

Because Nginx is making a network connection to Apache, SELinux may block it.

Enable the appropriate boolean:

```bash
sudo setsebool -P httpd_can_network_connect 1
```

This is a very important RHEL troubleshooting step.

---

# 21. Test from Browser

Now open:

```text
http://YOUR_EC2_PUBLIC_IP
```

or:

```text
http://example.com
```

Request flow:

```text
Browser
   ↓
EC2 Public IP
   ↓
Security Group
   ↓
Nginx :80
   ↓
Apache :8080
   ↓
Website
```

---

# 22. Configure DNS

Suppose your EC2 Elastic IP is:

```text
13.233.xx.xx
```

In Route 53:

```text
Hosted Zone
    ↓
example.com
    ↓
Create Record
```

Create:

```text
Type: A
Name: @
Value: YOUR_ELASTIC_IP
```

For:

```text
www.example.com
```

you can create another A record:

```text
www → YOUR_ELASTIC_IP
```

Or use a CNAME depending on your DNS setup.

---

# 23. Use Elastic IP

Do not depend on the automatically assigned public IPv4 address for a production website.

Allocate:

```text
EC2 → Elastic IP
```

Associate it with your instance.

Then DNS points to:

```text
example.com
      ↓
Elastic IP
      ↓
EC2
```

---

# 24. Add HTTPS

Once HTTP is working, configure SSL.

Install Certbot packages appropriate to your RHEL release/repositories, then obtain a Let's Encrypt certificate.

The desired final architecture becomes:

```text
                 Internet
                    │
                    ▼
               HTTPS :443
                    │
                    ▼
                 NGINX
              SSL Termination
                    │
                    ▼
             Apache :8080
                    │
                    ▼
               Application
```

Nginx handles:

```text
SSL
HTTPS
HTTP → HTTPS
Reverse Proxy
Static files
Caching
Compression
```

Apache handles:

```text
Application
PHP
.htaccess
VirtualHost
```

---

# 25. HTTP → HTTPS Redirect

After SSL is configured, Nginx should have:

```nginx
server {
    listen 80;
    server_name example.com www.example.com;

    return 301 https://$host$request_uri;
}
```

And the HTTPS server:

```nginx
server {

    listen 443 ssl;
    server_name example.com www.example.com;

    ssl_certificate /path/to/fullchain.pem;
    ssl_certificate_key /path/to/privkey.pem;

    location / {

        proxy_pass http://127.0.0.1:8080;

        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

---

# 26. Website Deployment

Suppose your website is on your local PC:

```text
mywebsite/
├── index.html
├── css/
├── js/
├── images/
└── assets/
```

You can copy it to EC2 using SCP:

```bash
scp -i my-key.pem -r mywebsite/* ec2-user@YOUR_IP:/tmp/mywebsite/
```

Then on EC2:

```bash
sudo cp -r /tmp/mywebsite/* /var/www/mywebsite/
```

Fix permissions:

```bash
sudo chown -R apache:apache /var/www/mywebsite
```

Restore SELinux context:

```bash
sudo restorecon -Rv /var/www/mywebsite
```

---

# 27. If You Have a React Website

For React/Vite:

```bash
npm install
npm run build
```

You'll normally get:

```text
dist/
```

Upload the contents of `dist`:

```bash
scp -i my-key.pem -r dist/* ec2-user@YOUR_IP:/tmp/mywebsite/
```

Then:

```bash
sudo rm -rf /var/www/mywebsite/*
sudo cp -r /tmp/mywebsite/* /var/www/mywebsite/
```

Then:

```bash
sudo chown -R apache:apache /var/www/mywebsite
sudo restorecon -Rv /var/www/mywebsite
```

---

# 28. React SPA Routing

If React Router is being used, Apache needs to redirect unknown routes to `index.html`.

Create:

```bash
sudo vi /var/www/mywebsite/.htaccess
```

Add:

```apache
RewriteEngine On

RewriteBase /

RewriteCond %{REQUEST_FILENAME} !-f
RewriteCond %{REQUEST_FILENAME} !-d

RewriteRule ^ index.html [L]
```

And make sure:

```apache
AllowOverride All
```

exists in your VirtualHost.

Then:

```bash
sudo systemctl restart httpd
```

---

# 29. Logs — Extremely Important

### Nginx access log

```bash
sudo tail -f /var/log/nginx/access.log
```

### Nginx error log

```bash
sudo tail -f /var/log/nginx/error.log
```

### Apache access log

```bash
sudo tail -f /var/log/httpd/mywebsite_access.log
```

### Apache error log

```bash
sudo tail -f /var/log/httpd/mywebsite_error.log
```

### System logs

```bash
sudo journalctl -u nginx
```

```bash
sudo journalctl -u httpd
```

Live:

```bash
sudo journalctl -u nginx -f
```

---

# 30. Troubleshooting Flow

This is the most important practical part.

If website isn't working, don't randomly restart everything.

Follow this sequence.

### Step 1 — Is Apache running?

```bash
sudo systemctl status httpd
```

### Step 2 — Is Apache listening?

```bash
sudo ss -lntp | grep 8080
```

### Step 3 — Does Apache respond?

```bash
curl http://localhost:8080
```

If this fails → **Apache problem**.

---

### Step 4 — Is Nginx running?

```bash
sudo systemctl status nginx
```

### Step 5 — Is Nginx listening?

```bash
sudo ss -lntp | grep :80
```

### Step 6 — Does Nginx reach Apache?

```bash
curl http://127.0.0.1:8080
```

If Apache works but browser doesn't → check **Nginx / Security Group / DNS**.

---

# 31. Check Security Group

AWS:

```text
EC2
 ↓
Security
 ↓
Security Groups
 ↓
Inbound Rules
```

You need:

```text
22   SSH     My IP
80   HTTP    0.0.0.0/0
443  HTTPS   0.0.0.0/0
```

Don't add:

```text
8080 → 0.0.0.0/0
```

unless you have a specific reason.

---

# 32. Check RHEL Firewall

Check:

```bash
sudo firewall-cmd --state
```

If firewalld is active:

```bash
sudo firewall-cmd --permanent --add-service=http
```

For HTTPS:

```bash
sudo firewall-cmd --permanent --add-service=https
```

Reload:

```bash
sudo firewall-cmd --reload
```

Check:

```bash
sudo firewall-cmd --list-all
```

---

# 33. Common Errors

### 502 Bad Gateway

Usually:

```text
Nginx
   ↓
Apache
   X
```

Check:

```bash
sudo systemctl status httpd
```

```bash
curl http://127.0.0.1:8080
```

Also check:

```bash
sudo tail -f /var/log/nginx/error.log
```

---

### 403 Forbidden

Check:

```bash
ls -la /var/www/mywebsite
```

Permissions:

```bash
sudo chown -R apache:apache /var/www/mywebsite
```

SELinux:

```bash
sudo restorecon -Rv /var/www/mywebsite
```

---

### 404 Not Found

Check:

```bash
ls -la /var/www/mywebsite
```

Check Apache:

```bash
sudo cat /etc/httpd/conf.d/mywebsite.conf
```

---

### Nginx won't start

Run:

```bash
sudo nginx -t
```

Then:

```bash
sudo journalctl -u nginx -n 50
```

---

### Apache won't start

Run:

```bash
sudo apachectl configtest
```

Then:

```bash
sudo journalctl -u httpd -n 50
```

---

# 34. Useful Linux Commands for Your Demo

Since you're preparing for Linux/AWS training, these are worth practicing.

### CPU

```bash
top
```

or:

```bash
htop
```

### Memory

```bash
free -h
```

### Disk

```bash
df -h
```

### Directory size

```bash
du -sh /var/www/mywebsite
```

### Processes

```bash
ps aux
```

### Ports

```bash
ss -lntp
```

### Service

```bash
systemctl status nginx
systemctl status httpd
```

### Logs

```bash
journalctl -u nginx
journalctl -u httpd
```

### Network

```bash
ip addr
```

```bash
ip route
```

### DNS

```bash
dig example.com
```

### HTTP testing

```bash
curl -I http://example.com
```

---

# 35. Final Production Architecture

For your AWS/Linux training, remember this architecture:

```text
                       USERS
                         │
                         ▼
                  ┌─────────────┐
                  │   Route 53  │
                  │     DNS     │
                  └──────┬──────┘
                         │
                         ▼
                  ┌─────────────┐
                  │ Elastic IP  │
                  └──────┬──────┘
                         │
              ┌──────────┴──────────┐
              │       EC2 RHEL      │
              │                     │
              │   ┌─────────────┐   │
              │   │    NGINX    │   │
              │   │  :80/:443   │   │
              │   └──────┬──────┘   │
              │          │           │
              │      Reverse Proxy   │
              │          │           │
              │   ┌──────▼──────┐   │
              │   │   APACHE    │   │
              │   │    :8080    │   │
              │   └──────┬──────┘   │
              │          │           │
              │   /var/www/...      │
              │                     │
              └─────────────────────┘
```

### The deployment sequence to memorize

```text
1. Launch EC2
       ↓
2. Security Group
       ↓
3. SSH into RHEL
       ↓
4. dnf update
       ↓
5. Install Apache
       ↓
6. Apache → 8080
       ↓
7. Deploy website
       ↓
8. Configure VirtualHost
       ↓
9. Test Apache
       ↓
10. Install Nginx
       ↓
11. Nginx → 80/443
       ↓
12. Reverse Proxy → 8080
       ↓
13. DNS → Elastic IP
       ↓
14. HTTPS / SSL
       ↓
15. Test
       ↓
16. Monitor logs
