import { DB, QueryParam, Rows } from "./deps.ts";

type RepositoryOptions<T> = {
    tableName: string;
    mapper: (arr: QueryParam[]) => T;
    fields: Field[];
};

type Field = { name: string; type: string };

export class Repository<T extends { id?: number }> {
    private db = new DB("test.db");
    private tableName: String;
    private mapper: (arr: QueryParam[]) => T;

    constructor({ tableName, mapper, fields }: RepositoryOptions<T>) {
        this.tableName = tableName;
        this.mapper = mapper;

        this.createTable(fields);
    }

    public insertMultiple(items: T[]) {
        const result: T[] = [];

        items.forEach((item) => {
            const newItem = this.insertOne(item);
            result.push(newItem);
        });

        return result;
    }

    public insertOne(item: T) {
        delete item.id;

        const keys = Object.keys(item).join(", ");
        const markers = Object.keys(item)
            .map((_) => "?")
            .join(", ");
        const values = Object.values(item) as QueryParam[];
        const queryString = `INSERT INTO ${this.tableName} (${keys}) VALUES (${markers}) RETURNING *`;
        const rows = this.db.query(queryString, values);

        return this.applyMapper(rows)[0];
    }

    public update(item: T) {
        if (!item.id) {
            throw new Error("Empty id");
        }

        const values = Object.values(item) as QueryParam[];
        const entries = Object.entries(item)
            .map((i) => `${i[0]}=?`)
            .join(", ");

        const queryString = `UPDATE ${this.tableName} SET ${entries} WHERE id=${item.id}`;
        this.db.query(queryString, values);
    }

    public delete(item: Partial<T>) {
        if (!item.id) {
            throw new Error("Empty id");
        }

        const queryString = `DELETE FROM ${this.tableName} WHERE id=?`;
        this.db.query(queryString, [item.id]);
    }

    public get(item: Partial<T>) {
        const keys = Object.keys(item).map((i) => `${i}=?`);
        const values = Object.values(item);
        const queryString = `SELECT * FROM ${this.tableName} WHERE ${keys}`;
        const rows = this.db.query(queryString, values);

        return this.applyMapper(rows);
    }

    public getAll() {
        const queryString = `SELECT * FROM ${this.tableName}`;
        const rows = this.db.query(queryString);
        return this.applyMapper(rows);
    }

    private applyMapper(rows: Rows) {
        const result: T[] = [];

        for (const row of rows) {
            const mapped = this.mapper(row);
            result.push(mapped);
        }

        return result;
    }

    private createTable(fields: Field[]) {
        const tableFields = fields.map((i) => `${i.name} ${i.type}`).join(", ");
        const queryString = `CREATE TABLE IF NOT EXISTS ${this.tableName} (${tableFields})`;
        this.db.query(queryString);
    }
}
