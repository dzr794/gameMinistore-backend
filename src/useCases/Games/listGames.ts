import { Request, Response } from 'express';

import { db } from "../../config/mySqlConnection";

export const listGames = async ( req:Request, res:Response ) => {
  const conn = await db;

  const query_keys_length = Object.keys(req.query).length;
  let where_query = '';
  
  if( query_keys_length > 0 ) {
    const {price, publisher} = req.query;

    where_query = 'WHERE';

    if (price) { where_query += ` price ${ parseInt(String(price)) > 0 ? '<= ' : '= ' }${price}`; }
    
    where_query += (query_keys_length > 1) ? ' AND' : '';
    
    if (publisher) { where_query += ` publisherId = ${publisher}`; }

  } else {
    where_query = '';
  }

  const queryString =  `SELECT id, title, price, publisherName as publisher, ESRB_ratingName as ESRB, imgLink as image FROM games ${where_query};`;

  // res.send(queryString);

  try {
    const [queryResult] = await conn.query(queryString);
    console.log(queryResult);

    res.send(queryResult);

  } catch (error) {

    res.status(404).send({error:"Failed to list the games"});

  }

};