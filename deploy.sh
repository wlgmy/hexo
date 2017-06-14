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
  echo "hexo generage"
  hexo g
  echo "hexo deploy"
  hexo d
  echo "commit to git"
  git add . && git commit -m"a new deploy"
  echo "push to git"
  git push
  echo "deploy to 112.124.11.214"
  ssh root@112.124.11.214 'sh /usr/share/nginx/hexo/deploy.sh pull'
  ;;
  pull|Pull|p|P)
  echo "git pull"
  cd /usr/share/nginx/hexo
  git pull
  ;;
  *)
  useage
  ;;
esac
