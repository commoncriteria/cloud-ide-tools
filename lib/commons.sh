#!/bin/bash

# THis file expects to be called with
#  . commons.sh
CLASSPATH=$MYDIR/bld
[ -d $CLASSPATH ] || mkdir -p $CLASSPATH

CLASSFILE=$CLASSPATH/snac/XSLTransform.class 
JAVAFILE=$MYDIR/src/snac/XSLTransform.java 
if [ ! -r $CLASSFILE ] || [ $JAVAFILE -nt $CLASSFILE ]; then
    javac -d $CLASSPATH $JAVAFILE
fi

DIR="${1%/*}"
if [ ${#DIR} == 0 ]; then
    DIR=.
fi
PYTHON3=python3
TRANSDIR=$DIR/../transforms
OUTDIR=$DIR/../output
STOMA=${1##*/}
STOMA=${STOMA%%.*}
BASES=/projects/bases/$STOMA

if [ -r $MYDIR/config.sh ]; then
  . $MYDIR/config.sh
fi  