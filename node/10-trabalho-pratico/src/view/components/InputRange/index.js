import React from 'react';
import './index.scss';

const InputRange = ({
  leftText,
  leftAction,
  rightText,
  rightAction,
  value,
  onChange,
  min = 0,
  max = 5,
  step = 1,
}) => {
  return (
    <label className="rangeInput">
      {leftText && leftAction ? (
        <span className="rangeInput__rangeText" onClick={leftAction}>
          {leftText}
        </span>
      ) : null}
      {leftText && !leftAction ? (
        <span className="rangeInput__rangeText">{leftText}</span>
      ) : null}

      <input
        className="rangeInput__rangeSlide"
        type="range"
        value={value}
        onChange={onChange}
        min={min}
        step={step}
        max={max}
      />

      {rightText && rightAction ? (
        <span className="rangeInput__rangeText" onClick={rightAction}>
          {rightText}
        </span>
      ) : null}
      {rightText && !rightAction ? (
        <span className="rangeInput__rangeText">{rightText}</span>
      ) : null}
    </label>
  );
};

export default InputRange;
