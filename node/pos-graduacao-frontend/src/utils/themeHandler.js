import themes from '../assets/themes.json';

/**
 * This function will change the CSS custom properties of gives HTML root element and giver set os properties.
 * @param {Object} rootElement This is the root element to alter the ':root' property
 * @param {String} theme The theme name string that will be used
 * @returns {Boolean} It will return false if a invalid theme name or rootElement was given
 */
const themeHandler = (rootElement, theme) => {
  let themeProperties;

  try {
    if (!rootElement) throw new Error('Absent root element');
    if (!theme) throw new Error('Absent theme name');

    themeProperties = Object.entries(themes[theme]);

    themeProperties.map((name) => {
      rootElement.style.setProperty(name[0], name[1]);
    });
  } catch (err) {
    console.error('Failed to receive a proper theme or HTML element. \n\n', err);
    return false;
  }

  return true;
};

export default themeHandler;
