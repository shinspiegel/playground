export const reducerCases = {
  setStats: 'SET_STATS',
  setAttribute: 'SET_ATTRIBUTE',
  setAppearance: 'SET_APPEARANCE',
  setCombatMagic: 'SET_COMBAT_MAGIC',
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
    case reducerCases.setStats:
      return {
        ...state,
        stats: [...payload],
      };

    case reducerCases.setAttribute:
      return {
        ...state,
        [payload.attribute]: payload.value,
      };

    case reducerCases.setAppearance:
      const newState = { ...state };
      newState.charCreation.appearance.selected = payload;

      return {
        ...newState,
      };

    case reducerCases.setCombatMagic:
      return {
        ...newState,
        combatMagic: payload,
      };

    default:
      return state;
  }
};

export default Reducer;
