import { Request, Response } from 'express';

import { db } from "../../config/mySqlConnection";
import { Games } from '../../entities/Games';

export const updateGame = async (req:Request, res:Response) => {
  const gameId = req.params.gameId;

  const newGame:Games = req.body;
  const conn = await db;

  try {

    const [queryResult]:any = await conn.query(`UPDATE games SET 
                                                title = '${newGame.title}', 
                                                price = '${newGame.price}', 
                                                WHERE games.id = ${gameId};`);
    
    res.sendStatus(200);
    
  } catch (error) {
    
    res.status(404).send({error:"Game does not exist"});
    
  }


}