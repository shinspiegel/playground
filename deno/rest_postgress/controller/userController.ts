import { RouterContext } from "https://deno.land/x/oak/mod.ts";
import { QueryResult } from "https://deno.land/x/postgres/query.ts";
import { query, generateJson } from "../database/database.ts";
import userModel from "../models/userModel.ts";

interface IBodyResponse<D> {
  total: number;
  docs: D[];
}

async function index({ response, params }: RouterContext) {
  try {
    let result: QueryResult;

    if (params.id) {
      result = await query(
        "SELECT * FROM denoUsers WHERE id = $1;",
        [params.id],
      ).catch((e) => {
        throw new Error(e);
      });
    } else {
      result = await query("SELECT * FROM denoUsers WHERE isActive = 'true';")
        .catch((e) => {
          throw new Error(e);
        });
    }

    const columnsList = result.rowDescription.columns;
    const rowsList = result.rows;
    const userList = generateJson(rowsList, columnsList);

    const body: IBodyResponse<userModel> = {
      total: userList.length,
      docs: userList,
    };

    response.status = 200;
    response.body = body;
  } catch (e) {
    console.log(e);
    response.status = 500;
    response.body = "Something went wrong";
  }
}

async function create({ request, response }: RouterContext) {
  try {
    const { value } = await request.body();
    const { name, email }: userModel = value;

    // RETURNING id
    const result = await query(
      "INSERT INTO denoUsers (name, email) VALUES ($1, $2) RETURNING *;",
      [name, email],
    ).catch((e) => {
      throw new Error(e);
    });

    const columnsList = result.rowDescription.columns;
    const rowsList = result.rows;
    const userList = generateJson(rowsList, columnsList);

    const body: IBodyResponse<userModel> = {
      total: userList.length,
      docs: userList,
    };

    response.status = 201;
    response.body = body;
  } catch (e) {
    console.log(e);
    response.status = 500;
    response.body = "Something went wrong";
  }
}

async function update({ request, response, params }: RouterContext) {
  try {
    if (!params.id) throw new Error("Missing param");

    const { value } = await request.body();
    const { name, email }: userModel = value;
    if (!name || !email) throw new Error("Invalid body");

    const result = await query(
      "UPDATE denoUsers SET name = $1, email = $2 WHERE id = $3 RETURNING *;",
      [name, email, params.id],
    ).catch((e) => {
      throw new Error(e);
    });

    const columnsList = result.rowDescription.columns;
    const rowsList = result.rows;
    const userList = generateJson(rowsList, columnsList);

    const body: IBodyResponse<userModel> = {
      total: userList.length,
      docs: userList,
    };

    response.status = 200;
    response.body = body;
  } catch (e) {
    console.log(e);
    response.status = 500;
    response.body = "Something went wrong";
  }
}

async function destroy({ response, params }: RouterContext) {
  try {
    if (!params.id) throw new Error("Missing param");

    const result = await query(
      "UPDATE denoUsers SET isActive = $1 WHERE id = $2 RETURNING *;",
      [false, params.id],
    ).catch((e) => {
      throw new Error(e);
    });

    const columnsList = result.rowDescription.columns;
    const rowsList = result.rows;
    const userList = generateJson(rowsList, columnsList);

    const body: IBodyResponse<userModel> = {
      total: userList.length,
      docs: userList,
    };

    response.status = 200;
    response.body = body;
  } catch (e) {
    console.log(e);
    response.status = 500;
    response.body = "Something went wrong";
  }
}

export default { index, create, update, destroy };
