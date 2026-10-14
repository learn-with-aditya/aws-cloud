# Exercise 1 — `find`

Run `bash lab/setup-lab.sh`, then `cd lab/sample-data`. Try each task before looking at the solutions.

1. Find the file named exactly `app.log`.
2. Find every regular file ending in `.log`.
3. Find every directory under the current directory.
4. Find `.log` files without case sensitivity.
5. Find the empty file.
6. List only files directly in the current directory (not nested files).
7. Find files ending in `.conf`.
8. Find files owned by your current user.
9. Count the number of `.log` files.
10. For every `.log` file, print its line count using `find` and `wc`.
11. Find `.txt` or `.log` files using grouped OR conditions.
12. Explain why `find . -name *.log` can behave differently from `find . -name '*.log'`.

For each command, explain the starting path, every test, and the expected kind of output.
