## First try 

```
cd /mnt/c/course/bash_script/ir_mon
cur_time=`date '+d-%m-%Y %H:%M'`
hostname=`hostname  | awk 'NR==1'`
os_name=`lsb_release -a | awk 'NR==2 {print $2, $3}'`
ip_address=`ifconfig | awk 'NR==2 {print $1, $2}'`
cpu_util=`top -b -n 1 | awk 'NR==3 {print $2, $3}'`
mem_used=`free -h | awk 'NR==2 {print $1, $2, $3, $4}'`
swap_used=`free -h | awk 'NR==3 {print $1, $2, $3, $4}'`
uptime=`uptime | awk 'NR==1'`
db_size=`df -h | awk 'NR==6 {print $5}'`

echo $cur_time $hostname $os_name $ip_address $cpu_util $mem_used $swap_used $uptime $db_size >> task_monitor.txt
```

## Second try 

```
#!/bin/bash

# Directory change
cd /mnt/c/course/bash_script/ir_mon

# Check if the file already has headers
if [ ! -f task_monitor.txt ] || [ $(wc -l < task_monitor.txt) -eq 0 ]; then
    # Add headers if file is empty or doesn't exist
    echo "Timestamp Hostname OS_Name IP_Address CPU_Utilization Mem_Used Swap_Used Uptime DB_Size" > task_monitor.txt
fi

while true
do
    # Collecting data
    cur_time=$(date '+%d-%m-%Y %H:%M')
    hostname=$(hostname)
    os_name=$(lsb_release -a 2>/dev/null | awk 'NR==2 {print $2, $3}')
    ip_address=$(ifconfig | awk '/inet / && !/127.0.0.1/ {print $2}' | head -n 1)
    cpu_util=$(top -b -n 1 | awk 'NR==3 {print $2}')
    mem_used=$(free -h | awk 'NR==2 {print $3}')
    swap_used=$(free -h | awk 'NR==3 {print $3}')
    uptime=$(uptime -p)
    db_size=$(df -h | awk 'NR==6 {print $5}')

    # Appending data to the file
    echo "$cur_time $hostname $os_name $ip_address $cpu_util $mem_used $swap_used \"$uptime\" $db_size" >> task_monitor.txt

    # Wait for 5 seconds
    sleep 5
done

```

## Third try 

```
#!/bin/bash

# Directory change
cd /mnt/c/course/bash_script/ir_mon

# Check if the file already has headers
if [ ! -f task_monitor.txt ] || [ $(wc -l < task_monitor.txt) -eq 0 ]; then
    # Add headers if file is empty or doesn't exist
    printf "%-20s %-15s %-15s %-15s %-15s %-10s %-10s %-20s %-10s\n" \
    "Timestamp" "Hostname" "OS_Name" "IP_Address" "CPU_Utilization" "Mem_Used" "Swap_Used" "Uptime" "DB_Size" > task_monitor.txt
fi

while true
do
    # Collecting data
    cur_time=$(date '+%d-%m-%Y %H:%M')
    hostname=$(hostname)
    os_name=$(lsb_release -a 2>/dev/null | awk 'NR==2 {print $2, $3}')
    ip_address=$(ifconfig | awk '/inet / && !/127.0.0.1/ {print $2}' | head -n 1)
    cpu_util=$(top -b -n 1 | awk 'NR==3 {print $2}')
    mem_used=$(free -h | awk 'NR==2 {print $3}')
    swap_used=$(free -h | awk 'NR==3 {print $3}')
    uptime=$(uptime -p)
    db_size=$(df -h | awk 'NR==6 {print $5}')

    # Appending aligned data to the file
    printf "%-20s %-15s %-15s %-15s %-15s %-10s %-10s %-20s %-10s\n" \
    "$cur_time" "$hostname" "$os_name" "$ip_address" "$cpu_util" "$mem_used" "$swap_used" "$uptime" "$db_size" >> task_monitor.txt

    # Wait for 5 seconds
    sleep 5
done
```

> ## Line-by-Line Explanation of script 

#### 1. **`#!/bin/bash`**
- **Purpose**: Specifies the script should be run with the Bash shell.
- Without this line, the script might not execute correctly if another shell is used.

---

#### 2. **`cd /mnt/c/course/bash_script/ir_mon`**
- **Purpose**: Changes the current working directory to `/mnt/c/course/bash_script/ir_mon`.
- This ensures all file operations (like reading or writing `task_monitor.txt`) happen in this directory.

---

#### 3. **`if [ ! -f task_monitor.txt ] || [ $(wc -l < task_monitor.txt) -eq 0 ]; then`**
- **Purpose**: Checks two conditions:
  1. `! -f task_monitor.txt`: Checks if the file `task_monitor.txt` does not exist.
  2. `$(wc -l < task_monitor.txt) -eq 0`: Checks if the file exists but is empty (line count = 0).
- If either condition is true, the script creates the file with headers.

---

#### 4. **`printf` Command for Adding Headers**
```bash
printf "%-20s %-15s %-15s %-15s %-15s %-10s %-10s %-20s %-10s\n" \
"Timestamp" "Hostname" "OS_Name" "IP_Address" "CPU_Utilization" "Mem_Used" "Swap_Used" "Uptime" "DB_Size" > task_monitor.txt
```
- **Purpose**: Adds headers to the file if it's newly created or empty.
- **Explanation**:
  - `%` specifies formatting for each column.
  - `-` left-aligns the text.
  - Numbers like `20`, `15` define column widths for proper alignment.
  - `\n`: Ensures a new line after the headers.

---

#### 5. **`while true`**
- **Purpose**: Creates an infinite loop to repeatedly collect system metrics every 5 seconds.

---

#### 6. **`cur_time=$(date '+%d-%m-%Y %H:%M')`**
- **Purpose**: Captures the current date and time in the format `day-month-year hour:minute`.

---

#### 7. **`hostname=$(hostname)`**
- **Purpose**: Captures the system's hostname.

---

#### 8. **`os_name=$(lsb_release -a 2>/dev/null | awk 'NR==2 {print $2, $3}')`**
- **Purpose**: Captures the operating system name and version.
- **Explanation**:
  - `lsb_release -a`: Provides OS details.
  - `2>/dev/null`: Suppresses error messages if the command isn't found.
  - `awk 'NR==2 {print $2, $3}'`: Extracts the OS name (e.g., `Ubuntu 20.04`).

---

#### 9. **`ip_address=$(ifconfig | awk '/inet / && !/127.0.0.1/ {print $2}' | head -n 1)`**
- **Purpose**: Captures the system's IP address (excluding localhost `127.0.0.1`).
- **Explanation**:
  - `/inet / && !/127.0.0.1/`: Filters non-local IP addresses.
  - `head -n 1`: Selects the first valid IP address.

---

#### 10. **`cpu_util=$(top -b -n 1 | awk 'NR==3 {print $2}')`**
- **Purpose**: Captures CPU utilization from the `top` command.
- **Explanation**:
  - `-b`: Runs `top` in batch mode.
  - `-n 1`: Runs the command only once.
  - `awk 'NR==3 {print $2}'`: Extracts the second column from the third row of `top` output.

---

#### 11. **`mem_used=$(free -h | awk 'NR==2 {print $3}')`**
- **Purpose**: Captures the used memory from the `free` command.
- **Explanation**:
  - `free -h`: Displays memory usage in human-readable format.
  - `awk 'NR==2 {print $3}'`: Extracts the "used" column from the second row.

---

#### 12. **`swap_used=$(free -h | awk 'NR==3 {print $3}')`**
- **Purpose**: Captures the used swap memory using a similar approach to `mem_used`.

---

#### 13. **`uptime=$(uptime -p)`**
- **Purpose**: Captures the system uptime in a human-readable format.
- **Explanation**:
  - `uptime -p`: Displays uptime in a format like `up 2 hours, 5 minutes`.

---

#### 14. **`db_size=$(df -h | grep '/$' | awk '{print $5}')`**
- **Purpose**: Captures the disk usage of the root (`/`) partition.
- **Explanation**:
  - `df -h`: Shows disk usage in human-readable format.
  - `grep '/$'`: Filters the line for the root partition (`/`).
  - `awk '{print $5}'`: Extracts the percentage used (e.g., `30%`).

---

#### 15. **`printf` for Appending Data**
```bash
printf "%-20s %-15s %-15s %-15s %-15s %-10s %-10s %-20s %-10s\n" \
"$cur_time" "$hostname" "$os_name" "$ip_address" "$cpu_util" "$mem_used" "$swap_used" "$uptime" "$db_size" >> task_monitor.txt
```
- **Purpose**: Appends collected metrics to `task_monitor.txt`.
- **Explanation**:
  - Each variable is aligned according to column width specifications.
  - `>>`: Appends to the file without overwriting.

---

#### 16. **`sleep 5`**
- **Purpose**: Pauses the script for 5 seconds before the next iteration.

---

#### Key Output:
Each row in `task_monitor.txt` will look like this:
```
24-01-2025 12:00  my-host         Ubuntu 20.04    192.168.0.1     3.5%             1.2G      0B         up 1 hour, 23 mins   30%
```

# 😊

> ## `fi` ka use Bash scripting me ek **conditional block** ko close karne ke liye kiya jata hai. Iska matlab hota hai "if ka end." Jab hum `if` statement likhte hain, to uska end karne ke liye hamesha `fi` lagana zaroori hota hai.

### Code me `fi` kahan use ho raha hai?
```bash
if [ ! -f task_monitor.txt ] || [ $(wc -l < task_monitor.txt) -eq 0 ]; then
    # Headers ko add karte hain agar file empty ya nahi hai
    printf "%-20s %-15s %-15s %-15s %-15s %-10s %-10s %-20s %-10s\n" \
    "Timestamp" "Hostname" "OS_Name" "IP_Address" "CPU_Utilization" "Mem_Used" "Swap_Used" "Uptime" "DB_Size" > task_monitor.txt
fi
```

---

### `if` aur `fi` ka kaam kya hai?

1. **`if`**:
   - Yeh condition check karta hai.
   - Agar condition true hai, to uske andar ka code execute hota hai.

2. **`fi`**:
   - Yeh batata hai ki `if` statement yahan khatam ho gayi hai.
   - Iske bina script error dega.

---

### Iss code me `fi` kyu use kiya gaya?
- **Purpose**: 
  - Yeh check karta hai ki `task_monitor.txt` file exist karti hai ya nahi.
  - Agar file exist nahi karti ya khali hai, tab headers file me add honge.
  - Jab condition check khatam ho jaati hai, to uska closure karne ke liye `fi` lagaya gaya.

---

### Conditional Block ka Flow:
```bash
if [ condition ]; then
    # Yeh block tab chalega jab condition true ho
    echo "Condition true hai"
fi
```

Agar `fi` nahi lagayenge, to Bash interpreter confuse hoga ki `if` block ka end kahan hai, aur script error throw karegi.

---

### Ek Simple Example:

#### Without `fi`:
```bash
if [ 1 -eq 1 ]; then
    echo "Numbers are equal"
# Error: Syntax error, kyunki `fi` nahi diya
```

#### With `fi`:
```bash
if [ 1 -eq 1 ]; then
    echo "Numbers are equal"
fi
# Output: Numbers are equal
```

