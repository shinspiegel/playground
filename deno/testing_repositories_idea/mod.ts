import { QueryParam } from "./deps.ts";
import { Repository } from "./Repository.ts";

type Deck = { id?: number; name: string };
const deckMapper = (i: QueryParam[]) => ({ id: i[0], name: i[1] } as Deck);

const decksRepo = new Repository<Deck>({
    tableName: "decksRepo",
    mapper: deckMapper,
    fields: [
        { name: "id", type: "INTEGER PRIMARY KEY AUTOINCREMENT" },
        { name: "name", type: "TEXT" },
    ],
});

