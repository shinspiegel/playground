const express = require('express');
const path = require('path');
const dotenv = require('dotenv');
const mongoose = require('mongoose');
const morgan = require('morgan');

const routes = require('./routes');
const accessLogStream = require('./utils/writeLogFile');

// Create expreser server
const app = express();

// Access enviroment variables
dotenv.config();

/**
 * Create a connection with mongodb
 */
const mongoURI = process.env.MONGO_URI;
mongoose
  .connect(mongoURI, {
    useNewUrlParser: true,
    useUnifiedTopology: true,
    useFindAndModify: false,
  })
  .catch(console.log);

/**
 * Middlewares
 */
app.use(express.json());
app.use(morgan('combined'));

/**
 * Logger
 */
morgan.token('reqBody', (req, res) => JSON.stringify(req.body));
morgan.token('reqParams', (req, res) => JSON.stringify(req.params));
morgan.token('reqQuery', (req, res) => JSON.stringify(req.query));

const morganLog = `[LOG] :remote-addr - :remote-user [:date[clf]] ":method :url HTTP/:http-version" :status :res[content-length] ":referrer" ":user-agent"  REQUEST BODY :reqBody PARAMS :reqParams QUERY :reqQuery`;

app.use(morgan(morganLog, { stream: accessLogStream }));

/**
 * Routes and API
 */
app.use('/api', routes);
app.use('/', express.static('public'));
app.get('*', (_, res) => res.sendFile(path.join(__dirname, '..', 'public', 'index.html')));

// Listening
app.listen(process.env.PORT || 9000);
