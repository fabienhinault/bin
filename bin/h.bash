#!/bin/bash

FILE=${@: -1}
CHOSEN=$FILE
DATE=$(date --utc '+%Y-%m-%d_%H_%M_%S')

echo
cut -c -80 $FILE | head
echo
echo "u Utiliser $FILE"
echo "e Editer   $FILE"
echo "c Choisir un autre fichier"
read ANSWER

while [[ $ANSWER =~ 'c' ]]
do
    ls $FILE* | cat -n
    echo
    echo -n "Choisir le fichier numéro "
    read ANSWER
    CHOSEN=$(ls $FILE* | tail -n -$ANSWER | head -n 1)
    echo $CHOSEN
    echo
    cut -c -80 $CHOSEN | head
    echo
    echo "u Utiliser $CHOSEN"
    echo "e Editer   $CHOSEN"
    echo "c Choisir un autre fichier"
    read ANSWER
done
cp $FILE $FILE~$DATE
cp $CHOSEN $FILE
if [[ $ANSWER =~ 'e' ]]
then
  vim $FILE
  cp $FILE $FILE~$DATE
fi

$*
