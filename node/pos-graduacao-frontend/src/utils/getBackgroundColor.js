const getBackgroundColor = (path) => {
  const isOnLogin = path.match(/login/g);
  const isOnRecover = path.match(/register/g);
  const isOnRegister = path.match(/recover/g);
  if (isOnLogin || isOnRecover || isOnRegister) return 'var(--secondary-bg)';

  const isOnList = path.match(/list/g);
  if (isOnList) return 'var(--primary-bg)';

  const isOnProfile = path.match(/profile/g);
  if (isOnProfile) return 'var(--accent-bg)';

  const isOnProductSelect = path.match(/product-select/g);
  if (isOnProductSelect) return 'var(--secondary-bg)';

  return 'var(--primary-bg)';
};

export default getBackgroundColor;
