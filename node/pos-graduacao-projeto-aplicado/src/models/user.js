const moongoose = require('mongoose');

const userSchema = new moongoose.Schema({
  name: { type: String, required: true },
  email: { type: String, unique: true, required: true },
  userTheme: { type: String, default: 'defaultTheme' },
  password: { type: String, required: true },
  isActive: { type: Boolean, default: true },
  verifyCode: { type: String },
});

module.exports = moongoose.model('users', userSchema);
