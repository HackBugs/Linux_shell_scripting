# Linux_Shell_Scripting

Study about these cmds
head, awk, echo 

search - unix cmd for dba

<hr>
First Create = shell scripting file 
Scripe_name.sh

Write your script in Scripe_name.sh file
Make a text file report.txt

<hr>
Make formate of your report.txt file
For Example - 

date       time  CPU MEM  SWAP  BKP_DB       Root_DB

<hr>

Use this CMD for crontab
crontab -e this cmd for set crontab
crontab -l this cmd use for check crontab edited

crontab -e 
*/15 * * * * sh /home/monitor/alam/capture_data.sh

crontab -l

<hr>

> ## Monitoring Shell Scripting for Linux

```
File 1 = capture_data.sh
file 2 = report.txt
```
<hr>

```
touch capture_data.sh 
touch report.txt
```
<hr>

## crontab 
```
* * * * * <command>
| | | | |
| | | | +---- Day of week (0 - 7) (Sunday = 0 or 7)
| | | +------ Month (1 - 12)
| | +-------- Day of month (1 - 31)
| +---------- Hour (0 - 23)
+------------ Minute (0 - 59)
```

```
vi capture_data.sh 
```
```sh
cd /home/monitor/log_monitor_data
cur_time=`date '+%d-%m-%Y %H:%M'`
## cpu_util=`top -b -n 1 | awk 'BEGIN { FS = ","} NR==3 { print $4 }' | awk '{print 100-$1}'`
cpu_util=`top -b -n 1 | awk 'NR==3 {print $2, $3}'`
mem_used=`free -h | awk 'NR==2 {print $3}'`
swap_used=`free -h | awk 'NR==3 {print $3}'`
Used_Backup_DB=`df -h | awk 'NR==9 {print $5 $6}'`
Used_Disk_Root=`df -h | awk 'NR==6 {print $5 $6}'`
echo $cur_time $cpu_util $mem_used $swap_used $Used_Backup_DB $Used_Disk_Root >> report.txt
```
<hr>

```
vi report.txt
```
date       time  CPU MEM  SWAP  BKP_DB       Root_DB

<hr>

### `nohup` command ensures the script keeps running even if the terminal is closed, and the & runs it in the background.
```
nohup /home/monitor/log_monitor_data/capture_data.sh &
```

```
crontab -e
*/15 * * * * sh /home/monitor/log_monitor_data/capture_data.sh 
```
```
crontab -l
```
<hr>

> ## Here is a comprehensive list of AWK functions categorized into their respective types:

### 1. **String Functions**
Functions for handling and manipulating strings:

- `length([string])` – Returns the length of the string.
- `substr(string, start, length)` – Extracts a substring.
- `index(string, search)` – Returns the position of `search` in `string`.
- `match(string, regex)` – Searches for a regex pattern in a string.
- `split(string, array, [delimiter])` – Splits a string into an array based on a delimiter.
- `toupper(string)` – Converts a string to uppercase.
- `tolower(string)` – Converts a string to lowercase.
- `gsub(regex, replacement, [target])` – Replaces all occurrences of `regex` with `replacement`.
- `sub(regex, replacement, [target])` – Replaces the first occurrence of `regex` with `replacement`.

### 2. **Numeric Functions**
Functions for mathematical calculations:

- `int(x)` – Truncates `x` to an integer.
- `sqrt(x)` – Returns the square root of `x`.
- `log(x)` – Returns the natural logarithm of `x`.
- `exp(x)` – Returns `e` raised to the power of `x`.
- `sin(x)` – Returns the sine of `x` (in radians).
- `cos(x)` – Returns the cosine of `x` (in radians).
- `atan2(y, x)` – Returns the arctangent of `y/x`.
- `rand()` – Generates a random number between 0 and 1.
- `srand([seed])` – Sets the seed for the random number generator.

### 3. **Time Functions**
Functions for working with time and dates:

- `strftime(format, [timestamp])` – Formats time based on `format`.
- `systime()` – Returns the current time as a timestamp (seconds since epoch).

### 4. **Array Functions**
Functions for managing associative arrays:

- `delete array[index]` – Deletes an element from an array.
- `isarray(x)` (GNU Awk) – Checks if `x` is an array.
- `asort(source, [destination])` (GNU Awk) – Sorts an array numerically or lexically.
- `asorti(source, [destination])` (GNU Awk) – Sorts an array by index.

### 5. **Input/Output Functions**
Functions for controlling I/O:

- `getline` – Reads a line from input.
- `getline var` – Reads a line into `var`.
- `close(file)` – Closes an open file or pipe.

### 6. **Conditional Functions**
Functions used for condition checking:

- `if (condition) { ... }` – Executes code if the condition is true.
- `while (condition) { ... }` – Loops while the condition is true.
- `for (i in array)` – Iterates over array elements.

---

### Examples

#### Using String Functions:
```bash
echo "Hello World" | awk '{ print toupper($0) }'
```
**Output**: `HELLO WORLD`

#### Using Numeric Functions:
```bash
echo | awk 'BEGIN { print sqrt(16) }'
```
**Output**: `4`

#### Using Time Functions:
```bash
echo | awk 'BEGIN { print strftime("%Y-%m-%d %H:%M:%S") }'
```
**Output**: `2025-01-18 14:45:30`

---
