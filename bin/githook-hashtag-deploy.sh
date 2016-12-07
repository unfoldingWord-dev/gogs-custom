#/bin/sh
########################################################################
#
# NAME githook-hashstag-deploy.sh - Place copy of update into hook dir
#
# DESCRIPTION Since "update" is a generic script, this deployment script
#      will not overwrite someone elses work.
#
########################################################################

opt=
over=no

while [ $# -gt 0 ] ; do
  case $1 in
    -d) opt="$opt -d" ; set -x ;;
    -o) opt="$opt -o" ; over=yes ;;
    -h) echo "Usage: $USAGE" ;;
    *)
      echo "Extra argument:" $1
      echo "Usage: $USAGE"
      exit 1
      ;;
  esac

  shift
done

. ./githook-hashtag.conf

del=" "

myLog() {
  echo $*
  dte=$(date +"%Y-%m-%d_%H:%M:%S")
  echo "$dte $*" >> $logFile/githook-hashtag-deploy.log
}

plural() {
  rep="s"

  if [ $1 -eq 1 ] ; then
    rep=""
  fi

  echo -n $rep
}


bmsql() {
  psql --dbname=$dbname --no-align --tuples-only --field-separator="$del" <<END
  $* ;
END
}

myLog  "Start: githook-hashstag-deploy.sh"
reps=$(mktemp /tmp/repos-XXXXXX)
bmsql "SELECT u.name, r.name FROM repository r join \"user\" u on u.id = r.owner_id  WHERE r.name LIKE '%-ubn%'" > $reps

lines=$(wc -l < $reps)
count=0

if [ $lines -lt 1 ] ; then
  myLog "Warning: No ubn repositories detected."
else 
  while read user repo ; do
    tgt=$repos/$user/${repo}.git/hooks

    if [ -f $tgt/update ] && [ $over = "no" ] ; then
      myLog "Warning: $tgt/update already exists. Will not overwrite."
    else 
      cp update $repos/$user/${repo}.git/hooks
      count=$(( count + 1 ))
    fi
  done < $reps
fi


myLog "Updated $count repo$(plural $count)"


if [ $count -ne $lines ] ; then
  dif=$(( $lines - $count ))

  myLog "Could not update $dif repo$(plural $dif)."
fi
 
sudo rm -f $reps

