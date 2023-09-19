import { useContext } from "react";
import AppContext from "./context";
import { cases } from "./reducer";
import fetchArgs from "../utils/fetchArgs";
import config from "../config";
import {
  asyncStoreData,
  asyntGetStored,
  asyntRemoveStored,
} from "../utils/asyncStorage";

/**
 * This action will return the state and the actions to change de state.
 */
const useActions = () => {
  const { state, dispatch } = useContext(AppContext);

  const login = async (form) => {
    dispatch({ type: cases.setLoading, payload: true });

    const args = fetchArgs({ type: "POST", body: form });

    const request = await fetch(config.api.access, args)
      .then((res) => res.json())
      .catch((err) => console.log(err));

    if (!request || request.error) return;

    await setUserStorage(request.docs[0]);

    dispatch({ type: cases.setLoggedUser, payload: request.docs[0] });
    dispatch({ type: cases.setLoading, payload: false });
  };

  const logout = async () => {
    await removeUserStorage();
    dispatch({ type: cases.cleanApp });
  };

  const setUserStorage = async (userData) => {
    await asyncStoreData(config.storageKeys.user, userData);
  };

  const checkUserStorage = async () => {
    const user = await asyntGetStored(config.storageKeys.user);

    if (user) {
      dispatch({ type: cases.setLoggedUser, payload: user });
    }
  };

  const removeUserStorage = async () => {
    await asyntRemoveStored(config.storageKeys.user);
  };

  const getCompanies = async () => {
    dispatch({ type: cases.setLoading, payload: true });

    const args = fetchArgs({ auth: state.access.token });

    const request = await fetch(config.api.company, args)
      .then((res) => res.json())
      .catch((err) => console.log(err));

    dispatch({
      type: cases.setCompanies,
      payload: request.docs,
    });
    dispatch({ type: cases.setLoading, payload: false });
  };

  const updateCompany = async (company) => {
    const args = fetchArgs({
      type: "PUT",
      auth: state.access.token,
      body: company,
    });

    await fetch(`${config.api.company}/${company._id}`, args)
      .then((res) => res.json())
      .catch((err) => console.log(err));

    getCompanies();
  };

  const createCompany = async (company) => {
    const args = fetchArgs({
      type: "POST",
      auth: state.access.token,
      body: company,
    });

    await fetch(config.api.company, args)
      .then((res) => res.json())
      .catch((err) => console.log(err));

    getCompanies();
  };

  const deleteCompary = async (companyID) => {
    const args = fetchArgs({
      type: "DELETE",
      auth: state.access.token,
    });

    await fetch(`${config.api.company}/${companyID}`, args)
      .then((res) => res.json())
      .catch((err) => console.log(err));

    getCompanies();
  };

  return {
    state,
    login,
    logout,
    setUserStorage,
    checkUserStorage,
    getCompanies,
    updateCompany,
    createCompany,
    deleteCompary,
  };
};

export default useActions;
