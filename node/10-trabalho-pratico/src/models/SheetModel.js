const mongoose = require('mongoose');

const Schema = new mongoose.Schema({
  field: { type: String, required: true },
  createAt: { type: Date, required: true, default: new Date() },
  isActive: { type: Boolean, required: true, default: true },
});

module.exports = mongoose.model('sheets', Schema);
