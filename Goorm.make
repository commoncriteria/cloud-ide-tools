FNL_PARM =release=final
APP_PARM =appendicize=on
XSL_EXE = java -cp /workspace/codenvy-tools/bld snac.XSLTransform
DOXSL = $(XSL_EXE) $2 $1 $3 $4
DOIT ?= $(XSL_EXE) $(2) $(1) - $(4) | python3 $(TRANS)/post-process.py -\=$(3) 
JING_JAR=/workspace/jing-20181222/bin/jing.jar

