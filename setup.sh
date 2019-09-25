if [ "$BASH_SOURCE" = "" ] ; then
    echo "This file should be sourced (or sourced with '. $1' shorthand)"
    echo "and not executed or invoked with as an argument to a script."
    exit 0
fi

if [ "${BASH_SOURCE}" = "${BASH_SOURCE%%/*}" ]; then
    pushd .
else
    cd ${BASH_SOURCE%%/*}
fi

chmod u+x bin/*
PATH+=:$(pwd)/bin

[ -d bld ] || mkdir bld
javac -d bld $(find src -name '*.java')

popd
