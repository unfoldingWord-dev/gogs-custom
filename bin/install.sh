#/bin/sh
#################################################################
#
# Put parts in right places
#
#################################################################

. ./githook-hashtag.conf

myLog() {
  echo $*
  dte=$(date +s"%Y-%m-%d_%H:%M:%s")
  echo "$dte $*" >> $logFile
}

myLog "Install githook-hashtag."

sudo cp githook-hashtag.conf /etc
sudo cp githook-hashtag-deploy.sh $appDir

