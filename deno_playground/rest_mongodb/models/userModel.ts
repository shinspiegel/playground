interface IUserModel {
  _id?: { $oid: string };
  name: string;
  email: string;
  isActive: boolean;
}

export default IUserModel;
