#!/usr/bin/env python3
import sys
import os
import post_process
import retrieve_included_docs
import lxml.etree as ET
in_path=""
work_path = "output"
out_path = "-"
trans_path = ""
for arg in sys.argv[1:]:
    if arg.startswith("-t"):
        trans_path = arg[3:]
    elif arg.startswith("-w"):
        work_path = arg[3:]
    elif in_path=="":
        in_path = arg
    else:
        out_path=arg
if trans_path == "":
    trans_path = os.path.dirname(in_path)+os.sep + ".." + os.sep + "transforms"

if in_path=="":
    print("Usage: [-w=<path-to-workdir>] [-t=<path-to-transforms>] <input-file> [<output-file>]")
    sys.exit(0)

print("Setting in_path to " + arg)
dom = ET.parse(in_path)
if "{https://niap-ccevs.org/cc/v1}Module" == dom.getroot().tag:
    xsl_path = trans_path + os.sep + "xsl" + os.sep + "module2html.xsl"
else:
    xsl_path = trans_path + os.sep + "xsl" + os.sep + "pp2html.xsl"
retrieve_included_docs.get_dependencies(dom.getroot(), work_path)

xslt = ET.parse(xsl_path)
transform = ET.XSLT(xslt)
newdom = transform(dom, work_dir=ET.XSLT.strparam(work_path))
uc_xml = ET.tostring(newdom, pretty_print=True)

if out_path == "-":
    print(post_process.build_from_string(uc_xml))
else:
    with open(out_path, "wb+") as fout:
        fout.write(post_process.build_from_string(uc_xml))
