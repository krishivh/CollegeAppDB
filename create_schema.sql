CREATE DATABASE new_schema
    DEFAULT CHARACTER SET utf8mb4
    DEFAULT COLLATE utf8mb4_0900_ai_ci;

USE new_schema;

-- User Table
CREATE TABLE `User` (
  `userID` int NOT NULL AUTO_INCREMENT,
  `firstName` varchar(40) NOT NULL,
  `lastName` varchar(40) NOT NULL,
  `email` varchar(40) NOT NULL,
  `phone` varchar(10) NOT NULL,
  `password` varchar(40) NOT NULL,
  `highSchool` varchar(40) NOT NULL,
  `GPA` float NOT NULL,
  PRIMARY KEY (`userID`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Colleges Table
CREATE TABLE `Colleges` (
  `collegeID` int NOT NULL AUTO_INCREMENT,
  `name` varchar(60) NOT NULL,
  `location` varchar(40) NOT NULL,
  `yearFounded` int NOT NULL,
  `averageGPA` float NOT NULL,
  `userID` int NOT NULL,
  PRIMARY KEY (`collegeID`),
  KEY `fk_college_userID` (`userID`),
  CONSTRAINT `fk_college_userID` FOREIGN KEY (`userID`) REFERENCES `User` (`userID`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Applications Table
CREATE TABLE `Applications` (
  `applicationID` int NOT NULL AUTO_INCREMENT,
  `submissionStatus` varchar(40) NOT NULL,
  `applicationDeadline` date NOT NULL,
  `userID` int NOT NULL,
  `applicationType` varchar(40) NOT NULL,
  `collegeName` varchar(45) NOT NULL,
  PRIMARY KEY (`applicationID`),
  KEY `userID_idx` (`userID`),
  CONSTRAINT `fk_app_userID` FOREIGN KEY (`userID`) REFERENCES `User` (`userID`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Tasks Table
CREATE TABLE `Tasks` (
  `taskID` int NOT NULL AUTO_INCREMENT,
  `taskName` varchar(200) NOT NULL,
  `dueDate` date NOT NULL,
  `userID` int NOT NULL,
  PRIMARY KEY (`taskID`),
  KEY `UserID_idx` (`userID`),
  CONSTRAINT `UserID` FOREIGN KEY (`userID`) REFERENCES `User` (`userID`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
