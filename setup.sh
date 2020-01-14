if [ "$BASH_SOURCE" = "" ] ; then
    echo "This file should be sourced (or sourced with '. $1' shorthand)"
    echo "and not executed or invoked with as an argument to a script."
    exit 0
fi

if [ "$HOSTNAME" == "goorm" ]; then
    echo "Detected goormide"
    MYDIR=/workspace
else
    MYDIR=/projects
fi

if [ "${BASH_SOURCE}" = "${BASH_SOURCE%/*}" ]; then
    pushd .
else
    pushd ${BASH_SOURCE%/*}
fi

chmod u+x bin/*
PATH+=:$(pwd)/bin

[ -d bld ] || mkdir bld
javac -d bld $(find src -name '*.java')

for aa in $MYDIR/*/transforms; do
    cd "$aa" && git submodule update --init --recursive && cd -
done

PS1='##\w\n\$ '
JING_URL=https://github.com/relaxng/jing-trang/releases/download/V20181222/jing-20181222.zip
cd $MYDIR && wget -q -O- $JING_URL | jar -xv

export LANG=C

function git-clone(){
  if [ $# == 0 ]; then
    echo "Usage: git-clone <cc-project>"
    return 0
  fi
  if [ -r ~/.ssh/id_rsa ]; then
    git clone --recursive git@github.com:commoncriteria/$1
  else
    git clone --recursive https://github.com/commoncriteria/$1
  fi
}     



popd
