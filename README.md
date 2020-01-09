# Cloud IDE Tools
Tools to facilitate PP development on [Cloud IDEs](https://en.wikipedia.org/wiki/Online_integrated_development_environment).
Cloud IDEs that have been used are
* [codenvy](https://codenvy.com)
* [goorm](https://ide.goorm.io)

Any mention of these products should _not_ be interpreted as an endorsement.

# Makefiles
If you're using this to build projects with make
Throw this (or something similar) into LocalUser.make at the project directory root.

```Make
  FNL_PARM =release=final
  APP_PARM =appendicize=on
  XSL_EXE = java -cp /projects/codenvy-tools/bld snac.XSLTransform
  DOXSL = $(XSL_EXE) $2 $1 $3 $4
  DOIT ?= $(XSL_EXE) $(2) $(1) - $(4) | python3 $(TRANS)/post-process.py -\=$(3) 
  JING_JAR=/projects/jing-20181222/bin/jing.jar
