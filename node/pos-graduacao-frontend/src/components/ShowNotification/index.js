import React from 'react';
import ReactDOM from 'react-dom';
import './index.css';

import { MdClose } from 'react-icons/md';
import useActions from '../../context/useActions';

const ShowNotification = () => {
  const { state, removeNotification } = useActions();
  const { notification } = state;

  if (notification.length <= 0) return null;

  const onClickHandler = (id) => {
    removeNotification(id);
  };

  const addTimeout = (id) => {
    setTimeout(() => removeNotification(id), 5000);
  };

  return ReactDOM.createPortal(
    <div className='notification'>
      {notification.map((n) => (
        <div
          key={n.error || Math.random()}
          className={`notification-item ${n.isError ? 'error' : null}`}
          onClick={() => onClickHandler(n.id)}
        >
          <MdClose />
          <span>{n.message}</span>
          {addTimeout(n.id)}
        </div>
      ))}
    </div>,
    document.getElementsByTagName('body')[0],
  );
};

export default ShowNotification;
