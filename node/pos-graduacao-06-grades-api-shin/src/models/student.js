const moongoose = require('mongoose');

const userSchema = new moongoose.Schema(
  {
    student: { type: String, required: true },
    subject: { type: String, required: true },
    type: { type: String, required: true },
    value: { type: Number, required: true },
    isActive: { type: Boolean, required: true, default: true },
  },
  {
    timestamps: { createdAt: 'createdAt', updatedAt: 'updatedAt' },
  },
);

module.exports = moongoose.model('users', userSchema);
