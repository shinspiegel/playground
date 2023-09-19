export const reducerCases = {
  setContacts: 'SET_CONTACTS',
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

    case reducerCases.setContacts:
      return {
        ...state,
        contactList: payload,
      };

    default:
      return state;
  }
};

export default Reducer;
