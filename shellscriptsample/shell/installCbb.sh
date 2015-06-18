#!/bin/sh

usage(){
    echo "Usage: $0 filename"
    exit 1
}

is_file_exits(){
    local f="$1"
    [[ -f "$f" ]] && return 0 || return 1
}

is_dir_exits(){
    local f="$1"
    [[ -d "$f" ]] && return 0 || return 1
}

[[ $# -eq 0 ]] && usage

TAR=$1

DEL_HOME=$HOME/delivery
TMP=$DEL_HOME/tmp

cd $DEL_HOME

if ( is_file_exits "$TAR" )
then
 echo "make tmp dir."
 mkdir tmp
 echo "Extract files"
 tar -C tmp -xzf $TAR
else
 echo "$TAR not found."
 exit 1
fi

cd $CBP_HOME

if ( is_dir_exits "$TMP/app_home" )
then
 echo "del app_home"
 rm -rf app_home
 echo "install app_home"
 mv $TMP/app_home ./
 echo "app_home completed."
else
 echo "app_home skip"
fi

if (is_dir_exits "$TMP/webui" )
then
 echo "del webui."
 rm -rf webui
 echo "install webui"
 mv $TMP/webui ./
 cd webui/server
 ln -s ../../config/configjean.js config.js
 echo "webui completed"
else
 echo "webui skip"
fi

cd $DEL_HOME
echo "del tmp"ls


rm -rf tmp

echo "end."
