require('dotenv').config();

const express = require('express');
const mongoose = require('mongoose');
const routes = require('./routes');
const cors = require('cors');
const morgan = require('morgan');

const app = express();

// Create Mongo Instance
const mongoURI = process.env.MONGO_URI;
mongoose
  .connect(mongoURI, {
    useNewUrlParser: true,
    useUnifiedTopology: true,
    useFindAndModify: false,
  })
  .catch(console.log);

// Set middlewares
app.use(morgan('combined'));
app.use(cors());
app.use(express.json());

// Set routes for use
app.use('/', express.static('public'));
app.use('/grades', routes);

// Initiate application
app.listen(process.env.PORT || 9000);
