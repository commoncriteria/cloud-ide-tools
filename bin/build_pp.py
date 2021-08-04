#!/usr/bin/env python3
import sys
import os
import post_process

import lxml.etree as ET


if len(sys.argv) < 2:
    print("Usage: <input-file> [<output-file>]")
    sys.exit(0)

xml_path = sys.argv[1]
trans_path = os.path.dirname(sys.argv[1])+os.sep + ".." + os.sep + "transforms"
dom = ET.parse(xml_path)
if "{https://niap-ccevs.org/cc/v1}Module" == dom.getroot().tag:
    xsl_path = trans_path + os.sep + "xsl" + os.sep + "module2html.xsl"
else:
    xsl_path = trans_path + os.sep + "xsl" + os.sep + "pp2html.xsl"

xslt = ET.parse(xsl_path)
transform = ET.XSLT(xslt)
newdom = transform(dom)
uc_xml = ET.tostring(newdom, pretty_print=True)

if len(sys.argv) < 3:
    print(post_process.build_from_string(uc_xml))
else:
    with open(sys.argv[2], "wb+") as fout:
        fout.write(post_process.build_from_string(uc_xml))




