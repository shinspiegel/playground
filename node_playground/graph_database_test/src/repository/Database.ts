import neo4j from "neo4j-driver";
export const db = neo4j.driver("bolt://localhost:7687");
export default db.session({ defaultAccessMode: neo4j.session.WRITE });
