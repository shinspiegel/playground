export const initialAccess = {
  isLogged: false,
  loggedUser: null,
  token: null,
};

const initialState = {
  isLoading: false,
  access: initialAccess,
  companies: [],
  products: [],
};

export default initialState;
