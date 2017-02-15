#! /bin/bash
# the next line will create a new file called formatted_eBird_data.csv
in_class_replace_newlines.sh eBird.csv
# the next line will replace all extra commas and will replace the contents of formatted_eBird_data.csv
sed 's/,\s/ /g' formatted_eBird_data.csv > formatted_eBird_data.csv
python does_something.py reformatted_eBird_data.csv
