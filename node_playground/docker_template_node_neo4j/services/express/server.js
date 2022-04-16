import express from "express";
import neo4j from "neo4j-driver";

const app = express();
const db = neo4j.driver("bolt://neo:7687");

app.get("/", async (req, res) => {
  const result = await db
    .session({
      database: "neo4j",
      defaultAccessMode: neo4j.session.WRITE,
    })
    .run("Match(p:Person) Where p.name='Alex Merced' Return p;");
  res.json(await result);
});

app.listen(5000, () => console.log("listening on 5000"));
