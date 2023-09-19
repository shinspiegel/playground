/**
 *
 * @param {Object} config This is the configuration object.
 * @param {String} config.name
 * @param {String} config.link
 *
 */
const getEmailBody = ({ name, link }) => {
  console.log('teste');

  return `<table
  width="680"
  bgcolor="transparent"
  align="center"
  valign="top"
  cellspacing="0"
  cellpadding="0"
  border="0"
>
  <tbody>
    <tr>
      <td width="40"></td>
      <td width="600" style="background-color: #ec4f84;">
        <table
          width="600"
          align="center"
          cellspacing="0"
          cellpadding="0"
          border="0"
        >
          <tbody
            style="color: #ffffff; font-family: Arial, Helvetica, sans-serif;"
          >
            <tr>
              <td style="text-align: center; padding: 32px;">
                <img
                  style="height: 64px;"
                  src="https://meu-mercado.netlify.app/logo_branco.abaa2976.png"
                  alt="Meu Mercado"
                />
              </td>
            </tr>

            <tr>
              <td style="text-align: center;">
                <h1 style="font-size: 22px;">
                  Recuperação de Senha
                </h1>
              </td>
            </tr>

            <tr>
              <td style="padding: 32px; font-size: 22px;text-align: center;">
                <p>
                  Olá ${name}!
                </p>
              </td>
            </tr>

            <tr>
              <td style="padding: 32px; font-size: 22px;text-align: center;">
                <p>
                  Para alterar sua senha de acesso, basta clicar o link abaixo e
                  acessar a página de alteração de senha.
                </p>
              </td>
            </tr>

            <tr>
              <td style="padding: 32px; text-align: center;">
                <a
                  style="
                    border-radius: 4px;
                    display: inline-block;
                    margin: 12px auto 0;
                    padding: 12px;
                    text-align: center;
                    background-color: white;
                    text-decoration: none;
                    color: #000000;
                  "
                  href="${link}"
                >
                  Alterar sua senha</a
                >
              </td>
            </tr>

            <tr>
              <td style="padding: 32px; font-size: 22px;text-align: center;">
                Se você não solicitou a alteração de senha, favor desconsiderar
                este email.
              </td>
            </tr>
          </tbody>
        </table>
      </td>
      <td width="40"></td>
    </tr>
  </tbody>
</table>
`;
};

module.exports = getEmailBody;
