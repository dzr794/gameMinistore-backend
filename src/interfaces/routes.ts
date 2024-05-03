import { Router } from 'express';

import { 
  createGame,
  deleteGame,
  listGames,
  readGame,
  updateGame,
} from '../useCases/Games';

const appRouter = Router();

// Create a new game
appRouter.post('/', listGames);

appRouter.post('/games', createGame);
// Delete a game
appRouter.delete('/games/:gameId', deleteGame);
// List all games
appRouter.get('/games', listGames);
// Get a single game by id
appRouter.get('/games/:gameId', readGame);
// Update an existing game
appRouter.put('/games/:gameId', updateGame);


export {
  appRouter
}






