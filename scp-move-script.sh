> ## Fist script but not working 

```
#!/bin/bash

# Define source, destination, and log file
SRC_DIR="/home/alam/.ssh/ssh-transfar-check/*"
DEST="root@192.168.1.124:/root/ssh-transfar-check-2"
LOG_FILE="/home/alam/scp_transfer.log"

# Run SCP and capture only transfer output
scp "$SRC_DIR" "$DEST" > "$LOG_FILE" 2>&1

# Display output in terminal as well
cat "$LOG_FILE"
```

> ## Secong script this is working

```
script -q -c "scp /home/alam/.ssh/ssh-transfar-check/* root@192.168.1.124:/root/ssh-transfar-check-2" > /home/alam/.ssh/ssh-transfar-check/test.txt
```

> ## Final script

```
#!/bin/bash

# Log file path
LOG_FILE="/home/alam/.ssh/ssh-transfar-check/transfar-scp-log.txt"

# Current Date and Time
cur_time=$(date '+%d-%m-%Y %H:%M')

# Append Date to Log File
echo -e "\n===== Transfer Log: $cur_time =====" >> "$LOG_FILE"

# Run SCP command and capture output
script -q -c "scp /home/alam/.ssh/ssh-transfar-check/* root@192.168.1.124:/root/ssh-transfar-check-2" >> "$LOG_FILE" 2>&1
```
