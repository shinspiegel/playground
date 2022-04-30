import { RouterContext } from "https://deno.land/x/oak/mod.ts";
import { Users } from "../database/database.ts";
import userModel from "../models/userModel.ts";

interface IBodyResponse<D> {
  total: number;
  docs: D[];
}

async function index({ response, params }: RouterContext) {
  let userList: userModel[];

  if (params.id) {
    userList = await Users.find({ _id: { $oid: params.id }, isActive: true });
  } else {
    userList = await Users.find({ isActive: true });
  }

  const body: IBodyResponse<userModel> = {
    total: userList.length,
    docs: userList,
  };

  response.status = 200;
  response.body = body;
}

async function create({ request, response }: RouterContext) {
  const { value } = await request.body();
  const { name, email }: userModel = value;

  const { $oid } = await Users.insertOne({ name, email, isActive: true });
  const userList: userModel[] = [
    { _id: { $oid }, name, email, isActive: true },
  ];

  const body: IBodyResponse<userModel> = {
    total: userList.length,
    docs: userList,
  };

  response.status = 201;
  response.body = body;
}

async function update({ request, response, params }: RouterContext) {
  if (!params.id) return;

  const { value } = await request.body();
  const { name, email }: userModel = value;

  await Users.updateOne(
    { _id: { $oid: params.id } },
    { $set: { name, email, isActive: true } },
  );

  const userList: userModel[] = [
    { _id: { $oid: params.id }, name, email, isActive: true },
  ];
  const body: IBodyResponse<userModel> = {
    total: userList.length,
    docs: userList,
  };

  response.status = 200;
  response.body = body;
}

async function destroy({ response, params }: RouterContext) {
  if (!params.id) return;

  await Users.updateOne(
    { _id: { $oid: params.id } },
    { $set: { isActive: false } },
  );

  response.status = 204;
}

export default { index, create, update, destroy };
