import neo4j from "https://dev.jspm.io/neo4j-driver";

const URI = "bolt://localhost:7687";

const driver = neo4j.driver(URI);

let session = driver.session();

const results = await session.run("MATCH (n:Node) RETURN n LIMIT 25");

console.log(results.records);

await session.close();
