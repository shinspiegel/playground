const getInitial = (route) => {
  if (route && route.params && route.params.company) {
    return {
      initialCompany: route.params.company,
      initialAddress: route.params.company.address,
    };
  }

  return { initialCompany: {}, initialAddress: {} };
};

export default getInitial;
