#!/bin/env python3
import csv
import sys
import json
import os

if __name__ == "__main__":
    if len(sys.argv)<4:
        print("Usage: git-upload-csv-issues.py <token> <owner/repo> <csv-file> [--show-sources]")
        sys.exit(1)
    show_sources = len(sys.argv)==5 and sys.argv[4]=="--show-sources"


#./git-upload-csv-issues.py aaaaaaaaaaaaaaa "commoncriteria/pp-template" ~/Downloads/Untitled\ spreadsheet\ -\ Sheet1.csv 
    with open(sys.argv[3]) as csvfile:
        issuefile = csv.reader(csvfile)
        for row in issuefile:
            data={}
            data['title']="Feedback"
            data['body']=row[1]+": " + row[2] + ": " + row[4] + " Proposal: "+ row[5]
            if show_sources:
                data['labels']=[row[0].split("/")[0]]
            command = "curl -X POST "+\
                "-H \"Accept: application/vnd.github+json\" "          +\
                "-H \"Authorization: Bearer "+ sys.argv[1]+ "\" "      +\
                "https://api.github.com/repos/"+sys.argv[2]+"/issues " +\
                "-d '" + json.dumps(data) + "'"
            print(command)
            response = os.system(command)
            print(response)





# Row[0] author
# Row[1] place
# Row[2] subsection
# Row[3] type
# Row[4] comment
# Row[5] proposed change
            
#           print(row[2])
#            print(", ".join(row))
# import json

# data = {}
# data['key'] = 'value'
# json_data = json.dumps(data)
