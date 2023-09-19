const User = require('../models/user');
const hash = require('../utils/hashString');
const handleError = require('../utils/handleError');
const { CodeError, errorList } = require('../utils/CodeError');
const validadeArguments = require('../utils/validadeArguments');
const { getRandomFourDigits } = require('../utils/getRandomFourDigits');
const sendMail = require('../utils/sendMail');
const getEmailBody = require('../utils/getRecoverEmailBody');

const index = async (req, res) => {
  try {
    const { email } = req.query;
    const verifyCode = getRandomFourDigits();

    const foundUser = await User.findOneAndUpdate(
      { email },
      { $set: { verifyCode } },
      { new: true },
    ).catch((err) => {
      throw new CodeError({ message: err });
    });

    console.log(foundUser);

    if (foundUser) {
      const name = foundUser.name;
      const link = process.env.FRONTEND + `/recover/${foundUser._id}/${foundUser.verifyCode}`;

      const mailSent = await sendMail({
        mailTo: foundUser.email,
        subject: 'Recover email for MeuMercado',
        mailText: 'Please acess the following link.',
        mailBody: getEmailBody({ name, link }),
      });
    }

    return res.status(201).end();
  } catch (err) {
    return handleError(err, res);
  }
};

const store = async (req, res) => {
  try {
    const { id, code, password } = req.body;
    validadeArguments([id, code, password], new CodeError(errorList.invalidArguments));

    const hashPassword = hash.hashString(password);
    const findUser = await User.findById(id);

    if (findUser.verifyCode !== code) new CodeError(errorList.missMatchCode);

    findUser.password = hashPassword;
    findUser.verifyCode = '';
    findUser.save();

    return res.status(201).end();
  } catch (err) {
    return handleError(err, res);
  }
};

const update = async (req, res) => {
  return handleError(new CodeError(errorList.notImplemented), res);
};

const destroy = async (req, res) => {
  return handleError(new CodeError(errorList.notImplemented), res);
};

module.exports = { index, store, update, destroy };
