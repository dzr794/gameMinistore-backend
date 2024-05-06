import { Request, Response } from 'express';

import { db } from "../../config/mySqlConnection";
import { ESRB } from '../../entities';

export const updateESRB = async (req:Request, res:Response) => {
  const esrbId = req.params.esrbId;

  const newEsrb:ESRB = req.body;
  const conn = await db;

  try {

    const [queryResult]:any = await conn.query(`UPDATE esrb SET 
                                                name = '${newEsrb.name}', 
                                                description = '${newEsrb.description}'
                                                WHERE esrb.id = ${esrbId};`);
    
    res.sendStatus(200);
    
  } catch (error) {
    
    res.status(404).send({error:"There was a problem updating the ESRB"});
    
  }


}