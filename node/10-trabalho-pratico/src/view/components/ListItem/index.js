import React from 'react';
import './index.scss';
import SubTitle from '../SubTitle';
import SmallTitle from '../SmallTitle';
import BoxText from '../BoxText';
import Markdown from 'react-markdown';

/**
 *
 * @param {Object} props
 * @param {String=} props.title
 * @param {String=} props.smallTitle
 * @param {String} props.description
 * @param {String[]} props.options
 */
const ListItem = ({ title, smallTitle, description, options }) => (
  <section className="listItem">
    {title ? <SubTitle title={title} /> : null}
    {smallTitle ? <SmallTitle title={smallTitle} /> : null}
    <BoxText text={description} />

    <ul className="listItem__list">
      {options.map((i) =>
        i ? (
          <li key={i} className="listItem__item" key={i}>
            <Markdown source={i} />
          </li>
        ) : null,
      )}
    </ul>
  </section>
);

export default ListItem;
