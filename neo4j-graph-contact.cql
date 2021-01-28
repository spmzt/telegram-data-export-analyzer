// Import Contacts as Nodes and their relationships

CALL apoc.load.json("file:///result.json") YIELD value AS row
UNWIND row.frequent_contacts.list as Contacts
UNWIND row.personal_information as Me
CREATE (user:Person)
SET user = Contacts
WITH user, Me
MATCH (me:Person {id: 1234567899}), (user:Person)
WHERE NOT user.id = me.id
SET me = Me
SET me.id = 1234567899
CREATE (me)-[:CONTACT]->(user)
RETURN me, user
