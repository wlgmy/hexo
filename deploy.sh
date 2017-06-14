#!/bin/bash
useage()
{
  echo "Useage:sh `basename $0` deploy|pull|d|p|D|P"
}

if [ $# -ne 1 ]
then
  useage
  exit
fi
OPT=$1
case $OPT in
  deploy|Deploy|d|D)
  echo "deploy"
  hexo g
  hexo d
  git add . && git commit -m"a new deploy"
  ;;
  pull|Pull|p|P)
  echo "git pull"
  ;;
  *)
  useage
  ;;
esac
