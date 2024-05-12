import { Request, Response } from 'express';

import { db } from "../../config/mySqlConnection";

export const highlightedGames = async ( req:Request, res:Response ) => {
  const conn = await db;

  const queryString =  `SELECT * FROM HighlightedGamesDetails;`;
  
  try {
    const [queryResult] = await conn.query(queryString);
    console.log(queryResult);

    res.send(queryResult);

  } catch (error) {

    res.status(404).send({error:"Failed to list the highlighted games"});

  }

};

