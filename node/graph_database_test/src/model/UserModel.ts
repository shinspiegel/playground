import { Model } from "./Model";

export default class User extends Model {
  id: string = "";
  name: string = "";
  email: string = "";
  password: string = "";
}
