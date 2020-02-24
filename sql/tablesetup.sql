DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.db WHERE Db='test' OR Db='test_%';
CREATE DATABASE IF NOT EXISTS nova_prospekt;
CREATE USER nova@ENDPOINT IDENTIFIED BY 'MASTERpassword1199';
GRANT ALL PRIVILEGES ON nova_prospekt.* TO nova@ENDPOINT IDENTIFIED BY 'MASTERpassword1199';
FLUSH PRIVILEGES;
USE nova_prospekt;
CREATE TABLE IF NOT EXISTS users (
	idUsers int(11) NOT NULL AUTO_INCREMENT, 
	uidUsers tinytext NOT NULL, 
	firstUsers tinytext NOT NULL,
	lastUsers tinytext NOT NULL, 
	emailUsers tinytext NOT NULL, 
	pwdUsers longtext NOT NULL,
	login_countUsers int(11) NOT NULL DEFAULT 0, 
	last_loginUsers TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	sq1Users enum('What was your first car?','What primary school did you attend?','In what town or city was your first full time job?'),
	sa1Users longtext NOT NULL,
	sq2Users enum('In what town or city did you meet your spouse/partner?','What is the middle name of your oldest child?','In what town or city did your mother and father meet?'),
	sa2Users longtext NOT NULL,
	bdayUsers date NOT NULL,
	statusUsers enum('Inactive', 'Active') default 'Inactive', 
	PRIMARY KEY (idUsers)
);
CREATE TABLE IF NOT EXISTS login_history (
    id INT(11) NOT NULL AUTO_INCREMENT, 
    uidUsers tinytext NOT NULL,
    date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    userIP varbinary(16) NOT NULL,
    success ENUM('yes', 'no') NOT NULL DEFAULT 'no',
    PRIMARY KEY (id)
);
CREATE TABLE IF NOT EXISTS pwdReset (
    pwdResetId INT(11) NOT NULL AUTO_INCREMENT, 
    pwdResetEmail text NOT NULL,
    pwdResetSelector text NOT NULL,
    pwdResetToken longtext NOT NULL,
    pwdResetExpires text NOT NULL,
    PRIMARY KEY (pwdResetId)
);