import findProduct from './findProduct';

describe('utils/findProduct', () => {
  const BASE = [{ _id: '00' }, { _id: '01' }, { _id: '02' }];

  test('Deve retornar um objecto de acordo com o id', () => {
    const finded = findProduct(BASE, '01');

    expect(JSON.stringify(finded)).toBe(JSON.stringify({ _id: '01' }));
  });

  test('Deve retornar retornar undefined', () => {
    const finded = findProduct(BASE, '99');

    expect(finded).toBe(undefined);
  });

  test('Deve retornar retornar null', () => {
    const finded = findProduct();

    expect(finded).toBe(null);
  });
});
