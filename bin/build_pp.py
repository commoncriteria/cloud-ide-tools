#!/usr/bin/env python3
import subprocess
import sys
import os

import lxml.etree as ET

if len(sys.argv) < 2:
    print("Usage: <input-file>")
    sys.exit(0)

xml_path = sys.argv[1]
xsl_path = os.path.dirname(__file__)+os.sep+"xslt.py"
print(xsl_path)
trans_path = os.path.dirname(sys.argv[1])+os.sep + ".." + os.sep + "transforms"
xsl_path = trans_path + os.sep + "xsl" + os.sep + "pp2html.xsl"
dom = ET.parse(xml_path)
xslt = ET.parse(xsl_path)
transform = ET.XSLT(xslt)
newdom = transform(dom)
uc_xml = ET.tostring(newdom, pretty_print=True)
postprocess_path = trans_path + os.sep + "py" + os.sep + "post-process.py"


