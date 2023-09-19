import AsyncStorage from "@react-native-community/async-storage";

/**
 * Set a key value pair on the async storage
 * @param {String} key this is the key for a key pair
 * @param {Object} object this is a object that will be stringified
 */
export const asyncStoreData = async (key, object) => {
  try {
    await AsyncStorage.setItem(key, JSON.stringify(object));
    return true;
  } catch (e) {
    console.log(e);
  }
};

/**
 * This will recover a value on given key, or will return null
 * @param {String} key this is a key to recover
 */
export const asyntGetStored = async (key) => {
  try {
    const value = await AsyncStorage.getItem(key);

    if (value !== null) {
      return JSON.parse(value);
    }

    return null;
  } catch (e) {
    console.log(e);
  }
};

/**
 * This will remove a stored item by given key
 * @param {String} key this is a key to recover
 */
export const asyntRemoveStored = async (key) => {
  try {
    await AsyncStorage.removeItem(key);
  } catch (e) {
    console.log(e);
  }
};
