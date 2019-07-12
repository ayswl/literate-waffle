import csv
import json

csvfile = open("san.csv", "r")
jsonfile = open("san.json", "w")

fieldnames = ("id","date_created","date_last_modified","active_date","name","phone","resign_date","resign_reason","status","tipe","area","CONCAT('operator_',id)","modified_by","vehicle_type","helmet_qty","jacket_qty","vehicle_brand","vehicle_year","bike_type","first_ride_bonus_awarded","is_doc_completed")

reader = csv.DictReader(csvfile, fieldnames)
for row in reader:
    json.dump(row, jsonfile)
    jsonfile.write("\n")