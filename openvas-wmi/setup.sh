#!/bin/bash
# Author : Code-machina (gbkim1988@gmail.com)
# Date : 2018-11-17(Nov 11, 2018)

# Change Logs 
# 11.17.2018 - Write Set-up scripts

# bash shell scripting usage

DEBUG=true

WMIDEPS="wmi-1.3.14-patched.7z"

showopts () {
  # see, https://www.ibm.com/developerworks/library/l-bash-parameters/index.html
  while getopts ":e:" optname
    do # start of while clause
      case "$optname" in # start of case clause
        "e")
          # This is an environmental variable, which are used
          # to pass compile constraints to gcc command :)
          echo "$OPTARG"
          ;;
        *)
          echo "Unknown Argument Error"
          ;;
      esac # end of case clause
    done # end of while clause
  return $OPTIND # OPTIND is special value, which stores the echoed string(not 100% sure).
} # showopts function ends

showargs () {
  for p in "$@"
    do
      case "$p" in
        "build")
          echo "$p"
          break
          ;;
      esac
    done
}

showhelps () {
  echo "Usage : setup.sh -e \"\{environment variables\}\" build"
  echo "This is for building openvas-wmi automatically :)"
}

getarchive () {
  if [ -f "$WMIDEPS" ]
  then
    echo "Already exists $WMIDEPS"
    return 0
  else 
    wget https://github.com/code-machina/awesome-packages/raw/master/openvas-wmi/wmi-1.3.14-patched.7z
  fi
}

setup-depends () {
  sudo apt-get install -qq p7zip-full -y
  sudo apt-get install -qq autoconf -y 
  sudo apt-get install -qq make gcc -y 
  sudo apt-get install -qq python -y
} 


optinfo=$(showopts "$@")
argstart=$?
arginfo=$(showargs "${@:$argstart}")

if [ $DEBUG = true ]
  then
  echo "Options are : "
  echo "$optinfo"
  echo "Arguments are : "
  echo "$arginfo"
fi

if [ ${#optinfo} -eq 0 ]
  then
  showhelps # call help function
  exit 1
fi

setup-depends
getarchive

if [ ! $? = "0" ] 
then
  echo "Error when downloading archive file"
fi

if [ ! -d "wmi-1.3.14" ] 
then
  sudo 7z x "$WMIDEPS"
fi

cd ./wmi-1.3.14

echo "make GNuMakeFile"
sudo make "$optinfo"


# test script