import fs from 'fs';
import path from 'path';

const accessLogStream = fs.createWriteStream(path.join(__dirname, '..', '..', 'access.log'));

export default accessLogStream;
