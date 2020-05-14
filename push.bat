@echo off
set d=%date:~0,10%
set t=%time:~0,8%
set timestamp=%d% %t%
 
git status
git add .
git commit -m "%timestamp% backup by oo3"
git push origin master
echo "Finished Push!"
git log --stat -1
pause