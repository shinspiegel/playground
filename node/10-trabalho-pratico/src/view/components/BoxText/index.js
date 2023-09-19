import React from 'react';
import Markdown from 'react-markdown';
import './index.scss';

/**
 *
 * @param {Object} props
 * @param {String | String[]} props.text
 */
const BoxText = ({ text }) => {
  if (!text) return null;

  const textList = Array.isArray(text) ? text : [text];

  return (
    <>
      {textList.map((p, i) => (
        <Markdown key={i} source={p} className="markdownText" />
      ))}
    </>
  );
};

export default BoxText;
