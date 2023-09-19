const getInitial = (route) => {
  if (route && route.params && route.params.product) {
    return {
      initialProduct: route.params.product,
    };
  }

  return { initialProduct: {} };
};

export default getInitial;
