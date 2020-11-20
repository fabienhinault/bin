cat ~/bin/sqlf.bash
#!/bin/bash

if [ ! -e $1 ]
then
  mkdir -p $(dirname $1)
  vim $1
fi

psql "${DB_STRING}" -f $1
