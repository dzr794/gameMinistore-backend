import { Request, Response } from 'express';

import { db } from "../../config/mySqlConnection";
import { Games } from '../../entities';

export const updateGame = async (req:Request, res:Response) => {
  const gameId = req.params.gameId;

  const newGame:Games = req.body;
  const conn = await db;

  try {

    const [queryResult]:any = await conn.query(`UPDATE games SET  
                                                  title = '${newGame.title}',
                                                  price = ${newGame.price},
                                                  publisherId = ${newGame.publisherId},
                                                  publisherName = '${newGame.publisherName}',
                                                  ESRB_ratingId = ${newGame.ESRB_ratingId},
                                                  ESRB_ratingName = '${newGame.ESRB_ratingName}'
                                                WHERE games.id = ${gameId};`);
    
    res.sendStatus(200);
    
  } catch (error) {
    
    res.status(404).send({error:"There was a problem updating the Game"});
    
  }


}