require('dotenv').config();

const express = require('express');
const mongoose = require('mongoose');
const routes = require('./routes');
const cors = require('cors');
const morgan = require('morgan');

const app = express();

const mongoURI = process.env.MONGO_URI;
mongoose
  .connect(mongoURI, {
    useNewUrlParser: true,
    useUnifiedTopology: true,
    useFindAndModify: false,
  })
  .catch(console.log);

app.use(morgan('combined'));
app.use(cors());
app.use(express.json());
app.use(routes);

app.listen(process.env.PORT || 9000);
