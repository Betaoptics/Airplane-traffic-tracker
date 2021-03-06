-- MySQL Script generated by MySQL Workbench
-- Tue Mar 26 16:24:41 2019
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema M2235_3
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema M2235_3
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `M2235_3` DEFAULT CHARACTER SET utf8 ;
USE `M2235_3` ;

-- -----------------------------------------------------
-- Table `M2235_3`.`Airport`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `M2235_3`.`Airport` (
  `AirportID` INT NOT NULL AUTO_INCREMENT,
  `AirportIATA` VARCHAR(10) NOT NULL,
  `AirportICAO` VARCHAR(10) NOT NULL,
  `AirportName` VARCHAR(100) NOT NULL,
  `AirportCountry` VARCHAR(10) NOT NULL,
  `AirportCity` VARCHAR(50) NOT NULL,
  `AirportElevation` INT NOT NULL,
  `AirportCoordinates` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`AirportID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `M2235_3`.`Airline`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `M2235_3`.`Airline` (
  `AirlineID` INT NOT NULL,
  `AirlineIATA` VARCHAR(10) NOT NULL,
  `AirlineICAO` VARCHAR(10) NOT NULL,
  `AirlineName` VARCHAR(100) NOT NULL,
  `Airport_HomeAirportID` INT NOT NULL,
  PRIMARY KEY (`AirlineID`),
  INDEX `fk_Airline_Airport1_idx` (`Airport_HomeAirportID` ASC),
  CONSTRAINT `fk_Airline_Airport1`
    FOREIGN KEY (`Airport_HomeAirportID`)
    REFERENCES `M2235_3`.`Airport` (`AirportID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `M2235_3`.`Plane`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `M2235_3`.`Plane` (
  `PlaneID` INT NOT NULL AUTO_INCREMENT,
  `PlaneManufacturer` VARCHAR(50) NOT NULL,
  `PlaneModel` VARCHAR(50) NOT NULL,
  `PlaneRegistration` VARCHAR(10) NOT NULL,
  `PlaneSeatCount` INT NOT NULL,
  `Airline_AirlineID` INT NOT NULL,
  PRIMARY KEY (`PlaneID`),
  INDEX `fk_Plane_Airline1_idx` (`Airline_AirlineID` ASC),
  CONSTRAINT `fk_Plane_Airline1`
    FOREIGN KEY (`Airline_AirlineID`)
    REFERENCES `M2235_3`.`Airline` (`AirlineID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `M2235_3`.`Person`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `M2235_3`.`Person` (
  `PersonID` INT NOT NULL AUTO_INCREMENT,
  `PersonFirstname` VARCHAR(50) NOT NULL,
  `PersonLastname` VARCHAR(50) NOT NULL,
  `PersonGender` CHAR(1) NOT NULL COMMENT 'Options: M, W',
  `PersonBday` DATE NOT NULL,
  `PersonType` VARCHAR(20) NOT NULL COMMENT 'Options: Employee, Customer',
  PRIMARY KEY (`PersonID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `M2235_3`.`Flight`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `M2235_3`.`Flight` (
  `FlightID` INT NOT NULL AUTO_INCREMENT,
  `FlightNumber` VARCHAR(15) NOT NULL,
  `FlightCallsign` VARCHAR(15) NOT NULL,
  `FlightDepTime` DATETIME NOT NULL,
  `FlightArrTime` DATETIME NOT NULL,
  `FlightEstTravelTime` TIME NOT NULL,
  `FlightDistance` INT NOT NULL,
  `Plane_PlaneID` INT NOT NULL,
  `Airport_DepAirportID` INT NOT NULL,
  `Airport_ArrAirportID` INT NOT NULL,
  PRIMARY KEY (`FlightID`),
  INDEX `fk_Flight_Plane_idx` (`Plane_PlaneID` ASC),
  INDEX `fk_Flight_Airport1_idx` (`Airport_DepAirportID` ASC),
  INDEX `fk_Flight_Airport2_idx` (`Airport_ArrAirportID` ASC),
  CONSTRAINT `fk_Flight_Plane`
    FOREIGN KEY (`Plane_PlaneID`)
    REFERENCES `M2235_3`.`Plane` (`PlaneID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Flight_Airport1`
    FOREIGN KEY (`Airport_DepAirportID`)
    REFERENCES `M2235_3`.`Airport` (`AirportID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Flight_Airport2`
    FOREIGN KEY (`Airport_ArrAirportID`)
    REFERENCES `M2235_3`.`Airport` (`AirportID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `M2235_3`.`FlightData`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `M2235_3`.`FlightData` (
  `FlightDataID` INT NOT NULL AUTO_INCREMENT,
  `FlightDataDate` DATETIME NOT NULL,
  `FlightDataCoordinates` VARCHAR(45) NOT NULL,
  `FlightDataAltitude` INT NOT NULL,
  `FlightDataSpeed` INT NOT NULL,
  `FlightDataHeading` INT NOT NULL,
  `Flight_FlightID` INT NOT NULL,
  PRIMARY KEY (`FlightDataID`),
  INDEX `fk_FlightData_Flight1_idx` (`Flight_FlightID` ASC),
  CONSTRAINT `fk_FlightData_Flight1`
    FOREIGN KEY (`Flight_FlightID`)
    REFERENCES `M2235_3`.`Flight` (`FlightID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `M2235_3`.`Ticket`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `M2235_3`.`Ticket` (
  `TicketID` INT NOT NULL AUTO_INCREMENT,
  `TicketSeat` VARCHAR(45) NOT NULL,
  `TicketClass` VARCHAR(45) NOT NULL,
  `Person_PersonID` INT NOT NULL,
  PRIMARY KEY (`TicketID`),
  INDEX `fk_Ticket_Person1_idx` (`Person_PersonID` ASC),
  CONSTRAINT `fk_Ticket_Person1`
    FOREIGN KEY (`Person_PersonID`)
    REFERENCES `M2235_3`.`Person` (`PersonID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `M2235_3`.`FlightPersonnel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `M2235_3`.`FlightPersonnel` (
  `Person_PersonID` INT NOT NULL,
  `Flight_FlightID` INT NOT NULL,
  `FlightPersonPosition` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Person_PersonID`, `Flight_FlightID`),
  INDEX `fk_Person_has_Flight_Flight1_idx` (`Flight_FlightID` ASC),
  INDEX `fk_Person_has_Flight_Person1_idx` (`Person_PersonID` ASC),
  CONSTRAINT `fk_Person_has_Flight_Person1`
    FOREIGN KEY (`Person_PersonID`)
    REFERENCES `M2235_3`.`Person` (`PersonID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Person_has_Flight_Flight1`
    FOREIGN KEY (`Flight_FlightID`)
    REFERENCES `M2235_3`.`Flight` (`FlightID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `M2235_3`.`FlightRow`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `M2235_3`.`FlightRow` (
  `Ticket_TicketID` INT NOT NULL,
  `Flight_FlightID` INT NOT NULL,
  PRIMARY KEY (`Ticket_TicketID`, `Flight_FlightID`),
  INDEX `fk_Ticket_has_Flight_Flight1_idx` (`Flight_FlightID` ASC),
  INDEX `fk_Ticket_has_Flight_Ticket1_idx` (`Ticket_TicketID` ASC),
  CONSTRAINT `fk_Ticket_has_Flight_Ticket1`
    FOREIGN KEY (`Ticket_TicketID`)
    REFERENCES `M2235_3`.`Ticket` (`TicketID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ticket_has_Flight_Flight1`
    FOREIGN KEY (`Flight_FlightID`)
    REFERENCES `M2235_3`.`Flight` (`FlightID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
