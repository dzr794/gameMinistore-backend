import { Request, Response } from 'express';

import { db } from "../../config/mySqlConnection";
import { ESRB } from "../../entities/";


export const createESRB = async(req:Request, res:Response) => {
  const newESRB:ESRB = req.body;
  
  const conn = await db;
  
  try {
    const [queryResult] = await conn.query(`INSERT INTO ESRB (name, description) VALUES 
                                            ('${newESRB.name}', '${newESRB.description}');`
                                          );
    console.log(queryResult);
    
    res.sendStatus(200);
  } catch (error) {
    res.status(404).send({error:"Failed to create the ESRB"});
  }

};

