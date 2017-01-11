-- MySQL Script generated by MySQL Workbench
-- 01/11/17 01:05:41
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema esit
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `esit` ;

-- -----------------------------------------------------
-- Schema esit
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `esit` DEFAULT CHARACTER SET utf8 ;
USE `esit` ;

-- -----------------------------------------------------
-- Table `esit`.`Address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `esit`.`Address` ;

CREATE TABLE IF NOT EXISTS `esit`.`Address` (
  `addressId` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `street` VARCHAR(50) NOT NULL,
  `unit` VARCHAR(10) NULL,
  `city` VARCHAR(80) NOT NULL,
  `province` VARCHAR(30) NOT NULL,
  `postalCode` VARCHAR(6) NOT NULL,
  PRIMARY KEY (`addressId`),
  UNIQUE INDEX `addressId_UNIQUE` (`addressId` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `esit`.`Employee`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `esit`.`Employee` ;

CREATE TABLE IF NOT EXISTS `esit`.`Employee` (
  `employeeId` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `firstName` VARCHAR(50) NOT NULL,
  `lastName` VARCHAR(50) NOT NULL,
  `email` VARCHAR(50) NOT NULL,
  `homePhone` VARCHAR(15) NULL,
  `cellPhone` VARCHAR(15) NULL,
  `hireDate` DATE NOT NULL,
  `isActive` TINYINT(1) NOT NULL,
  `password` VARCHAR(30) NOT NULL,
  `role` VARCHAR(20) NOT NULL,
  `addressId` INT UNSIGNED NULL,
  PRIMARY KEY (`employeeId`),
  UNIQUE INDEX `employeeId_UNIQUE` (`employeeId` ASC),
  INDEX `fk_employee_address_idx` (`addressId` ASC),
  CONSTRAINT `fk_employee_address`
    FOREIGN KEY (`addressId`)
    REFERENCES `esit`.`Address` (`addressId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `esit`.`Program`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `esit`.`Program` ;

CREATE TABLE IF NOT EXISTS `esit`.`Program` (
  `programId` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `programName` VARCHAR(50) NOT NULL,
  `description` VARCHAR(250) NOT NULL,
  `price` DECIMAL NOT NULL,
  PRIMARY KEY (`programId`),
  UNIQUE INDEX `programId_UNIQUE` (`programId` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `esit`.`Customer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `esit`.`Customer` ;

CREATE TABLE IF NOT EXISTS `esit`.`Customer` (
  `customerId` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `firstName` VARCHAR(50) NOT NULL,
  `lastName` VARCHAR(50) NOT NULL,
  `email` VARCHAR(50) NOT NULL,
  `homePhone` VARCHAR(25) NULL,
  `cellPhone` VARCHAR(25) NULL,
  `enbridgeNum` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`customerId`),
  UNIQUE INDEX `customerId_UNIQUE` (`customerId` ASC),
  UNIQUE INDEX `enbridgeNum_UNIQUE` (`enbridgeNum` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `esit`.`Sale`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `esit`.`Sale` ;

CREATE TABLE IF NOT EXISTS `esit`.`Sale` (
  `saleId` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `customer` INT UNSIGNED NOT NULL,
  `salesRepId` INT UNSIGNED NULL,
  `program` INT UNSIGNED NULL,
  `rentalAgreement` VARCHAR(2083) NULL,
  `PADForm` VARCHAR(2083) NULL,
  `dateSigned` DATE NULL,
  `installationDateTime` DATETIME NULL,
  `notes` VARCHAR(300) NULL,
  `status` VARCHAR(50) NULL,
  `envelopeId` VARCHAR(36) NULL,
  `folderId` VARCHAR(20) NULL,
  PRIMARY KEY (`saleId`),
  UNIQUE INDEX `saleId_UNIQUE` (`saleId` ASC),
  INDEX `salesRep_idx` (`salesRepId` ASC),
  INDEX `program_idx` (`program` ASC),
  INDEX `customer_idx` (`customer` ASC),
  CONSTRAINT `fk_sale_employee`
    FOREIGN KEY (`salesRepId`)
    REFERENCES `esit`.`Employee` (`employeeId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sale_program`
    FOREIGN KEY (`program`)
    REFERENCES `esit`.`Program` (`programId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sale_customer`
    FOREIGN KEY (`customer`)
    REFERENCES `esit`.`Customer` (`customerId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `esit`.`Installation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `esit`.`Installation` ;

CREATE TABLE IF NOT EXISTS `esit`.`Installation` (
  `installationId` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `installer` INT UNSIGNED NOT NULL,
  `sale` INT UNSIGNED NOT NULL,
  `installationCert` VARCHAR(2083) NULL,
  `installationDateTime` DATETIME NULL,
  `status` VARCHAR(50) NOT NULL,
  `notes` VARCHAR(300) NULL,
  `envelopeId` VARCHAR(36) NULL,
  `folderId` VARCHAR(20) NULL,
  PRIMARY KEY (`installationId`),
  UNIQUE INDEX `instalationId_UNIQUE` (`installationId` ASC),
  INDEX `sale_idx` (`sale` ASC),
  INDEX `installer_idx` (`installer` ASC),
  CONSTRAINT `fk_installation_sale`
    FOREIGN KEY (`sale`)
    REFERENCES `esit`.`Sale` (`saleId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_installation_employee`
    FOREIGN KEY (`installer`)
    REFERENCES `esit`.`Employee` (`employeeId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `esit`.`Product`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `esit`.`Product` ;

CREATE TABLE IF NOT EXISTS `esit`.`Product` (
  `productId` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `productName` VARCHAR(50) NOT NULL,
  `productNumber` VARCHAR(50) NOT NULL,
  `serialNumberDetails` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`productId`),
  UNIQUE INDEX `productId_UNIQUE` (`productId` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `esit`.`Property`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `esit`.`Property` ;

CREATE TABLE IF NOT EXISTS `esit`.`Property` (
  `propertyId` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `address` INT UNSIGNED NULL,
  `customer` INT UNSIGNED NULL,
  `sqFootage` INT NULL,
  `bathrooms` INT NULL,
  `residents` INT NULL,
  `hasPool` TINYINT(1) NULL,
  PRIMARY KEY (`propertyId`),
  UNIQUE INDEX `propertyId_UNIQUE` (`propertyId` ASC),
  UNIQUE INDEX `address_UNIQUE` (`address` ASC),
  INDEX `fk_property_customer_idx` (`customer` ASC),
  CONSTRAINT `fk_property_address`
    FOREIGN KEY (`address`)
    REFERENCES `esit`.`Address` (`addressId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_property_customer`
    FOREIGN KEY (`customer`)
    REFERENCES `esit`.`Customer` (`customerId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `esit`.`ProgramProduct`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `esit`.`ProgramProduct` ;

CREATE TABLE IF NOT EXISTS `esit`.`ProgramProduct` (
  `program` INT UNSIGNED NOT NULL,
  `product` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`program`, `product`),
  INDEX `product_idx` (`product` ASC),
  CONSTRAINT `fk_program_programProduct`
    FOREIGN KEY (`program`)
    REFERENCES `esit`.`Program` (`programId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_product_programProduct`
    FOREIGN KEY (`product`)
    REFERENCES `esit`.`Product` (`productId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `esit`.`Address`
-- -----------------------------------------------------
START TRANSACTION;
USE `esit`;
INSERT INTO `esit`.`Address` (`addressId`, `street`, `unit`, `city`, `province`, `postalCode`) VALUES (1, '70 The Pond Road', NULL, 'North York', 'ON', 'M3J3M6');
INSERT INTO `esit`.`Address` (`addressId`, `street`, `unit`, `city`, `province`, `postalCode`) VALUES (2, '25 Avenue Road', '301', 'Toronto', 'ON', 'M5R1A8');
INSERT INTO `esit`.`Address` (`addressId`, `street`, `unit`, `city`, `province`, `postalCode`) VALUES (3, '7191 Yonge Street', '21A', 'Markham', 'ON', 'L4J1V7');
INSERT INTO `esit`.`Address` (`addressId`, `street`, `unit`, `city`, `province`, `postalCode`) VALUES (4, '9855 Jane Street', NULL, 'Maple', 'ON', 'L6A3N9');
INSERT INTO `esit`.`Address` (`addressId`, `street`, `unit`, `city`, `province`, `postalCode`) VALUES (5, '980 Steeles Avenue West', '251', 'Etobicoke', 'ON', 'M9W6Y3');

COMMIT;


-- -----------------------------------------------------
-- Data for table `esit`.`Employee`
-- -----------------------------------------------------
START TRANSACTION;
USE `esit`;
INSERT INTO `esit`.`Employee` (`employeeId`, `firstName`, `lastName`, `email`, `homePhone`, `cellPhone`, `hireDate`, `isActive`, `password`, `role`, `addressId`) VALUES (1, 'administrator', 'administrator', 'administrator@esit.com', '647-244-7718', '647-244-7718', '2016-10-19', true, 'Passw0rd!', 'admin', 1);
INSERT INTO `esit`.`Employee` (`employeeId`, `firstName`, `lastName`, `email`, `homePhone`, `cellPhone`, `hireDate`, `isActive`, `password`, `role`, `addressId`) VALUES (2, 'Todd', 'Burgess', 'todd@filterbutler.com', '647-625-8277', '647-625-8277', '2016-10-19', true, 'Passw0rd!', 'manager', 2);
INSERT INTO `esit`.`Employee` (`employeeId`, `firstName`, `lastName`, `email`, `homePhone`, `cellPhone`, `hireDate`, `isActive`, `password`, `role`, `addressId`) VALUES (3, 'Thyrone', 'Cameron', 'thyrone@filterbutler.com', '905-621-1225', '905-621-1225', '2016-10-19', true, 'Passw0rd!', 'salesperson', 3);
INSERT INTO `esit`.`Employee` (`employeeId`, `firstName`, `lastName`, `email`, `homePhone`, `cellPhone`, `hireDate`, `isActive`, `password`, `role`, `addressId`) VALUES (4, 'Nazeem', 'Mohammed', 'nazeem@filterbutler.com', '416-121-9928', '416-121-9928', '2016-10-19', true, 'Passw0rd!', 'installer', 4);
INSERT INTO `esit`.`Employee` (`employeeId`, `firstName`, `lastName`, `email`, `homePhone`, `cellPhone`, `hireDate`, `isActive`, `password`, `role`, `addressId`) VALUES (5, 'Ivan', 'Medunic', 'ivan@filterbutler.com', '647-627-4411', '647-627-4411', '2016-10-19', true, 'Passw0rd!', 'installer', 5);
INSERT INTO `esit`.`Employee` (`employeeId`, `firstName`, `lastName`, `email`, `homePhone`, `cellPhone`, `hireDate`, `isActive`, `password`, `role`, `addressId`) VALUES (6, 'Daniel', 'MacDonald', 'daniel@filterbutler.com', '905-819-4371', '905-819-4371', '2016-10-19', true, 'Passw0rd!', 'salesperson', 1);
INSERT INTO `esit`.`Employee` (`employeeId`, `firstName`, `lastName`, `email`, `homePhone`, `cellPhone`, `hireDate`, `isActive`, `password`, `role`, `addressId`) VALUES (7, 'Chad', 'Pilkey', 'chad@filterbutler.com', '416-647-2318', '416-647-2318', '2016-10-19', true, 'Passw0rd!', 'installer', 2);
INSERT INTO `esit`.`Employee` (`employeeId`, `firstName`, `lastName`, `email`, `homePhone`, `cellPhone`, `hireDate`, `isActive`, `password`, `role`, `addressId`) VALUES (8, 'Danny', 'Perrone', 'danny@filterbutler.com', '416-285-1584', '416-285-1584', '2016-10-19', true, 'Passw0rd!', 'salesperson', 3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `esit`.`Program`
-- -----------------------------------------------------
START TRANSACTION;
USE `esit`;
INSERT INTO `esit`.`Program` (`programId`, `programName`, `description`, `price`) VALUES (1, 'Whole Home Filter', 'Filter + Bottling Kit', 34.95);
INSERT INTO `esit`.`Program` (`programId`, `programName`, `description`, `price`) VALUES (2, 'Whole Home Descaler', 'D-Scaler + Bottling Kit', 34.95);
INSERT INTO `esit`.`Program` (`programId`, `programName`, `description`, `price`) VALUES (3, 'Whole Home Combo', 'Filter + D-Scaler + Bottling Kit', 54.90);

COMMIT;


-- -----------------------------------------------------
-- Data for table `esit`.`Customer`
-- -----------------------------------------------------
START TRANSACTION;
USE `esit`;
INSERT INTO `esit`.`Customer` (`customerId`, `firstName`, `lastName`, `email`, `homePhone`, `cellPhone`, `enbridgeNum`) VALUES (1, 'Matthew', 'Marangoni', 'matt@esit.com', '905-664-2241', '905-782-1547', '1234567890');
INSERT INTO `esit`.`Customer` (`customerId`, `firstName`, `lastName`, `email`, `homePhone`, `cellPhone`, `enbridgeNum`) VALUES (2, 'Klever', 'Loza Vega', 'klever@esit.com', '514-222-8713', '647-238-5564', '1237687612');
INSERT INTO `esit`.`Customer` (`customerId`, `firstName`, `lastName`, `email`, `homePhone`, `cellPhone`, `enbridgeNum`) VALUES (3, 'Oleksandr', 'Zhurbenko', 'alex@esit.com', '647-899-6651', '416-152-9911', '8723772636');
INSERT INTO `esit`.`Customer` (`customerId`, `firstName`, `lastName`, `email`, `homePhone`, `cellPhone`, `enbridgeNum`) VALUES (4, 'Emile', 'Ohan', 'emile.ohan@esit.com', '416-782-6214', '416-627-9918', '2263774929');
INSERT INTO `esit`.`Customer` (`customerId`, `firstName`, `lastName`, `email`, `homePhone`, `cellPhone`, `enbridgeNum`) VALUES (5, 'Mohamed', 'Kassim', 'mohamed.kassim@esit.com', '647-778-8825', '514-662-8277', '1237792888');

COMMIT;


-- -----------------------------------------------------
-- Data for table `esit`.`Sale`
-- -----------------------------------------------------
START TRANSACTION;
USE `esit`;
INSERT INTO `esit`.`Sale` (`saleId`, `customer`, `salesRepId`, `program`, `rentalAgreement`, `PADForm`, `dateSigned`, `installationDateTime`, `notes`, `status`, `envelopeId`, `folderId`) VALUES (1, 1, 3, 2, NULL, NULL, '2016-09-20', '2016-09-22 08:00:00', 'Won\'t be available next week', 'Finished', NULL, NULL);
INSERT INTO `esit`.`Sale` (`saleId`, `customer`, `salesRepId`, `program`, `rentalAgreement`, `PADForm`, `dateSigned`, `installationDateTime`, `notes`, `status`, `envelopeId`, `folderId`) VALUES (2, 3, 6, 1, NULL, NULL, '2016-09-12', '2016-09-23 11:00:00', 'Can\'t do any work after 6:00 PM', 'Finished', NULL, NULL);
INSERT INTO `esit`.`Sale` (`saleId`, `customer`, `salesRepId`, `program`, `rentalAgreement`, `PADForm`, `dateSigned`, `installationDateTime`, `notes`, `status`, `envelopeId`, `folderId`) VALUES (3, 2, 8, 3, NULL, NULL, '2016-10-21', '2016-10-23 09:00:00', 'Wants to see the presentation first', 'Finished', NULL, NULL);
INSERT INTO `esit`.`Sale` (`saleId`, `customer`, `salesRepId`, `program`, `rentalAgreement`, `PADForm`, `dateSigned`, `installationDateTime`, `notes`, `status`, `envelopeId`, `folderId`) VALUES (4, 5, 3, 1, NULL, NULL, '2016-09-15', '2016-09-28 10:30:00', 'Changed their mind', 'Finished', NULL, NULL);
INSERT INTO `esit`.`Sale` (`saleId`, `customer`, `salesRepId`, `program`, `rentalAgreement`, `PADForm`, `dateSigned`, `installationDateTime`, `notes`, `status`, `envelopeId`, `folderId`) VALUES (5, 4, 6, 3, NULL, NULL, '2017-01-01', '2016-09-29 10:30:00', '', 'Cancelled', NULL, NULL);
INSERT INTO `esit`.`Sale` (`saleId`, `customer`, `salesRepId`, `program`, `rentalAgreement`, `PADForm`, `dateSigned`, `installationDateTime`, `notes`, `status`, `envelopeId`, `folderId`) VALUES (6, 1, 3, 1, NULL, NULL, '2017-01-02', '2017-09-29 10:30:00', '', 'Created', NULL, NULL);
INSERT INTO `esit`.`Sale` (`saleId`, `customer`, `salesRepId`, `program`, `rentalAgreement`, `PADForm`, `dateSigned`, `installationDateTime`, `notes`, `status`, `envelopeId`, `folderId`) VALUES (7, 2, 6, 2, NULL, NULL, '2017-01-03', '2017-09-28 10:30:00', NULL, 'Signed', NULL, NULL);
INSERT INTO `esit`.`Sale` (`saleId`, `customer`, `salesRepId`, `program`, `rentalAgreement`, `PADForm`, `dateSigned`, `installationDateTime`, `notes`, `status`, `envelopeId`, `folderId`) VALUES (8, 3, 8, 3, NULL, NULL, '2017-01-04', '2017-10-23 09:00:00', NULL, 'Paid', NULL, NULL);
INSERT INTO `esit`.`Sale` (`saleId`, `customer`, `salesRepId`, `program`, `rentalAgreement`, `PADForm`, `dateSigned`, `installationDateTime`, `notes`, `status`, `envelopeId`, `folderId`) VALUES (9, 4, 3, 1, NULL, NULL, '2017-01-05', '2017-09-23 11:00:00', NULL, 'Created', NULL, NULL);
INSERT INTO `esit`.`Sale` (`saleId`, `customer`, `salesRepId`, `program`, `rentalAgreement`, `PADForm`, `dateSigned`, `installationDateTime`, `notes`, `status`, `envelopeId`, `folderId`) VALUES (10, 1, 6, 1, NULL, NULL, '2017-01-06', '2017-01-11 11:00:00', NULL, 'Finished', NULL, NULL);
INSERT INTO `esit`.`Sale` (`saleId`, `customer`, `salesRepId`, `program`, `rentalAgreement`, `PADForm`, `dateSigned`, `installationDateTime`, `notes`, `status`, `envelopeId`, `folderId`) VALUES (11, 2, 8, 2, NULL, NULL, '2017-01-02', '2017-01-15 11:00:00', NULL, 'Finished', NULL, NULL);
INSERT INTO `esit`.`Sale` (`saleId`, `customer`, `salesRepId`, `program`, `rentalAgreement`, `PADForm`, `dateSigned`, `installationDateTime`, `notes`, `status`, `envelopeId`, `folderId`) VALUES (12, 3, 3, 3, NULL, NULL, '2017-01-03', '2017-01-20 11:00:00', NULL, 'Finished', NULL, NULL);
INSERT INTO `esit`.`Sale` (`saleId`, `customer`, `salesRepId`, `program`, `rentalAgreement`, `PADForm`, `dateSigned`, `installationDateTime`, `notes`, `status`, `envelopeId`, `folderId`) VALUES (13, 4, 6, 1, NULL, NULL, '2017-01-04', '2017-01-30 11:00:00', NULL, 'Finished', NULL, NULL);
INSERT INTO `esit`.`Sale` (`saleId`, `customer`, `salesRepId`, `program`, `rentalAgreement`, `PADForm`, `dateSigned`, `installationDateTime`, `notes`, `status`, `envelopeId`, `folderId`) VALUES (14, 5, 8, 2, NULL, NULL, '2017-01-05', '2017-01-25 11:00:00', NULL, 'Finished', NULL, NULL);
INSERT INTO `esit`.`Sale` (`saleId`, `customer`, `salesRepId`, `program`, `rentalAgreement`, `PADForm`, `dateSigned`, `installationDateTime`, `notes`, `status`, `envelopeId`, `folderId`) VALUES (15, 1, 3, 3, NULL, NULL, '2017-01-07', '2017-01-28 11:00:00', NULL, 'Finished', NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `esit`.`Installation`
-- -----------------------------------------------------
START TRANSACTION;
USE `esit`;
INSERT INTO `esit`.`Installation` (`installationId`, `installer`, `sale`, `installationCert`, `installationDateTime`, `status`, `notes`, `envelopeId`, `folderId`) VALUES (1, 4, 3, '', '2016-09-29 10:30:00', 'Completed', 'Everything went fine', NULL, NULL);
INSERT INTO `esit`.`Installation` (`installationId`, `installer`, `sale`, `installationCert`, `installationDateTime`, `status`, `notes`, `envelopeId`, `folderId`) VALUES (2, 5, 2, NULL, '2016-11-01 09:30:00', 'Completed', 'Customer lives in the garage, there is no pipes', NULL, NULL);
INSERT INTO `esit`.`Installation` (`installationId`, `installer`, `sale`, `installationCert`, `installationDateTime`, `status`, `notes`, `envelopeId`, `folderId`) VALUES (3, 7, 4, NULL, '2016-10-02 10:30:00', 'Cancelled', 'Customer changed his mind', NULL, NULL);
INSERT INTO `esit`.`Installation` (`installationId`, `installer`, `sale`, `installationCert`, `installationDateTime`, `status`, `notes`, `envelopeId`, `folderId`) VALUES (4, 5, 1, NULL, '2016-12-12 11:00:00', 'Completed', 'Needs more work than expected', NULL, NULL);
INSERT INTO `esit`.`Installation` (`installationId`, `installer`, `sale`, `installationCert`, `installationDateTime`, `status`, `notes`, `envelopeId`, `folderId`) VALUES (5, 4, 5, NULL, '2016-10-05 11:30:00', 'Completed', 'Customer is happy', NULL, NULL);
INSERT INTO `esit`.`Installation` (`installationId`, `installer`, `sale`, `installationCert`, `installationDateTime`, `status`, `notes`, `envelopeId`, `folderId`) VALUES (6, 5, 10, NULL, '2017-01-15 11:30:00', 'Scheduled', NULL, NULL, NULL);
INSERT INTO `esit`.`Installation` (`installationId`, `installer`, `sale`, `installationCert`, `installationDateTime`, `status`, `notes`, `envelopeId`, `folderId`) VALUES (7, 7, 11, NULL, '2017-01-25 11:30:00', 'Documented', NULL, NULL, NULL);
INSERT INTO `esit`.`Installation` (`installationId`, `installer`, `sale`, `installationCert`, `installationDateTime`, `status`, `notes`, `envelopeId`, `folderId`) VALUES (8, 5, 12, NULL, '2017-01-20 11:30:00', 'Installed', NULL, NULL, NULL);
INSERT INTO `esit`.`Installation` (`installationId`, `installer`, `sale`, `installationCert`, `installationDateTime`, `status`, `notes`, `envelopeId`, `folderId`) VALUES (9, 4, 13, NULL, '2017-01-17 11:30:00', 'Customer signed', NULL, NULL, NULL);
INSERT INTO `esit`.`Installation` (`installationId`, `installer`, `sale`, `installationCert`, `installationDateTime`, `status`, `notes`, `envelopeId`, `folderId`) VALUES (10, 7, 14, NULL, '2017-01-18 11:30:00', 'Installer signed', NULL, NULL, NULL);
INSERT INTO `esit`.`Installation` (`installationId`, `installer`, `sale`, `installationCert`, `installationDateTime`, `status`, `notes`, `envelopeId`, `folderId`) VALUES (11, 4, 15, NULL, '2017-01-29 11:30:00', 'Scheduled', NULL, NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `esit`.`Product`
-- -----------------------------------------------------
START TRANSACTION;
USE `esit`;
INSERT INTO `esit`.`Product` (`productId`, `productName`, `productNumber`, `serialNumberDetails`) VALUES (1, 'Whole Home Filter', '9810001', '17716820');
INSERT INTO `esit`.`Product` (`productId`, `productName`, `productNumber`, `serialNumberDetails`) VALUES (2, 'Whole Home D-Scaler', '9810002', '18812630');
INSERT INTO `esit`.`Product` (`productId`, `productName`, `productNumber`, `serialNumberDetails`) VALUES (3, 'Whole Home Combo', '9810003', '12392280');
INSERT INTO `esit`.`Product` (`productId`, `productName`, `productNumber`, `serialNumberDetails`) VALUES (4, 'Water Conservation System', '9810004', '12816370');
INSERT INTO `esit`.`Product` (`productId`, `productName`, `productNumber`, `serialNumberDetails`) VALUES (5, 'Installation Kit', '9810005', '12399840');
INSERT INTO `esit`.`Product` (`productId`, `productName`, `productNumber`, `serialNumberDetails`) VALUES (6, 'Bottling Kit', '9810006', '12387260');

COMMIT;


-- -----------------------------------------------------
-- Data for table `esit`.`Property`
-- -----------------------------------------------------
START TRANSACTION;
USE `esit`;
INSERT INTO `esit`.`Property` (`propertyId`, `address`, `customer`, `sqFootage`, `bathrooms`, `residents`, `hasPool`) VALUES (1, 1, 5, 1281, 2, 4, false);
INSERT INTO `esit`.`Property` (`propertyId`, `address`, `customer`, `sqFootage`, `bathrooms`, `residents`, `hasPool`) VALUES (2, 2, 2, 2014, 1, 5, true);
INSERT INTO `esit`.`Property` (`propertyId`, `address`, `customer`, `sqFootage`, `bathrooms`, `residents`, `hasPool`) VALUES (3, 4, 1, 1620, 4, 3, true);
INSERT INTO `esit`.`Property` (`propertyId`, `address`, `customer`, `sqFootage`, `bathrooms`, `residents`, `hasPool`) VALUES (4, 3, 4, 980, 2, 3, false);
INSERT INTO `esit`.`Property` (`propertyId`, `address`, `customer`, `sqFootage`, `bathrooms`, `residents`, `hasPool`) VALUES (5, 5, 3, 4000, 3, 1, true);

COMMIT;


-- -----------------------------------------------------
-- Data for table `esit`.`ProgramProduct`
-- -----------------------------------------------------
START TRANSACTION;
USE `esit`;
INSERT INTO `esit`.`ProgramProduct` (`program`, `product`) VALUES (1, 1);
INSERT INTO `esit`.`ProgramProduct` (`program`, `product`) VALUES (1, 4);
INSERT INTO `esit`.`ProgramProduct` (`program`, `product`) VALUES (1, 5);
INSERT INTO `esit`.`ProgramProduct` (`program`, `product`) VALUES (1, 6);
INSERT INTO `esit`.`ProgramProduct` (`program`, `product`) VALUES (2, 2);
INSERT INTO `esit`.`ProgramProduct` (`program`, `product`) VALUES (2, 4);
INSERT INTO `esit`.`ProgramProduct` (`program`, `product`) VALUES (2, 5);
INSERT INTO `esit`.`ProgramProduct` (`program`, `product`) VALUES (2, 6);
INSERT INTO `esit`.`ProgramProduct` (`program`, `product`) VALUES (3, 3);
INSERT INTO `esit`.`ProgramProduct` (`program`, `product`) VALUES (3, 4);
INSERT INTO `esit`.`ProgramProduct` (`program`, `product`) VALUES (3, 5);
INSERT INTO `esit`.`ProgramProduct` (`program`, `product`) VALUES (3, 6);

COMMIT;

