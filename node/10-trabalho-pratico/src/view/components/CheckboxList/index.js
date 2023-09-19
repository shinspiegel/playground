import React, { useState } from 'react';
import './index.scss';
import SubTitle from '../SubTitle';
import CheckBox from '../Checkbox';
import BoxText from '../BoxText';

/**
 *
 * @param {Object} props
 * @param {String} props.title
 * @param {String} props.description
 * @param {String} props.name
 * @param {String[]} props.initialValue
 * @param {String[]} props.options
 * @param {Function} props.onChange
 */
const CheckBoxList = ({
  title,
  description,
  initialValue = [],
  options,
  onChange,
}) => {
  const [checked, setChecked] = useState(initialValue);

  const onCheck = (value) => {
    setChecked([...checked, value]);
    if (onChange) onChange([...checked, value]);
  };

  const onUncheck = (value) => {
    const newChecList = checked.filter((v) => value !== v);
    setChecked(newChecList);
    if (onChange) onChange(newChecList);
  };

  return (
    <section className="checkBoxList">
      <SubTitle title={title} />
      <ul className="checkBoxList__list">
        {options.map((c, i) => (
          <li key={c + i}>
            <CheckBox
              id={i}
              label={c}
              isToggle={checked.includes(`${i}{_}${c}`)}
              name={title}
              onCheck={onCheck}
              onUncheck={onUncheck}
            />
          </li>
        ))}
      </ul>
      <BoxText text={description} />
    </section>
  );
};

export default CheckBoxList;
