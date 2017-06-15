#!/bin/bash
useage()
{
  echo "Useage:sh `basename $0` deploy|d|D|pull|p|P|git|g|G"
}
push()
{
  echo "commit to git"
  git add . && git commit -m"a new git push"
  git push
}
pullToServer()
{
  echo "pull to server"
  cd /usr/share/nginx/hexo
  git pull
}
sshToServer(){
  echo "ssh to server"
  ssh root@112.124.11.214 'sh /usr/share/nginx/hexo/deploy.sh pull'
}

if [ $# -ne 1 ]
then
  useage
  exit
fi
OPT=$1
case $OPT in
  deploy|Deploy|d|D)
  echo "hexo clean"
  hexo c
  echo "hexo generage"
  hexo g
  echo "hexo deploy"
  hexo d
  push
  sshToServer
  ;;
  pull|Pull|p|P)
  pullToServer
  ;;
  git|g|G)
  push
  pullToServer
  ;;
  *)
  useage
  ;;
esac
