import initialState from './initialState';

export const reducerCases = {
  setUser: 'SET_USER',

  addList: 'ADD_LIST',
  updateList: 'UPDATE_LIST',

  setNotification: 'SET_NOTIFICATION',

  setBackgroundImage: 'SET_BACKGROUND_IMAGE',

  setLoader: 'SET_STATE',

  cleanState: 'CLEAN_STATE',
};

const Reducer = (state, { type, payload }) => {
  switch (type) {
    case reducerCases.setUser:
      return {
        ...state,
        userData: payload,
      };

    case reducerCases.addList:
      return {
        ...state,
        groceryList: [...state.groceryList, payload],
      };

    case reducerCases.updateList:
      const newGroceryList = [...state.groceryList];
      const index = newGroceryList.findIndex((item) => item._id === payload.listId);

      if (index === -1) return state;

      newGroceryList[index].productsList = payload.updatedList;

      return {
        ...state,
        groceryList: [...newGroceryList],
      };

    case reducerCases.setNotification:
      return {
        ...state,
        notification: [...payload],
      };

    case reducerCases.setLoader:
      return {
        ...state,
        isLoading: payload,
      };

    case reducerCases.setBackgroundImage:
      return {
        ...state,
        backgroundImage: payload.blob,
        backgroundURL: payload.url,
      };

    case reducerCases.cleanState:
      return {
        ...state,
        ...initialState,
      };

    default:
      return state;
  }
};

export default Reducer;
