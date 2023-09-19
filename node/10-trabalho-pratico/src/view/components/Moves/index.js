import React, { useState } from 'react';
import './index.scss';
import SubTitle from '../SubTitle';
import CheckBox from '../Checkbox';
import BoxText from '../BoxText';
import SmallTitle from '../SmallTitle';

/**
 *
 * @param {Object} props
 * @param {String} props.title
 * @param {String[]} props.descriptionList
 * @param {String} props.defaultText
 * @param {String} props.movesListText
 * @param {String[]} props.defaultList
 * @param {String[]} props.movesList
 * @param {Function} props.onChange
 */
const MovesList = ({
  title,
  descriptionList,
  defaultText,
  defaultList,
  movesListText,
  movesList,
  onChange,
  min = 0,
  max = 4,
}) => {
  const [checked, setChecked] = useState([]);

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
    <section className="movesList">
      <SubTitle
        title={title}
        value={checked.length + defaultList.length}
        max={max}
      />
      <BoxText text={descriptionList} />

      <SmallTitle title={defaultText} />
      <ul className="movesList__list">
        {defaultList.map((c, i) => (
          <li key={c + i}>
            <CheckBox id={i} label={c} isToggle={true} name="upgrades" />
          </li>
        ))}
      </ul>

      <SmallTitle title={movesListText} />
      <ul className="movesList__list">
        {movesList.map((c, i) => (
          <li key={c + i}>
            <CheckBox
              id={i}
              label={c}
              isToggle={checked.includes(`${i}{_}${c}`)}
              name="advancedUpgrades"
              onCheck={onCheck}
              onUncheck={onUncheck}
            />
          </li>
        ))}
      </ul>
    </section>
  );
};

export default MovesList;
