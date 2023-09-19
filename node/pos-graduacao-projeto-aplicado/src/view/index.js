import React from 'react';
import ReactDOM from 'react-dom';
import { BrowserRouter } from 'react-router-dom';
import { ContextProvider } from './context/context';

import Routes from './routes';

ReactDOM.render(
  <ContextProvider>
    <BrowserRouter>
      <Routes />
    </BrowserRouter>
  </ContextProvider>,
  document.getElementById('root'),
);

if (process.env.SERVICE_WORKER === 'true') {
  if ('serviceWorker' in navigator) {
    navigator.serviceWorker.register('/service-worker.js');
  }
}
