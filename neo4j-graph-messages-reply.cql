// Import Reply Messages as Nodes and Its Relationship to Their Contacts and Messages

CALL apoc.load.json("file:///result.json") YIELD value AS row
UNWIND row.chats.list as Chats
UNWIND Chats.messages as Msg
WITH Msg
WHERE keys(Msg) = ["date", "from_id", "from", "id", "reply_to_message_id", "text", "type"] AND apoc.meta.type(Msg.text) = "STRING"
CREATE (Telegram_msg_reply:Messages)
SET Telegram_msg_reply = Msg
WITH Telegram_msg_reply
MATCH (user:Person), (Telegram_msg:Messages)
WHERE user.id = Telegram_msg_reply.from_id AND Telegram_msg.id = Telegram_msg_reply.reply_to_message_id
MERGE (user)-[:SEND]->(Telegram_msg_reply)
MERGE (Telegram_msg_reply)-[:REPLY]->(Telegram_msg)
RETURN user, Telegram_msg, Telegram_msg_reply

// Old Data Form 
CALL apoc.load.json("file:///result.json") YIELD value AS row
UNWIND row.chats.list as Chats
UNWIND Chats.messages as Msg
WITH Msg
WHERE keys(Msg) = ["date", "from_id", "edited", "from", "id", "reply_to_message_id", "text", "type"] AND apoc.meta.type(Msg.text) = "STRING"
CREATE (Telegram_msg_reply:Messages)
SET Telegram_msg_reply = Msg
WITH Telegram_msg_reply
MATCH (user:Person), (Telegram_msg:Messages)
WHERE user.name = Telegram_msg_reply.from AND Telegram_msg.id = Telegram_msg_reply.reply_to_message_id
MERGE (user)-[:SEND]->(Telegram_msg_reply)
MERGE (Telegram_msg_reply)-[:REPLY]->(Telegram_msg)
RETURN user, Telegram_msg, Telegram_msg_reply
