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

initDate=$(date +"%Y-%m-%d_%H:%M:%S")
myLog "$initDate Install githook-hashtag."

sudo cp githook-hashtag.conf /etc
sudo cp githook-hashtag-deploy.sh $appDir

