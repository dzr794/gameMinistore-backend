import { Request, Response } from 'express';

import { db } from "../../config/mySqlConnection";
import { Games } from '../../entities';

export const readGame = async (req:Request, res:Response) => {

  const gameId = req.params.gameId;
  const conn = await db;

  try {

    const [queryResult]:any = await conn.query(`SELECT * FROM games WHERE id = ${gameId}`);
    const games = queryResult[0];
    
    res.send(games);
    
  } catch (error) {
    
    res.status(404).send({error:"Game does not exist"});
    
  }


}
