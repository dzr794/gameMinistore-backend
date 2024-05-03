CREATE database games_mini_ecommerce;

use games_mini_ecommerce;

# show tables;
# drop database games_mini_ecommerce;

CREATE TABLE Games (
	id int PRIMARY KEY AUTO_INCREMENT NOT NULL,
	title varchar(255) NOT NULL,
	price float,
    publisherId int NOT NULL,
    publisherName varchar(255) NOT NULL,
    ESRB_ratingId int NOT NULL,
    ESRB_ratingName varchar(255) NOT NULL
);

CREATE INDEX gamePrice_idx
ON Games(price);

CREATE TABLE ESRB (
	id int PRIMARY KEY AUTO_INCREMENT NOT NULL,
    name varchar(255) NOT NULL,
	description varchar(450)
);

CREATE TABLE Publishers (
	id int PRIMARY KEY AUTO_INCREMENT NOT NULL,
    name varchar(255) NOT NULL
);

CREATE TABLE Users (
	id int PRIMARY KEY AUTO_INCREMENT,
	displayName varchar(255) NOT NULL,
	email varchar(255),
	password varchar(255) NOT NULL,
    userSince datetime DEFAULT CURRENT_TIMESTAMP NOT NULL
);

CREATE TABLE Orders (
	id int PRIMARY KEY AUTO_INCREMENT NOT NULL,
    userId int NOT NULL,
    totalPrice float NOT NULL,
    orderDate datetime DEFAULT CURRENT_TIMESTAMP NOT NULL
);

CREATE TABLE Order_Game_relations (
    orderId int NOT NULL,
    gameId int NOT NULL,
    PRIMARY KEY (orderId, gameId)
);

CREATE TABLE Game_User_relations (
    userId int NOT NULL,
    gameId int NOT NULL,
    PRIMARY KEY (userId, gameId)
);

ALTER TABLE Games
ADD CONSTRAINT fk_GameESRB
    FOREIGN KEY (ESRB_ratingId)
    REFERENCES ESRB (id)
    ON DELETE CASCADE;
    
ALTER TABLE Games
ADD CONSTRAINT fk_GamePublisher
    FOREIGN KEY (publisherId)
    REFERENCES Publishers (id)
    ON DELETE CASCADE;
    
ALTER TABLE Orders
ADD CONSTRAINT fk_OrderUser
    FOREIGN KEY (userId)
    REFERENCES Users (id)
    ON DELETE CASCADE;
    
ALTER TABLE Order_Game_relations
ADD CONSTRAINT fk_OG_Order
    FOREIGN KEY (orderId)
    REFERENCES Orders (id)
    ON DELETE CASCADE;
    
ALTER TABLE Order_Game_relations
ADD CONSTRAINT fk_OG_Game
    FOREIGN KEY (gameId)
    REFERENCES Games (id)
    ON DELETE CASCADE;

ALTER TABLE Game_User_relations
ADD CONSTRAINT fk_GU_Game
    FOREIGN KEY (gameId)
    REFERENCES Games (id)
    ON DELETE CASCADE;
    
ALTER TABLE Game_User_relations
ADD CONSTRAINT fk_GU_User
    FOREIGN KEY (userId)
    REFERENCES Users (id)
    ON DELETE CASCADE;

#CREATE VIEW GamesWithInfo AS
#SELECT Games.id, title, price,
#p.name AS publisher, ESRB.name as 'ESRB_rating' FROM Games
#INNER JOIN Publishers as p
#ON Games.publisherId = p.id
#INNER JOIN ESRB
#ON Games.ESRB_ratingId = ESRB.id;

    
# Data insertion

INSERT INTO ESRB (id, name, description) VALUES
(NULL, "Everyone", "Content is generally suitable for all ages. May contain minimal cartoon, fantasy or mild violence and/or infrequent use of mild language."),
(NULL, "Everyone 10+", "Content is generally suitable for ages 10 and up. May contain more cartoon, fantasy or mild violence, mild language and/or minimal suggestive themes."),
(NULL, "Teen", "Content is generally suitable for ages 13 and up. May contain violence, suggestive themes, crude humor, minimal blood, simulated gambling and/or infrequent use of strong language."),
(NULL, "Mature 17+", "Content is generally suitable for ages 17 and up. May contain intense violence, blood and gore, sexual content and/or strong language."),
(NULL, "Adults Only 18+", "Content suitable only for adults ages 18 and up. May include prolonged scenes of intense violence, graphic sexual content and/or gambling with real currency."),
(NULL, "Rating Pending", "Not yet assigned a final ESRB rating. Appears only in advertising, marketing and promotional materials related to a physical (e.g., boxed) video game that is expected to carry an ESRB rating, and should be replaced by a game's rating once it has been assigned."),
(NULL, "Rating Pending — Likely Mature 17+", "Not yet assigned a final ESRB rating but anticipated to be rated Mature 17+. Appears only in advertising, marketing, and promotional materials related to a physical (e.g., boxed) video game that is expected to carry an ESRB rating, and should be replaced by a game's rating once it has been assigned.");

INSERT INTO Users (id, displayName, email, password) VALUES
(NULL, "mochi", "mochi@gmail.com", "5om3th!ng3nCryPt3d"),
(NULL, "abril", "abril@gmail.com", "5om3th!ng3nCryPt3d"),
(NULL, "gogi", "gogi@gmail.com", "5om3th!ng3nCryPt3d"),
(NULL, "sombra", "sombra@gmail.com", "5om3th!ng3nCryPt3d"),
(NULL, "kujimi", "kujimi@gmail.com", "5om3th!ng3nCryPt3d"),
(NULL, "mananjus", "mananjus@gmail.com", "5om3th!ng3nCryPt3d");

INSERT INTO Publishers (id, name) VALUES
(NULL, "Annapurna Interactive"),
(NULL, "Psyonix"),
(NULL, "Sony Interactive Entertainment"),
(NULL, "Electronic Arts"),
(NULL, "Capcom"),
(NULL, "Bandai Namco Entertainment"),
(NULL, "Larian Studios");

INSERT INTO Games (id, title, price, publisherId, publisherName, ESRB_ratingId, ESRB_ratingName) VALUES
(NULL, "What Remains of Edith Finch", 19.99 , 1, 'Annapurna Interactive', 3, 'Teen'),
(NULL, "Rocket League", 0 , 2, 'Psyonix', 2, 'Everyone 10+'),
(NULL, "Apex Legends", 0 , 4, 'Electronic Arts', 3, 'Teen'),
(NULL, "Monster Hunter World", 29.99 , 1, 'Annapurna Interactive', 3, 'Teen'),
(NULL, "Helldivers 2", 29.99 , 1, 'Annapurna Interactive', 4, 'Mature 17+'),
(NULL, "Baldur's Gate 3", 59.99 , 7, 'Larian Studios', 4, 'Mature 17+'),
(NULL, "Outer Wilds", 24.99 , 1, 'Annapurna Interactive', 2, 'Everyone 10+'),
(NULL, "Elden Ring", 59.99 , 6, 'Bandai Namco Entertainment', 3, 'Teen');

INSERT INTO Orders (userId, totalPrice) VALUES
(1, 89.98),
(2, 0),
(1, 29.99),
(3, 29.99),
(5, 59.99),
(4, 109.98),
(2, 24.99);

INSERT INTO Order_Game_relations (orderId, gameId) VALUES
(1, 7),
(1, 8),
(2, 2),
(2, 3),
(3, 4),
(4, 5),
(5, 6),
(6, 6),
(6, 8),
(7, 7);

INSERT INTO Game_User_relations (userId, gameId) VALUES
(1, 7),
(1, 8),
(1, 4),
(2, 2),
(2, 3),
(2, 7),
(3, 5),
(4, 6),
(4, 8),
(5, 6);

# SELECT * FROM ESRB;
# SELECT * FROM Users;
# SELECT * FROM Publishers;
# SELECT * FROM Games;
# SELECT * FROM GamesWithInfo order by id;
# SELECT * FROM Orders;
# SELECT * FROM order_game_relations;
# SELECT * FROM game_user_relations;

# get all free games
# SELECT * FROM GamesWithInfo where price = 0;
# SELECT title, price, publisherName as publisher, ESRB_ratingName as ESRB FROM Games where price = 0;

# get all games that cost less than 30USD
# SELECT title, price, publisherName as publisher, ESRB_ratingName FROM Games where price < 30;

# get all games that cost between 20 and 60USD
# SELECT * FROM Games where price > 20 AND price < 60;

# get all games from x user
# SELECT g.title, g.publisher, g.ESRB_rating FROM game_user_relations as r INNER JOIN GamesWithInfo as g on g.id = r.gameid WHERE userid = 2;

# INSERT new game


show indexes from games;