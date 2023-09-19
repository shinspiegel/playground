const sgMail = require('@sendgrid/mail');
const { CodeError } = require('./CodeError');
/**
 *
 * @param {object} config
 * @param {string} config.mailTo Mail contact that the mail will be sent
 * @param {string=} config.mailFrom Mail contact that the mail will be sent
 * @param {string} config.subject Mail subject e/or title
 * @param {string} config.mailText Mail text information, or short description
 * @param {string} config.mailBody Mail body in html with all the information
 */
const sendMail = async ({
  mailTo,
  mailFrom = 'contato@meumercado.com.br',
  subject,
  mailText,
  mailBody,
}) => {
  sgMail.setApiKey(process.env.SENDGRID_API_KEY);

  const msg = {
    to: mailTo,
    from: mailFrom,
    subject: subject,
    text: mailText,
    html: mailBody,
  };

  const mailDelivery = await sgMail.send(msg).catch((err) => {
    throw new CodeError({ message: err });
  });

  return mailDelivery;
};

module.exports = sendMail;
