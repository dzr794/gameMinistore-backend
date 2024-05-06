import { Request, Response } from 'express';

import { db } from "../../config/mySqlConnection";
import { Publishers } from "../../entities";


export const createPublisher = async(req:Request, res:Response) => {
  const newPublisher:Publishers = req.body;
  
  const conn = await db;
  
  try {
    const [queryResult] = await conn.query(`INSERT INTO Publishers (name) VALUES
                                            ('${newPublisher.name}');`
                                            
                                          );
    console.log(queryResult);
    
    res.sendStatus(200);
  } catch (error) {
    res.status(404).send({error:"Failed to create the publisher"});
  }

};

