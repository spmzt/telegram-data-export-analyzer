# telegram data export analyzer
some tools to analyze your data from telegram

# telegramexport-graph.py

usage:

```bash
$ python3.7 telegramexport.py -h
usage: telegramexport.py [-h] -i FROM_ID -f FILE

optional arguments:
  -h, --help            show this help message and exit
  -i FROM_ID, --from_id FROM_ID
                        Telegram User ID.
  -f FILE, --file FILE  Telegram JSON Export File 
```

example:

```bash
$ python3.7 telegramexport.py -i 1234 -f /home/user/Downloads/Telegram\ Desktop/DataExport_01_01_2019/result.json
```

# Neo4j

```
MATCH (user:Person), (Telegram_msg:Messages), (Telegram_msg_reply:Messages)
RETURN user, Telegram_msg, Telegram_msg_reply
```
