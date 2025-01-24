
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

