import React from 'react';
import './index.css';

/**
 * This is a version display componente do be displayed on the top of the screen
 * @param {Object} props
 * @param {String | Number} props.version This is the version to be showed
 */
const VersionDisplay = ({ version }) => {
  return (
    <p className='versionDisplay' aria-label={`versão do aplicativo é ${version}`}>
      {version}
    </p>
  );
};

export default VersionDisplay;
