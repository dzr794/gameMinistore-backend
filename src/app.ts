import express from 'express';
import bodyParser from 'body-parser';
import cors from 'cors';

import { appRouter } from "./interfaces/routes";


const app = express();
app.use(bodyParser.json()); 

const corsOptions = {
  // origin: ['http://localhost:3000', 'https://your-allowed-domain.com'],
  // credentials: true, // Allow cookies for cross-origin requests (if applicable)
  optionsSuccessStatus: 200 // Optionally set the status code for preflight requests
}

app.use(cors(corsOptions));
app.use('/', appRouter);


app.get('/health', (req, res) => {
  console.log('esto sale en la consola');
  res.send({todoBien:"sisa"});
});







































const port = 3000;
app.listen(port);
console.log(`Listening on Port: ${port}`);
console.log(`http://localhost:${port}/health`);
console.log(`http://localhost:${port}/games`);

