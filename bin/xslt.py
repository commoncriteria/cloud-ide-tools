#!/usr/bin/env python3
import lxml.etree as ET
import sys

if len(sys.argv) < 4:
    print("usage: <xsl-file> <xml-file>  <out-file>\
        [<param1-name>=<param1-value> \
        [<param2-name>=<param2-value> [...]]]")
    sys.exit(0)
xsl_filename = sys.argv[1]
xml_filename = sys.argv[2]
out_filename = sys.argv[3]
print("I am here")


dom = ET.parse(xml_filename)
xslt = ET.parse(xsl_filename)
transform = ET.XSLT(xslt)
newdom = transform(dom)
print(ET.tostring(newdom, pretty_print=True))



