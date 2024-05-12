import { Request, Response } from 'express';

import { db } from "../../config/mySqlConnection";

export const listGames = async ( req:Request, res:Response ) => {
  const conn = await db;


  const queryString =  `SELECT id, title, price, publisherName as publisher, ESRB_ratingName as ESRB, imgLink as image
                        FROM games;`;
  
  try {
    const [queryResult] = await conn.query(queryString);
    console.log(queryResult);

    res.send(queryResult);

  } catch (error) {

    res.status(404).send({error:"Failed to list the games"});

  }

};