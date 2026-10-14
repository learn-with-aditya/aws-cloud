# Answer Key — Combined Challenges

1. From repository root:
   `find lab/sample-data -type f -name '*.log' -exec grep -nH 'ERROR' {} +`
2. `find lab/sample-data -type f -name 'nginx.conf' -exec grep -n 'error_log' {} \\;`
3. `grep -rn 'APP_PORT' lab/sample-data`
4. `find lab/sample-data -type f -name '*.tmp'`
5. `find lab/sample-data -type f -name '*.log' -exec grep -c 'WARN' {} +`
   Note: with multiple files, grep prints a count per file.
6. `grep -n -C 2 'Payment service timeout' lab/sample-data/app.log`
7. `grep -F '10.0.0.5' lab/sample-data/access.log`; `-F` treats dots as literal characters, not regex wildcards.
8. One possible approach:
   `find lab/sample-data -type f -name '*.log' -exec grep -nH -m 10 'ERROR' {} +`
   `-m 10` limits matches per file, not ten matches total across all files. To limit the combined stream to ten lines, pipe to `head -n 10`: `find ... -exec grep -nH 'ERROR' {} + | head -n 10`. Be aware that `head` may close the pipe early.
9. The shell is not in the data directory and `*.log` does not match files in a child directory. Use `cd lab/sample-data` or specify `lab/sample-data/*.log`.
10. System logs may be readable only by root or a privileged group. Begin with the lab directory and request authorized access when needed; do not automatically use `sudo`.
