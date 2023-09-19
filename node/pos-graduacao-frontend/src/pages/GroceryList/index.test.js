import React from 'react';
import '@testing-library/jest-dom/extend-expect';
import { render, wait } from '@testing-library/react';
import { Route, MemoryRouter } from 'react-router-dom';

import mockFetch from '../../tests/mockFetch';

import GroceryList from './index';
import { ContextProvider } from '../../context/context';
import { setCookie } from '../../utils';

beforeEach(() => {
  global.fetch = null;
});

describe('pages/Register', () => {
  test('Deve fazer uma requisição para receber informações do server buscando a lista de grocery', async () => {
    global.fetch = mockFetch();

    const TOKEN = 'TOKEN_TEST';
    const YEAR = 2020;
    const WEEK = 7;

    setCookie('user', { token: TOKEN });

    const { debug, getByPlaceholderText, getByRole } = render(
      <ContextProvider>
        <MemoryRouter initialEntries={[`/list/${YEAR}/${WEEK}`]}>
          <Route path='/list/:year/:week' component={GroceryList} />
        </MemoryRouter>
      </ContextProvider>,
    );

    expect(global.fetch).toBeCalledWith(`undefined/grocery-lists/${YEAR}/${WEEK}`, {
      headers: { Authorization: TOKEN, 'Content-Type': 'application/json' },
      method: 'GET',
      mode: 'cors',
      redirect: 'follow',
    });
  });

  test('Deve requisitar ao backend por uma lista e receber uma lista com 3 items', async () => {
    const responseObject = {
      _id: 'ob_ID',
      listOwner: 'owner_ID',
      week: 0,
      year: 0,
      __v: 0,
      productsList: [
        { _id: 'product_ID_1', productName: 'TEST_PRODUCT_1' },
        { _id: 'product_ID_2', productName: 'TEST_PRODUCT_2' },
        { _id: 'product_ID_3', productName: 'TEST_PRODUCT_2' },
      ],
    };

    global.fetch = mockFetch(responseObject);
    setCookie('user', { token: 'TOKEN' });

    const { container } = render(
      <ContextProvider>
        <MemoryRouter initialEntries={[`/list/0/0`]}>
          <Route path='/list/:year/:week' component={GroceryList} />
        </MemoryRouter>
      </ContextProvider>,
    );

    await wait(() => {}, { timeout: 300 });
    const listItems = container.querySelectorAll('.productItem');
    expect(listItems.length).toBe(3);
  });
});
