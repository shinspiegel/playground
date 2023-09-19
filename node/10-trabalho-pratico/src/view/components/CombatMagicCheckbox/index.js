import React, { useState } from 'react';
import './index.scss';
import CheckBox from '../Checkbox';
import BoxText from '../BoxText';
import SmallTitle from '../SmallTitle';

/**
 *
 * @param {Object} props
 * @param {String} props.title
 * @param {String} props.description
 * @param {String[]} props.options
 * @param {String[]} props.initialValues
 * @param {Function} props.onChange
 */
const CombatMagicCheckbox = ({
  title,
  description,
  initialValues = [],
  options,
  onChange,
}) => {
  const [checked, setChecked] = useState(initialValues);

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
    <>
      <SmallTitle title={title} />
      <ul className="combatMagicCheckbox">
        {options.map((c, i) => (
          <li key={c + i}>
            <CheckBox
              id={i}
              label={c}
              isToggle={checked.includes(`${i}{_}${c}`)}
              name="upgrades"
              onCheck={onCheck}
              onUncheck={onUncheck}
            />
          </li>
        ))}
      </ul>
      <BoxText text={description} />
    </>
  );
};

export default CombatMagicCheckbox;
