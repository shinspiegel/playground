import themeList from '../assets/themes.json';

/**
 * This function will change the CSS custom properties of gives HTML root element and giver set os properties.
 * @param {String} theme The theme name string that will be used
 * @param {Object=} rootElement This is the root element to alter the ':root' property. If none is given the html:root will be selected.
 * @returns {Boolean} It will return false if a invalid theme name or rootElement was given
 */
const themeHandler = (theme, rootElement) => {
  let themeProperties;

  if (!rootElement) rootElement = document.getElementsByTagName('html')[0];

  try {
    if (!rootElement) throw new Error('Absent root element');
    if (!theme) throw new Error('Absent theme name');

    themeProperties = Object.entries(themeList[theme]);

    themeProperties.forEach((name) => {
      rootElement.style.setProperty(name[0], name[1]);
    });
  } catch (err) {
    themeHandler('defaultTheme');
  }

  return true;
};

export default themeHandler;
