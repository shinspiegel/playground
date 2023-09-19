import { useContext } from 'react';
import AppContext from './context';
import { reducerCases as cases } from './reducer';
// import fetchArgs from '../utils/fetchArgs';

/**
 * This action will return the state and the actions to change de state.
 */
const useActions = () => {
  const { state, dispatch } = useContext(AppContext);

  const setStats = (textValue) => {
    let statsValueArray = [0, 0, 0, 0, 0];

    switch (textValue) {
      case 'Braveza +0, Esperteza +1, Estranheza +2, Firmeza +1, Sutileza −1':
        statsValueArray = [0, 1, 2, 1, -1];
        break;
      case 'Braveza +1, Esperteza +1, Estranheza +2, Firmeza -1, Sutileza +0':
        statsValueArray = [1, 1, 2, -1, 0];
        break;
      case 'Braveza -1, Esperteza +2, Estranheza +2, Firmeza +0, Sutileza −1':
        statsValueArray = [-1, 2, 2, 0, 0];
        break;
      case 'Braveza -1, Esperteza +1, Estranheza +2, Firmeza +0, Sutileza +1':
        statsValueArray = [-1, 1, 2, 0, 0];
        break;
      case 'Braveza +0, Esperteza +1, Estranheza +2, Firmeza +0, Sutileza +0':
        statsValueArray = [0, 1, 2, 0, 0];
        break;

      default:
        break;
    }

    const newStats = state.stats.map((s, i) => {
      const stat = { ...s };
      stat.value = statsValueArray[i];
      return stat;
    });

    dispatch({ type: cases.setStats, payload: newStats });
  };

  const setOneStat = (value, index) => {
    const newStats = [...state.stats];
    newStats[index].value = value;

    dispatch({ type: cases.setStats, payload: newStats });
  };

  const setAttributeValue = (attribute, value) => {
    const updatedValue = { ...state[attribute] };
    updatedValue.value = value;

    dispatch({
      type: cases.setAttribute,
      payload: { attribute, value: updatedValue },
    });
  };

  const setAttributeSelected = (attribute, value) => {
    const updatedValue = { ...state[attribute] };
    updatedValue.selected = value;

    dispatch({
      type: cases.setAttribute,
      payload: { attribute, value: updatedValue },
    });
  };

  const setAppearanceValue = (type, value) => {
    const updatedValue = { ...state.charCreation.appearance.selected };
    updatedValue[type] = value;

    dispatch({
      type: cases.setAppearance,
      payload: updatedValue,
    });
  };

  const setCombatMagic = (type, value) => {
    const updatedValue = { ...state.combatMagic };
    updatedValue[type].selected = value;

    dispatch({
      type: cases.setAppearance,
      payload: updatedValue,
    });
  };

  const setMovesList = (value) => {
    const updatedValue = { ...state.moves };
    updatedValue.movesListSelected = value;

    dispatch({
      type: cases.setAttribute,
      payload: { attribute: 'moves', value: updatedValue },
    });
  };

  return {
    state,
    setStats,
    setOneStat,
    setAttributeValue,
    setAppearanceValue,
    setAttributeSelected,
    setCombatMagic,
    setMovesList,
  };
};

export default useActions;
