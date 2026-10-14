# Final Assignment — Application Support Investigation

## Scenario
A demo web application reports intermittent payment failures. You have been given a directory of logs and configuration files in `lab/sample-data`.

## Tasks
1. Find every log file in the sample tree.
2. Search all log files for `ERROR`, including filenames and line numbers.
3. Identify any `WARN` messages and count them per log file.
4. Search the access log for HTTP status `500` and `404`.
5. Find the application configuration and report the configured port.
6. Show context around the payment timeout.
7. Find temporary files.
8. Write a short incident summary: what failed, what evidence supports it, and what you would investigate next.
9. Submit your commands, expected output patterns, actual output, and explanations of all flags used.

## Assessment rubric (100 points)
- Correct `find` usage: 20
- Correct `grep` flags and patterns: 25
- Combined commands and filename/line context: 20
- Output interpretation: 20
- Safe working practices and clear explanation: 15
