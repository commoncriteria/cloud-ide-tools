chmod u+x bin/*

PATH+=:$(pwd)/bin

[ -d bld ] || mkdir bld
javac -d bld $(find src -name '*.java')