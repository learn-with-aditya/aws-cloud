# 5. Troubleshooting Scenarios

## Scenario A: Application is failing
```bash
find . -type f -name '*.log'
grep -n -i 'error' app.log
grep -n -E 'ERROR|WARN|CRITICAL' app.log
```
Interpret the timestamp and message before deciding what to fix.

## Scenario B: Find where a setting is configured
```bash
grep -rn 'PORT=' .
```
Use only inside the practice repository. Avoid searching the entire filesystem for secrets.

## Scenario C: Find a user's record
```bash
grep -n -i 'shankar' users.txt
```

## Scenario D: Find log files, then search them
```bash
find . -type f -name '*.log' -exec grep -nH 'ERROR' {} +
```
- `-exec ... {} +` passes as many matched paths as practical to one command invocation.
- `-H` forces filename display, including when one file is passed.
- If no matching lines exist, `grep` prints nothing.

## Scenario E: Permissions
If `grep` or `find` reports `Permission denied`, you may not have permission to read or traverse that location. Start with the lab folder. Do not automatically add `sudo`.

## Scenario F: No output
Check:
1. Are you in the expected directory? Run `pwd`.
2. Does the file exist? Run `ls -l filename`.
3. Is spelling and case correct?
4. Does the pattern mean what you think it means?
5. Is the pattern interpreted as a regex? Try `grep -F` for literal text.

## Scenario G: Large log files
```bash
grep -n -m 20 'ERROR' app.log
grep -n -C 1 'timeout' app.log
```
Limit output while investigating. Avoid dumping large production logs into shared terminals or public repositories.
