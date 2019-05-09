#!/usr/bin/python3
# Telegram Data Export Analyzer with graph by Pouria Mousavizadeh
# import library
import matplotlib.pyplot as plt
from collections import Counter
from datetime import datetime
import argparse
import tkinter
import json
import re

json_string = None
date = re.compile('\d\d\d\d-\d\d-\d\d')

# Argument configurations
try:
	ArgParse = argparse.ArgumentParser()
	ArgParse.add_argument("-i", "--from_id", help="Telegram User ID.", type=int, required=True)
	ArgParse.add_argument("-f", "--file", help="Telegram JSON Export File", type=str, required=True)

except:
    print("Argument Function Failed!")
    sys.exit(1)

ARGS = ArgParse.parse_args()

# Start
if __name__ == '__main__':
    try:
        with open(ARGS.file) as telegram_data:
            json_string = telegram_data.read()
        parsed_json = json.loads(json_string)
    except Exception as e:
        print(repr(e))

    dates = []
    for chat_list in parsed_json['chats']['list']:
        if chat_list['type'] == 'personal_chat':
            for chat_list_messages in chat_list['messages']:
                try:
                    if chat_list_messages['from_id'] == ARGS.from_id:
                        dates.append(date.search(chat_list_messages['date']).group())
                except:
                    if chat_list_messages['actor_id'] == ARGS.from_id:
                        dates.append(date.search(chat_list_messages['date']).group())

    timestamps = [datetime.strptime(ts, "%Y-%m-%d") for ts in dates]
    timestamps.sort()
    sorteddates = [datetime.strftime(ts, "%Y-%m-%d") for ts in timestamps]
    duplicates_dates = Counter(sorteddates)
    plt.bar(range(len(duplicates_dates)), list(duplicates_dates.values()), align='center')
    plt.xticks(range(len(duplicates_dates)), list(duplicates_dates.keys()))
    plt.show()
