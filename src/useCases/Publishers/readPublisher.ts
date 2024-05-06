import { Request, Response } from 'express';

import { db } from "../../config/mySqlConnection";
import { Publishers } from '../../entities/Publishers';

export const readPublisher = async (req:Request, res:Response) => {

  const publisherId = req.params.publisherId;
  const conn = await db;

  try {

    const [queryResult]:any = await conn.query(`SELECT * FROM publishers WHERE id = ${publisherId}`);
    const publishers = queryResult[0];
    
    res.send(publishers);
    
  } catch (error) {
    
    res.status(404).send({error:"Publisher does not exist"});
    
  }


}
