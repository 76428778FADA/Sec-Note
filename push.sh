time=`date "+%Y-%m-%d_%H-%M-%S"`

git status 
git add .
git commit -m "${time} backup from oo3_macos"
git push origin master
echo "Finished Push!"