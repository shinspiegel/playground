import { Database } from "./database.ts";

const a = Database.query(`
  SELECT cards.name FROM users_cards
    JOIN cards ON cards.id = users_cards.card_id
    JOIN users ON users.id = users_cards.user_id
  WHERE 
    users_cards.user_id = 1
`);

console.log(a);

// Database.query(`
//   CREATE TABLE IF NOT EXISTS users (
//     id INTEGER PRIMARY KEY AUTOINCREMENT,
//     name TEXT
//   )
// `);

// Database.query(`
//   CREATE TABLE IF NOT EXISTS cards (
//     id INTEGER PRIMARY KEY AUTOINCREMENT,
//     name TEXT
//   )
// `);

// Database.query(`
//   CREATE TABLE IF NOT EXISTS users_cards (
//     id INTEGER PRIMARY KEY AUTOINCREMENT,
//     user_id INTEGER,
//     card_id INTEGER
//   )
// `);

// Database.query("INSERT INTO users (name) VALUES (?)", ["Shin"]);
// Database.query("INSERT INTO users (name) VALUES (?)", ["Non-Shin"]);

// Database.query("INSERT INTO cards (name) VALUES (?)", ["Attack"]);
// Database.query("INSERT INTO cards (name) VALUES (?)", ["Defense"]);
// Database.query("INSERT INTO cards (name) VALUES (?)", ["Dodge"]);

// Database.query("INSERT INTO users_cards (user_id, card_id) VALUES (?, ?)", [1, 1]);
// Database.query("INSERT INTO users_cards (user_id, card_id) VALUES (?, ?)", [1, 2]);
// Database.query("INSERT INTO users_cards (user_id, card_id) VALUES (?, ?)", [2, 2]);
// Database.query("INSERT INTO users_cards (user_id, card_id) VALUES (?, ?)", [2, 3]);
