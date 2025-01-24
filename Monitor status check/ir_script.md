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
