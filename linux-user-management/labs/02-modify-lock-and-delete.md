# Lab 02 — Modify, Lock, Unlock, and Delete Users

> Run only in a disposable lab VM. Confirm each username before every destructive action.

## 1. Change the account comment

```bash
sudo usermod -c "Linux Student Account" labuser
getent passwd labuser
```

Expected: the fifth colon-separated field changes to `Linux Student Account`.

## 2. Change the login shell

```bash
sudo usermod -s /bin/bash labuser
getent passwd labuser
```

Expected: the final field shows `/bin/bash`.

To inspect available shells:

```bash
cat /etc/shells
```

Do not assign an arbitrary shell path without checking that it exists and is appropriate.

## 3. Lock and inspect

```bash
sudo usermod -L labuser
sudo passwd -S labuser
```

The status should indicate a locked password, although labels differ by version.

## 4. Unlock and inspect

```bash
sudo usermod -U labuser
sudo passwd -S labuser
```

Unlocking removes the password-lock marker; it does not set a password or guarantee the account can log in through every authentication method. Verify the password and account-expiration policy separately.

## 5. Require a password change at next password-based login

```bash
sudo chage -d 0 labuser
sudo chage -l labuser
```

Expected: the last password change is shown as requiring a change at next login, commonly represented as a date in the past or a special message.

## 6. Remove the account — two-stage check

First inspect:

```bash
id labuser
getent passwd labuser
ls -ld /home/labuser
```

If this is your disposable lab account and you no longer need it:

```bash
sudo userdel -r labuser
```

Expected output: normally none on success.

Verify:

```bash
getent passwd labuser
id labuser
test -e /home/labuser && echo "Home still exists" || echo "Home directory removed"
```

Notes:
- If the user is logged in or owns running processes, deletion may fail or require investigation.
- `userdel -r` does not guarantee that all files owned by the UID elsewhere on the server are removed.
- Do not delete real staff, service, or application accounts as a learning exercise.
