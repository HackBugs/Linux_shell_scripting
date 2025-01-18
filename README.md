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

```
vi capture_data.sh 
```
```sh
cd /home/monitor/log_monitor_data
cur_time=`date '+%d-%m-%Y %H:%M'`
cpu_util=`top -b -n 1 | awk 'BEGIN { FS = ","} NR==3 { print $4 }' | awk '{print 100-$1}'`
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

```
crontab -e */15 * * * * sh hai/home/monitor/log_monitor_data/capture_data.sh
```
```
crontab -l
```

