## Data comming every second 

```
touch capture_data.sh
vi capture_data.sh
```

```
#!/bin/bash

# Define the directory and file where data will be stored
cd /mnt/c/course/bash_script/

# Infinite loop to save data every second
while true
do
    # Capture current time and CPU usage
    cur_time=`date '+%d-%m-%Y %H:%M:%S'`  # Include seconds in time format
    cpu_util=`top -b -n 1 | awk 'NR==8'`

    # Save the data to report.txt
    echo $cur_time $cpu_util >> report.txt

    # Sleep for 1 second before capturing the data again
    sleep 1
done
```

```
nohup /PATH/capture_data.sh &
```
### After running this scrit log file automatic will generate 

## Monitoring active , Inactive


```
touch monitor_file.sh
vi monitor_file.sh
```

```
#!/bin/bash

# Define the file to monitor and the log file
monitor_file="/mnt/c/course/bash_script/report.txt"
log_file="/mnt/c/course/bash_script/file_status.log"

# Store the last line count
last_line_count=0

# Infinite loop to monitor the file every second
while true
do
    # Get the current number of lines in the monitor file
    current_line_count=$(wc -l < "$monitor_file")

    # Check if a new line has been added
    if [ "$current_line_count" -gt "$last_line_count" ]; then
        # New line added, so the file is active
        echo "$(date '+%d-%m-%Y %H:%M:%S') ACTIVE" >> "$log_file"
    else
        # No new line added, so the file is inactive
        echo "$(date '+%d-%m-%Y %H:%M:%S') INACTIVE" >> "$log_file"
    fi

    # Update the last line count
    last_line_count=$current_line_count

    # Wait for 1 second before checking again
    sleep 5
done
```

### Run this script 
```
nohup /PATH/monitor_file.sh &
```

### After running this scrit log file automatic will generate 
