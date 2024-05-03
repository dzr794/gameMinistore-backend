import mysql from 'mysql2/promise';

export const db = mysql.createConnection({
  host: 'localhost',
  port: 3306,
  user: 'root',
  password: 'pt$+il7HRAllUsT3',
  database: 'games_mini_ecommerce'
});
