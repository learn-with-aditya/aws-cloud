# Lab 03 — ACL Mask and Removal

Use only files in `~/acl-lab`.

## Step 1 — Create a file and named ACL
```bash
cd ~/acl-lab
printf 'ACL mask experiment\n' > mask-demo.txt
chmod 640 mask-demo.txt
setfacl -m u:anita:rwx mask-demo.txt
getfacl -e mask-demo.txt
```

Ensure `anita` exists before using the name. The resulting mask may be adjusted automatically when ACL entries change; inspect actual output rather than assuming a fixed mask.

## Step 2 — Restrict the mask
```bash
setfacl -m m::r-- mask-demo.txt
getfacl -e mask-demo.txt
```

Observe how the effective permissions for named-user/group entries and the owning group are limited by the mask.

## Step 3 — Widen the mask
```bash
setfacl -m m::rw- mask-demo.txt
getfacl -e mask-demo.txt
```

The named user's stored entry may still say `rwx`, but the mask limits effective permissions to read/write.

## Step 4 — Remove a single entry
```bash
setfacl -x u:anita mask-demo.txt
getfacl mask-demo.txt
```

## Step 5 — Remove all extended ACL entries (lab file only)
```bash
setfacl -b mask-demo.txt
getfacl mask-demo.txt
```

`-b` removes extended ACL entries. Use it only when you intend to discard those entries.

## Reflection
- Why can the stored entry and effective permission differ?
- What does the mask limit?
- Why is `setfacl -b` more destructive than removing one entry?
