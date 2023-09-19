export const cases = {
  setLoading: "SET_LOADING",
  setLoggedUser: "SET_LOGGED_USER",
  setCompanies: "SET_COMPANIES",
  setProducts: "SET_PRODUCTS",
  cleanApp: "CLEAN_APP",
};

/**
 * This is the reducer function, that will prepare the update on the state
 * @param {*} state This is the current state of the applications
 * @param {Object} typeAndPayload This is the type and payload for the update
 * @param {String} typeAndPayload.type The type from the reducerCases object
 * @param {*} typeAndPayload.payload This is the payload, could be anything
 */
const Reducer = (state, { type, payload }) => {
  switch (type) {
    case cases.setLoading:
      return {
        ...state,
        isLoading: payload,
      };

    case cases.setLoggedUser:
      return {
        ...state,
        access: {
          ...state.access,
          token: payload.token,
          isLogged: true,
          loggedUser: payload,
        },
      };

    case cases.setCompanies:
      return {
        ...state,
        companies: payload,
      };

    case cases.setProducts:
      return {
        ...state,
        products: payload,
      };

    case cases.cleanApp:
      return {
        isLoading: false,
        access: {
          isLogged: false,
          loggedUser: null,
          token: null,
        },
        companies: [],
      };

    default:
      return state;
  }
};

export default Reducer;
