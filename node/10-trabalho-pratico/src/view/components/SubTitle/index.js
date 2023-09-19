import React from 'react';
import './index.scss';

/**
 *
 * @param {Object} props
 * @param {String} props.title
 * @param {String=} props.value
 * @param {String=} props.max
 */
const SubTitle = ({ title, value, max }) => (
  <h3 className="subTitle">
    {title}
    {value !== undefined && max ? (
      <span className="subTitle__value">
        {value}/{max}
      </span>
    ) : null}
    {value !== undefined && !max ? (
      <span className="subTitle__value">{value}</span>
    ) : null}
  </h3>
);

export default SubTitle;
