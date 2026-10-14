# Exercise 3 — Combined Challenges

Use only `lab/sample-data`.

1. Find all `.log` files and search them for `ERROR`, showing line numbers and filenames.
2. Find the configuration file `nginx.conf`, then search it for `error_log`.
3. Search all files recursively for the setting `APP_PORT`.
4. Find files ending in `.tmp`.
5. Print the number of lines containing `WARN` in each `.log` file.
6. Find `ERROR` entries in `app.log` and show two lines of context.
7. Search for the literal IP address `10.0.0.5`; explain why `grep -F` is appropriate.
8. Create a command that finds `.log` files but limits output to the first 10 matching lines overall. Explain any limitation of your approach.
9. A student runs `grep ERROR *.log` from the repository root and gets “No such file or directory.” Explain and fix the working-directory issue.
10. Explain why searching `/var/log` as a normal user can return permission errors.
