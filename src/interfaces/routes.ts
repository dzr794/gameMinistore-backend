import { Router } from 'express';

import { createGame, deleteGame, listGames, readGame, updateGame } from '../useCases';
import { createPublisher, deletePublisher, listPublishers, readPublisher, updatePublisher } from '../useCases';
import { createESRB, deleteESRB, listESRB, readESRB, updateESRB } from '../useCases';


const appRouter = Router();


// List all games
appRouter.get('/games', listGames);
// Create a new game
appRouter.post('/games', createGame);
// Delete a game
appRouter.delete('/games/:gameId', deleteGame);
// Get a single game by id
appRouter.get('/games/:gameId', readGame);
// Update an existing game
appRouter.put('/games/:gameId', updateGame);

// List all publishers
appRouter.get('/publishers', listPublishers);
// Create a new publisher
appRouter.post('/publishers', createPublisher);
// Delete a publisher
appRouter.delete('/publishers/:publisherId', deletePublisher);
// Get a single publisher by id
appRouter.get('/publishers/:publisherId', readPublisher);
// Update an existing publisher
appRouter.put('/publishers/:publisherId', updatePublisher);

// List all esrb
appRouter.get('/esrb', listESRB);
// Create a new esrb
appRouter.post('/esrb', createESRB);
// Delete a esrb
appRouter.delete('/esrb/:esrbId', deleteESRB);
// Get a single esrb by id
appRouter.get('/esrb/:esrbId', readESRB);
// Update an existing esrb
appRouter.put('/esrb/:esrbId', updateESRB);


export {
  appRouter
}






