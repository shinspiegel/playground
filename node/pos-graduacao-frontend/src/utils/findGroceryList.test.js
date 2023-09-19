import { findGroceryList } from './index';

describe('utils/findGroceryList', () => {
  const originalList = [
    { year: 3, week: 3 },
    { year: 2, week: 2 },
    { year: 1, week: 1 },
  ];

  test('Deve retornar uma lista', () => {
    const findedList = findGroceryList(originalList, 2, 2);

    expect(findedList).toBeTruthy();
    expect(JSON.stringify(findedList)).toBe(JSON.stringify({ year: 2, week: 2 }));
  });

  test('Deve retornar um objeto falsy', () => {
    const findedList = findGroceryList(originalList, 4, 4);

    expect(findedList).toBeFalsy();
  });
});
