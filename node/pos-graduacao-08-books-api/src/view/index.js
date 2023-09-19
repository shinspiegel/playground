import React from 'react';
import ReactDOM from 'react-dom';
import { ContextProvider } from './context/context';

import Routes from './routes';

ReactDOM.render(
  <ContextProvider>
    <Routes />
  </ContextProvider>,
  document.getElementById('root'),
);
