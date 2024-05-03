import { Request, Response } from 'express';

import { db } from "../../config/mySqlConnection";


export const deleteGame = async(req:Request, res:Response) => {
  const gameId = req.params.gameId;
  
  const conn = await db;

  try {
    const [queryResult] = await conn.query(`DELETE FROM games WHERE games.id = ${gameId};`);
    console.log(queryResult);
    
    res.sendStatus(200);
    
  } catch (error) {
    res.status(404).send({error:"Failed to delete the game"});
  }

};

