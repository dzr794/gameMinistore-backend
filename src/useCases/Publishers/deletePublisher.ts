import { Request, Response } from 'express';

import { db } from "../../config/mySqlConnection";


export const deletePublisher = async(req:Request, res:Response) => {
  const publisherId = req.params.publisherId;
  
  const conn = await db;

  try {
    const [queryResult] = await conn.query(`DELETE FROM publishers WHERE publishers.id = ${publisherId};`);
    console.log(queryResult);
    
    res.sendStatus(200);
    
  } catch (error) {
    res.status(404).send({error:"Failed to delete the publisher"});
  }

};

