import { getWeekNumber } from './index';

describe('utils/getWeekNumber', () => {
  test('Should get the first week', () => {
    const FirstJan2020 = new Date('2020/01/01');
    const firstWeek = getWeekNumber(FirstJan2020);

    expect(firstWeek).toBe(1);
  });

  test('Should get the last week', () => {
    const FirstJan2020 = new Date('2020/12/31');
    const lastWeek = getWeekNumber(FirstJan2020);

    expect(lastWeek).toBe(53);
  });
});
