#!/bin/sh

USAGE="sh test.sh [-h] [-d] [-u <user>] [-r <repo>]
where
  -d        - debug Turn on sh tracing
  -h        - Help This text
  -o        - override write of update script
  -u <user> - owner of repo
  -r <repo> - name of ubn repo
"

. /etc/githook-hashtag.conf

myLog() {
  echo $*
  dte=$(date +s"%Y-%m-%d_%H:%M:%s")
  echo "$dte $*" >> $logFile
}


user=bms
repo=en-ubn-act
opt=

while [ $# -gt 0 ] ; do
  case $1 in
    -u) user=$2 ; shift ;;
    -r) repo=$2 ; shift ;;
    -d) opt="$opt -d" ;;
    -o) opt="$opt -o" ;;
    -h) echo "Usage: $USAGE" ;;
    *)
      echo "Extra argument:" $1
      echo "Usage: $USAGE"
      exit 1
      ;;
  esac

  shift
done


sh $appDir/githook-hashtag-deploy.sh $opt
sh $repos/$user/$repo.git/hooks/update $opt

