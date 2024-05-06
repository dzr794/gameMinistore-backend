import { Request, Response } from 'express';

import { db } from "../../config/mySqlConnection";
import { Publishers } from '../../entities/Publishers';

export const updatePublisher = async (req:Request, res:Response) => {
  const publisherId = req.params.publisherId;

  const newPublisher:Publishers = req.body;
  const conn = await db;

  try {

    const [queryResult]:any = await conn.query(`UPDATE publishers SET 
                                                name = '${newPublisher.name}' 
                                                WHERE publishers.id = ${publisherId};`);
    
    res.sendStatus(200);
    
  } catch (error) {
    
    res.status(404).send({error:"Publisher does not exist"});
    
  }


}