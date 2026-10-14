# Answer Key — `grep`

Run from `lab/sample-data` unless noted.

1. `grep 'ERROR' app.log`
2. `grep -i 'error' app.log`
3. `grep -n 'ERROR' app.log`
4. `grep -c 'ERROR' app.log` — expected count: `2`
5. `grep -v 'INFO' app.log`
6. `grep -rn 'ERROR' .`
7. `grep -E 'ERROR|WARN' app.log`
8. `grep -C 2 'ERROR' app.log`
9. `grep -w 'developer' users.txt`
10. `grep -l 'ERROR' ./*.log`
11. `grep -L 'CRITICAL' app.log error.log`
12. `grep -F '10.0.0.5' access.log`
13. `grep '^ERROR' error.log`
14. `grep 'READY$' status.txt`
15. No match normally returns status 1; an input or pattern error commonly returns status 2. Check the message and exit status.

Expected line order follows file order. Recursive output includes path and line number when `-n` is used.
