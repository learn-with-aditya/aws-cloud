# 4. `grep` Patterns and Regular Expressions

Regular expressions (regex) describe text patterns. With `grep`, many symbols have special meaning.

## Anchors and character classes

| Pattern | Meaning | Example |
|---|---|---|
| `^ERROR` | Line starts with `ERROR` | `grep '^ERROR' app.log` |
| `READY$` | Line ends with `READY` | `grep 'READY$' status.txt` |
| `^$` | Empty line | `grep -n '^$' app.log` |
| `.` | Any one character | `grep '10.0.0.5' access.log` (dot is wildcard here) |
| `[0-9]` | One digit | `grep -E '[0-9]{3}' access.log` |
| `[A-Z]` | One uppercase letter in the current locale | `grep -E '[A-Z]+' users.txt` |
| `ERROR|WARN` with `-E` | ERROR or WARN | `grep -E 'ERROR|WARN' app.log` |
| `[Ee]rror` | Error or error | `grep '[Ee]rror' app.log` |
| `*` | Zero or more of the preceding regex item | `grep -E 'WARN.*timeout' app.log` |

## Literal special characters
To search for a literal dot, escape it:
```bash
grep '10\.0\.0\.5' access.log
```
With `grep -F`, the pattern is treated as fixed text rather than regex:
```bash
grep -F '10.0.0.5' access.log
```

## Examples
```bash
grep '^2026' app.log
grep -E 'ERROR|WARN' app.log
grep -E 'user[0-9]+' users.txt
grep -F 'server started.' app.log
```

## Beginner warning
Basic regular expressions and extended regular expressions have different rules. `grep -E` enables extended syntax, including `|`, `+`, `?`, and `{}` without the same escaping required in basic mode.
