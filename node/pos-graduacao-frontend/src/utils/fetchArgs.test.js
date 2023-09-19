import { fetchArgs } from './index';

describe('utils/fetchArgs', () => {
  test('Gera um objecto corretamente quando nenhum argumento é dado', () => {
    const args = fetchArgs();

    expect(JSON.stringify(args)).toBe(
      JSON.stringify({
        method: 'GET',
        mode: 'cors',
        headers: {
          'Content-Type': 'application/json',
        },
        redirect: 'follow',
      }),
    );
  });

  test('Gera um objecto corretamente com POST e argumentos no body', () => {
    const args = fetchArgs({ type: 'POST', body: { ok: true } });

    expect(JSON.stringify(args)).toBe(
      JSON.stringify({
        method: 'POST',
        mode: 'cors',
        headers: {
          'Content-Type': 'application/json',
        },
        redirect: 'follow',
        body: JSON.stringify({ ok: true }),
      }),
    );
  });
});
