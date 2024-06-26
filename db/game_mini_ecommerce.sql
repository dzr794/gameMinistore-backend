drop database games_mini_ecommerce;
CREATE database games_mini_ecommerce;

use games_mini_ecommerce;

# show tables;


CREATE TABLE Games (
	id int PRIMARY KEY AUTO_INCREMENT NOT NULL,
	title varchar(255) NOT NULL,
	price float,
    publisherId int NOT NULL,
    publisherName varchar(255) NOT NULL,
    ESRB_ratingId int NOT NULL,
    ESRB_ratingName varchar(255) NOT NULL,
    imgLink varchar(1000)
);

CREATE INDEX gamePrice_idx
ON Games(price);

CREATE TABLE HighlightedGames (
	gameId int PRIMARY KEY NOT NULL,
    lastUpdatedDate datetime DEFAULT CURRENT_TIMESTAMP NOT NULL
);

CREATE TABLE ESRB (
	id int PRIMARY KEY AUTO_INCREMENT NOT NULL,
    name varchar(255) NOT NULL,
	description varchar(450)
);

CREATE TABLE Publishers (
	id int PRIMARY KEY AUTO_INCREMENT NOT NULL,
    name varchar(255) NOT NULL
);

CREATE TABLE Genres (
	id int PRIMARY KEY AUTO_INCREMENT NOT NULL,
    name varchar(255) NOT NULL
);

CREATE TABLE Users (
	id int PRIMARY KEY AUTO_INCREMENT,
	displayName varchar(255) NOT NULL,
	email varchar(255) NOT NULL,
	password varchar(255) NOT NULL,
    userSince datetime DEFAULT CURRENT_TIMESTAMP NOT NULL
);

CREATE TABLE Roles (
	id int PRIMARY KEY AUTO_INCREMENT,
    name varchar(255) NOT NULL
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

CREATE TABLE Game_Genre_relations (
    genreId int NOT NULL,
    gameId int NOT NULL,
    PRIMARY KEY (genreId, gameId)
);

CREATE TABLE User_Role_relations (
	userId int NOT NULL,
    roleId int NOT NULL DEFAULT 1,
    PRIMARY KEY (userId)
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
    
ALTER TABLE HighlightedGames
ADD CONSTRAINT fk_GameId
	FOREIGN KEY (gameID)
    REFERENCES Games (id)
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
    
ALTER TABLE Game_Genre_relations
ADD CONSTRAINT fk_GG_Game
    FOREIGN KEY (gameId)
    REFERENCES Games (id)
    ON DELETE CASCADE;

ALTER TABLE Game_Genre_relations
ADD CONSTRAINT fk_GG_Genre
    FOREIGN KEY (genreId)
    REFERENCES Genres (id)
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

ALTER TABLE User_Role_relations
ADD CONSTRAINT fk_UR_User
    FOREIGN KEY (userId)
    REFERENCES Users (id)
    ON DELETE CASCADE;

ALTER TABLE User_Role_relations
ADD CONSTRAINT fk_UR_Role
    FOREIGN KEY (roleId)
    REFERENCES Roles (id)
    ON DELETE CASCADE;


# user with role name view
CREATE VIEW user_with_role as 
	SELECT u.id as userId, u.displayName as userName, r.id as roleId, r.name as roleName 
    FROM User_Role_relations as URr 
    INNER JOIN Users as u on u.id = URr.userId 
    INNER JOIN Roles as r on r.id = URr.roleId;

# highlighted games with details
CREATE VIEW HighlightedGamesDetails as
	SELECT g.id, g.title, g.price, g.publisherName as publisher, g.ESRB_ratingName as ESRB, imgLink as image, h.lastUpdatedDate
    FROM  HighlightedGames as h
    INNER JOIN Games as g on g.id =  h.gameId
    ORDER BY h.lastUpdatedDate DESC
    LIMIT 5;

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
(NULL, "Mochi", "mochi@gmail.com", "5om3th!ng3nCryPt3d"),
(NULL, "Abril", "abril@gmail.com", "5om3th!ng3nCryPt3d"),
(NULL, "Gogi", "gogi@gmail.com", "5om3th!ng3nCryPt3d"),
(NULL, "Sombra", "sombra@gmail.com", "5om3th!ng3nCryPt3d"),
(NULL, "Kujimi", "kujimi@gmail.com", "5om3th!ng3nCryPt3d"),
(NULL, "Mananjus", "mananjus@gmail.com", "5om3th!ng3nCryPt3d");

INSERT INTO Roles (name) VALUES
('user'),
('admin');

INSERT INTO Publishers (id, name) VALUES
(NULL, "Annapurna Interactive"),
(NULL, "Psyonix"),
(NULL, "Sony Interactive Entertainment"),
(NULL, "Electronic Arts"),
(NULL, "Capcom"),
(NULL, "Bandai Namco Entertainment"),
(NULL, "Larian Studios");

INSERT INTO Games (id, title, price, publisherId, publisherName, ESRB_ratingId, ESRB_ratingName, imgLink) VALUES
(NULL, "What Remains of Edith Finch", 19.99 , 1, 'Annapurna Interactive', 3, 'Teen', 'https://dbxce1spal1df.cloudfront.net/018d937f-00e8-729d-a917-e2f1d5bcc95d/boxart.jpg'),
(NULL, "Rocket League", 0 , 2, 'Psyonix', 2, 'Everyone 10+', 'https://dbxce1spal1df.cloudfront.net/018d937f-0a42-73de-a3a3-e7a08bc728b2/boxart.jpg'),
(NULL, "Apex Legends", 0 , 4, 'Electronic Arts', 3, 'Teen', 'https://dbxce1spal1df.cloudfront.net/018d937f-0ddf-7119-9337-aa96d8a36d39/boxart.jpg'),
(NULL, "Monster Hunter World", 29.99 , 5, 'Capcom', 3, 'Teen', 'https://dbxce1spal1df.cloudfront.net/018d937e-fd94-7238-a99b-14457502670c/boxart.jpg'),
(NULL, "Helldivers 2", 29.99 , 3, 'Sony Interactive Entertainment', 4, 'Mature 17+', 'https://dbxce1spal1df.cloudfront.net/018d937f-6ee4-73f5-858c-2fde3407462f/boxart.jpg'),
(NULL, "Baldur's Gate 3", 59.99 , 7, 'Larian Studios', 4, 'Mature 17+', 'https://dbxce1spal1df.cloudfront.net/018d9584-24d6-7010-b82b-df1f0b154cc7/boxart.jpg'),
(NULL, "Outer Wilds", 24.99 , 1, 'Annapurna Interactive', 2, 'Everyone 10+', 'https://dbxce1spal1df.cloudfront.net/018d937f-09dd-729b-88aa-5496f800b3bd/boxart.jpg'),
(NULL, "Elden Ring", 59.99 , 6, 'Bandai Namco Entertainment', 3, 'Teen', 'https://dbxce1spal1df.cloudfront.net/018d937f-590c-728b-ac35-38bcff85f086/boxart.jpg');

INSERT INTO HighlightedGames (gameId) VALUES
(1),
(4),
(5),
(7),
(8);

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

INSERT INTO User_Role_relations (userId, roleId) VALUES
(1,1),
(2,1),
(3,1),
(4,2),
(5,1),
(6,1);



# SELECT * FROM ESRB;
# SELECT * FROM Users;
# SELECT * FROM Publishers;
# SELECT * FROM Games;
SELECT * FROM HighlightedGamesDetails;
# INSERT INTO HighlightedGames (gameId) VALUES (6);
# SELECT * FROM Orders;
# SELECT * FROM order_game_relations;
# SELECT * FROM game_user_relations;
# SELECT * FROM User_Role_relations;
# SELECT * from Genres;

# SELECT * FROM user_with_role ORDER BY roleId desc;

# get 5 highlighted games


# get all free games
# SELECT id, title, price, publisherName as publisher, ESRB_ratingName as ESRB, imgLink as image FROM games WHERE price = 0 ;

# get all games that cost less than 30USD
# SELECT title, price, publisherName as publisher, ESRB_ratingName FROM Games where price < 30;

# get all games that cost between 20 and 60USD
# SELECT * FROM Games where price > 20 AND price < 60;

#get all genres from game


# get all games from x user
# SELECT u.id as userId, u.displayName, g.id as gameId, g.title as gameTitle FROM game_user_relations as GUr INNER JOIN Games as g on g.id = GUr.gameId INNER JOIN Users as u on u.id = GUr.userId WHERE userId = 2;
# SELECT g.title, g.publisher, g.ESRB_rating FROM game_user_relations as r INNER JOIN GamesWithInfo as g on g.id = r.gameid WHERE userid = 2;


# show indexes from games;