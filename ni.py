import argparse
import datetime as dt

ap = argparse.ArgumentParser()
ap.add_argument("-sd", "--startdate", required=False, help="-sd startdate")
ap.add_argument("-ed", "--enddate", required=False, help="-ed startdate")
args = vars(ap.parse_args())

def main(start_date, end_date):

    sql = 'script.sql'

    fd = open(sql, 'r')
    query = fd.read()
    fd.close()

    pquery = query.replace('{{start_date}}', "'" + start_date + "'")
    pquery = pquery.replace('{{end_date}}', "'" +  end_date + "'")

    # in reality there'd be an execute instead of print
    print(pquery)

yesterday = dt.datetime.today() - dt.timedelta(1)
today = dt.datetime.today()
yesterday_date = yesterday.strftime('%Y-%m-%d')
today_date = today.strftime('%Y-%m-%d')

if __name__ == '__main__':
    if args['startdate'] == None:
        main(yesterday_date,today_date)
    else:
        start_date = args['startdate']
        end_date = args['enddate']
        main(start_date,end_date)