/**
 * This function will return a product in a given list by it's product id.
 * @param {Object[]} productList This is the products list on the state
 * @param {String} productId This is the ID for the product
 */
const findProduct = (productList, productId) => {
  if (!productId || !productList) return null;

  const findedProduct = productList.find((product) => product._id === productId);

  return findedProduct;
};

export default findProduct;
