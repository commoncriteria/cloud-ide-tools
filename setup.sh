if [ "$BASH_SOURCE" = "" ] ; then
    echo "This file should be sourced (or sourced with '. $1' shorthand)"
    echo "and not executed or invoked with as an argument to a script."
    exit 0
fi

if [ "$HOSTNAME" == "goorm" ]; then
    echo "Detected goormide"
    MYDIR=/workspace
    export LANG=C
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

PS1='#\[\033[01;34m\]\w\[\033[00m\]$(parse_git_branch)\n\$ '
JING_URL=https://github.com/relaxng/jing-trang/releases/download/V20181222/jing-20181222.zip
if [ ! -d $MYDIR/jing-20181222 ]; then
  cd $MYDIR && wget -q -O- $JING_URL | jar -xv
fi

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
function update-transforms(){
  cd transforms &&\
  git pull &&\
  cd .. &&\
  make &&\
  git add transforms &&\
  git commit -m "Updated transforms" &&\
  git push

}


popd
