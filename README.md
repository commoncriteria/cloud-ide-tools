# codenvy-tools
Tools to facilitate PP development on codenvy

# Makefiles
If you're using this to build projects with make
Throw this (or something similar) into LocalUser.make at the project directory root.

```Make
  FNL_PARM =release=final
  APP_PARM =appendicize=on
  XSL_EXE = java -cp /projects/codenvy-tools/bld snac.XSLTransform
  DOXSL = $(XSL_EXE) $2 $1 $3 $4
  DOIT ?= $(XSL_EXE) $(2) $(1) - $(4) | python3 $(TRANS)/post-process.py -\=$(3) 

