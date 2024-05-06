import { Request, Response } from 'express';

import { db } from "../../config/mySqlConnection";
import { ESRB } from '../../entities';

export const readESRB = async (req:Request, res:Response) => {

  const esrbId = req.params.esrbId;
  const conn = await db;

  try {

    const [queryResult]:any = await conn.query(`SELECT * FROM esrb WHERE id = ${esrbId}`);
    const esrb = queryResult[0];
    
    res.send(esrb);
    
  } catch (error) {
    
    res.status(404).send({error:"ESRB does not exist"});
    
  }


}
