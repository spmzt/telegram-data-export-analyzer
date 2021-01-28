// Import Messages as Nodes and Its Relationship to Their Contacts

CALL apoc.load.json("file:///result.json") YIELD value AS row
UNWIND row.chats.list as Chats
UNWIND Chats.messages as Msg
WITH Msg
WHERE keys(Msg) = ["date","from_id","from","id","text","type"] AND apoc.meta.type(Msg.text) = "STRING"
CREATE (Telegram_msg:Messages)
SET Telegram_msg = Msg
WITH Telegram_msg
MATCH (user:Person)
WHERE user.id = Telegram_msg.from_id
MERGE (user)-[:SEND]->(Telegram_msg)
RETURN user, Telegram_msg

// Old Data Form

CALL apoc.load.json("file:///result.json") YIELD value AS row
UNWIND row.chats.list as Chats
UNWIND Chats.messages as Msg
WITH Msg
WHERE keys(Msg) = ["date", "from_id", "edited", "from", "id", "text", "type"] AND apoc.meta.type(Msg.text) = "STRING"
CREATE (Telegram_msg:Messages)
SET Telegram_msg = Msg
WITH Telegram_msg
MATCH (user:Person)
WHERE user.name = Telegram_msg.from
MERGE (user)-[:SEND]->(Telegram_msg)
RETURN user, Telegram_msg
