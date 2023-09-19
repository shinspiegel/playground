import changeWeek from './changeWeek';

describe('utils/changeWeek', () => {
  test('Deve incrementar em 1 de 10 para 11', () => {
    const { week, year } = changeWeek({ weekChange: 1, week: 10, year: 2020 });

    expect(week).toBe(11);
    expect(year).toBe(2020);
  });

  test('Deve reduzir em 1 de 10 para 9', () => {
    const { week, year } = changeWeek({ weekChange: -1, week: 10, year: 2020 });

    expect(week).toBe(9);
    expect(year).toBe(2020);
  });

  test('Deve incrementar em 1, mesmo recebendo argumento superior a 1 ', () => {
    const { week, year } = changeWeek({ weekChange: 10, week: 10, year: 2020 });

    expect(week).toBe(11);
    expect(year).toBe(2020);
  });

  test('Deve reduzir em 1 de 1 para 53 e reduzir o ano', () => {
    const { week, year } = changeWeek({ weekChange: -1, week: 1, year: 2020 });

    expect(week).toBe(53);
    expect(year).toBe(2019);
  });

  test('Deve incrementar em 1 de 53 para 1 e incrementar o ano', () => {
    const { week, year } = changeWeek({ weekChange: 1, week: 53, year: 2020 });

    expect(week).toBe(1);
    expect(year).toBe(2021);
  });
});
