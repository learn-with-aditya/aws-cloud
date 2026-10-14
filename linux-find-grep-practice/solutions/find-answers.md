# Answer Key — `find`

Run from the repository root unless stated otherwise.

1. `find lab/sample-data -type f -name 'app.log'`
2. `find lab/sample-data -type f -name '*.log'`
3. `find lab/sample-data -type d`
4. `find lab/sample-data -type f -iname '*.log'`
5. `find lab/sample-data -type f -empty`
6. `find lab/sample-data -maxdepth 1 -type f`
7. `find lab/sample-data -type f -name '*.conf'`
8. `find lab/sample-data -type f -user "$USER"`
9. `find lab/sample-data -type f -name '*.log' | wc -l`
10. `find lab/sample-data -type f -name '*.log' -exec wc -l {} +`
11. `find lab/sample-data -type f \\( -name '*.txt' -o -name '*.log' \\)`
12. The unquoted wildcard can be expanded by the shell in the current directory before `find` receives it. Quote the pattern: `-name '*.log'`.

Expected outputs are paths or counts. Ordering may vary by filesystem; modification-time results depend on when files were created or edited.
