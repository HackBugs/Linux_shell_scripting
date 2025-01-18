cd /home/monitor/alam
cur_time=`date '+%d-%m-%Y %H:%M'`
cpu_util=`top -b -n 1 | awk 'BEGIN { FS = ","} NR==3 { print $4 }' | awk '{print 100-$1}'`
mem_used=`free -h | awk 'NR==2 {print $3}'`
swap_used=`free -h | awk 'NR==3 {print $3}'`
Used_Backup_DB=`df -h | awk 'NR==9 {print $5 $6}'`
Used_Disk_Root=`df -h | awk 'NR==6 {print $5 $6}'`
echo $cur_time $cpu_util $mem_used $swap_used $Used_Backup_DB $Used_Disk_Root >> report.txt

