#!/usr/bin/env bash

function create() {
  vagrant up --no-provision
  vagrant snapshot save init
  vagrant up --provision
}

case $1 in
  up )
    create
    ;;
  rebuild )
    vagrant destroy -f
    create
    ;;
  restore )
    vagrant restore init
    vagrant up --provision
    ;;
  down )
    vagrant destroy -f
    ;;
  * )
    echo "Usage: up|rebuild|down"
esac
