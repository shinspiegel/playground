const mongoose = require('mongoose');

const Schema = new mongoose.Schema({
  companyName: { type: String, required: true },
  corporateName: { type: String, required: true },
  corporateCode: { type: String, required: true },
  address: {
    city: { type: String, required: true },
    neighborhood: { type: String },
    street: { type: String },
    number: { type: String },
  },
  isActive: { type: Boolean, default: true },
});

module.exports = mongoose.model('companies', Schema);
