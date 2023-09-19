import React, { useState } from 'react';
import './index.scss';
import SubTitle from '../SubTitle';
import RadioButton from '../RadioButton';

/**
 *
 * @param {Object} props
 * @param {String} props.title
 * @param {String[]} props.sexList
 * @param {String[]} props.eyesList
 * @param {String[]} props.clothesList
 * @param {Function} props.sexChange
 * @param {Function} props.eyesChange
 * @param {Function} props.clothesChange
 
 */
const AppearanceBox = ({
  title,
  sexList,
  eyesList,
  clothesList,
  sexChange,
  eyesChange,
  clothesChange,
}) => {
  const [sex, setSex] = useState('');
  const [eyes, setEyes] = useState('');
  const [clothes, setCloches] = useState('');

  const handleSex = (v) => {
    setSex(v);
    if (sexChange) sexChange(v);
  };
  const handleEyes = (v) => {
    setEyes(v);
    if (eyesChange) eyesChange(v);
  };
  const handleClothes = (v) => {
    setCloches(v);
    if (clothesChange) clothesChange(v);
  };

  return (
    <section className="appearanceBox">
      <SubTitle title={title} />
      <div className="appearanceBox__optionsList">
        <ul className="appearanceBox__optionsBox">
          {sexList.map((i) => (
            <li key={i}>
              <RadioButton
                label={i}
                name="sex"
                isChecked={i === sex}
                onChange={(v) => handleSex(v)}
              />
            </li>
          ))}
        </ul>
        <ul className="appearanceBox__optionsBox">
          {eyesList.map((i) => (
            <li key={i}>
              <RadioButton
                label={i}
                name="eyes"
                isChecked={i === eyes}
                onChange={(v) => handleEyes(v)}
              />
            </li>
          ))}
        </ul>
        <ul className="appearanceBox__optionsBox">
          {clothesList.map((i) => (
            <li key={i}>
              <RadioButton
                label={i}
                name="clothes"
                isChecked={i === clothes}
                onChange={(v) => handleClothes(v)}
              />
            </li>
          ))}
        </ul>
      </div>
    </section>
  );
};

export default AppearanceBox;
