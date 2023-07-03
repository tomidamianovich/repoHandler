#! /usr/bin/bash

if [ ${#@} -ne 0 ] && [ "${@#"--help"}" = "" ]; then
  printf -- '...help...\n';
  exit 0;
fi;

_=$(command -v node);

if [ "$?" != "0" ]; then
  printf -- 'You dont seem to have Docker installed.\n';
  printf -- 'Get it: https://www.docker.com/community-edition\n';
  printf -- 'Exiting with code 127...\n';
  exit 127;
fi;

repositories_path=/home/tomas/repos/ui/;
repository_name=$1;

printf "\033c"

until [ "$repository_name" != "" ] && [ -d "${repositories_path}${repository_name}" ]
do
  echo -e "======== OPEN REPOSITORY ========"
  ls $repositories_path
  echo -e "======== Provide a valid repository name: ========"
  read repository_name
  if [ ! -d "${repositories_path}${repository_name}" ]; then
    echo -e "\n ======== Repository not found, provide one of the repositories available: ======== "
    ls $repositories_path
    echo -e "\n"
  else
    echo -e "\n\033[32mAbriendo repositorio $repository_name \033[0m\n"
  fi
done

cd ${repositories_path}${repository_name} && code -r .
exec bash
