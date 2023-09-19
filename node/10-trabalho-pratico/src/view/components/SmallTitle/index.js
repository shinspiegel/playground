import React from 'react';
import './index.scss';

/**
 *
 * @param {Object} props
 * @param {String} props.title
 * @param {String=} props.value
 * @param {String=} props.max
 */
const SmallTitle = ({ title, value, max }) => (
  <h4 className="smallTitle">
    {title}
    {value !== undefined && max ? (
      <span className="smallTitle__value">
        {value}/{max}
      </span>
    ) : null}
    {value !== undefined && !max ? (
      <span className="smallTitle__value">{value}</span>
    ) : null}
  </h4>
);

export default SmallTitle;
