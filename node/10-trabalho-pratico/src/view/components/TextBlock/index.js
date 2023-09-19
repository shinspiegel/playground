import React from 'react';
import './index.scss';
import SubTitle from '../SubTitle';
import BoxText from '../BoxText';

/**
 *
 * @param {Object} props
 * @param {String} props.title
 * @param {String} props.description
 */
const TextBlock = ({ title, description }) => (
  <section className="textBlock">
    <SubTitle title={title} />
    <BoxText text={description} />
  </section>
);

export default TextBlock;
