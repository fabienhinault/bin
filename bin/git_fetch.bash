# crontab -e
#  0 *  *   *   *     for d in /home/fabien/projets/*/git/* ; do echo $d;  if [ $(git -C $d symbolic-ref --short HEAD | grep prj) ] ; then git -C $d pull --ff-only ; else git -C $d fetch ; fi  ; done

for d in /home/fabien/projets/*/git/*
do 
  GIT=git -C $d
  if [[ ! $($GIT rev-parse --abbrev-ref HEAD | grep prj) && -z "x$($GIT status --porcelain)" ]]
  then
    PRJ=$($GIT for-each-ref refs/heads/prj* --format '%(refname:short)')
    if [ -n $PRJ ]
    then
      $GIT checkout $PRJ
    fi
  fi
  if [ $($GIT symbolic-ref --short HEAD | grep prj) ]
  then 
    $GIT pull --ff-only
  else 
    $GIT fetch
  fi
done
