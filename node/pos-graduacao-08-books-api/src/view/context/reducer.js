export const reducerCases = {
  setBooks: 'SET_BOOKS',
  setFetching: 'SET_FECHING',
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
    case reducerCases.setFetching:
      return {
        ...state,
        isFetching: payload,
      };

    case reducerCases.setBooks:
      return {
        ...state,
        bookList: payload,
      };

    default:
      return state;
  }
};

export default Reducer;
