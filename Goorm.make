FNL_PARM =release=final
APP_PARM =appendicize=on
XSL_EXE = java -cp /workspace/cloud-ide-tools/bld snac.XSLTransform
DOXSL = $(XSL_EXE) $2 $1 $3 $4
DOIT ?=  python3 $(TRANS)/post-process.py <($(XSL_EXE) $(2) $(1) - $(4) )\=$(3) 
JING_JAR=/workspace/jing-20181222/bin/jing.jar

