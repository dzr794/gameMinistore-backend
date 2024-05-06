import { Request, Response } from 'express';

import { db } from "../../config/mySqlConnection";
import { Games } from "../../entities";


export const createGame = async(req:Request, res:Response) => {
  const newGame:Games = req.body;
  
  const conn = await db;
  
  try {
    const [queryResult] = await conn.query(`INSERT INTO games 
                                            (title, price, 
                                             publisherId, publisherName,
                                             ESRB_ratingId, ESRB_ratingName
                                            ) 
                                            VALUES 
                                            ('${newGame.title}', ${newGame.price} , 
                                             ${newGame.publisherId}, '${newGame.publisherName}', 
                                             ${newGame.ESRB_ratingId}, '${newGame.ESRB_ratingName}'
                                            );`
                                          );
    console.log(queryResult);
    
    res.sendStatus(200);
  } catch (error) {
    res.status(404).send({error:"Failed to create the game"});
  }

};

