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
