import express, { Request } from 'express';
import dotenv from 'dotenv';
import mongoose from 'mongoose';
import morgan from 'morgan';
import cors from 'cors';

import routes from './routes';
import accessLogStream from './utils/writeLogFile';

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
app.use(cors());
app.use(express.json());
app.use(morgan('combined'));

/**
 * Logger
 */
morgan.token('reqBody', (req: Request, res: Response) => JSON.stringify(req.body));
morgan.token('reqParams', (req: Request, res: Response) => JSON.stringify(req.params));
morgan.token('reqQuery', (req: Request, res: Response) => JSON.stringify(req.query));

const morganLog = `[LOG] :remote-addr - :remote-user [:date[clf]] ":method :url HTTP/:http-version" :status :res[content-length] ":referrer" ":user-agent"  REQUEST BODY :reqBody PARAMS :reqParams QUERY :reqQuery`;

app.use(morgan(morganLog, { stream: accessLogStream }));

/**
 * Routes and API
 */
app.use('/api', routes);

// Listening
app.listen(process.env.PORT || 9000);
