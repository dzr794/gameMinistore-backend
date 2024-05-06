import { Request, Response } from 'express';

import { db } from "../../config/mySqlConnection";


export const deleteESRB = async(req:Request, res:Response) => {
  const esrbId = req.params.esrbId;
  
  const conn = await db;

  try {
    const [queryResult] = await conn.query(`DELETE FROM esrb WHERE esrb.id = ${esrbId};`);
    console.log(queryResult);
    
    res.sendStatus(200);
    
  } catch (error) {
    res.status(404).send({error:"Failed to delete the ESRB"});
  }

};

