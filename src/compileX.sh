#!/bin/bash
if [ $2  ] ; then
  if [ $2 = "-t" ] ; then
    echo "Only LaTeX"
    pdflatex $1
  elif [ $2 = "-b" ] ; then
    echo "Only bibTeX"
    bibtex $1
    NEXT=1
    FILE=$1$NEXT
    echo "Starting bibTeX compilation"
    while [ -a $FILE.aux ]; do
      echo "Compiling " $FILE
      bibtex $FILE              
      NEXT=$(($NEXT+1))
      FILE=$1$NEXT;
    done
    echo "Ending bibTeX compilation"
  elif [ $2 = "-a" ]; then
    pdflatex $1
    bibtex $1                   
    NEXT=1
    FILE=$1$NEXT
    echo "Starting bibTeX compilation"
    while [ -a $FILE.aux ]; do
      echo "Compiling " $FILE
      bibtex $FILE              
      NEXT=$(($NEXT+1))
      FILE=$1$NEXT;
    done
    echo "Ending bibTeX compilation"
    pdflatex $1
  fi
else
  pdflatex $1
fi