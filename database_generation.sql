-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema courseSystem
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `courseSystem` ;

-- -----------------------------------------------------
-- Schema courseSystem
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `courseSystem` DEFAULT CHARACTER SET utf8 ;
USE `courseSystem` ;

-- -----------------------------------------------------
-- Table `courseSystem`.`role`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `courseSystem`.`role` ;

CREATE TABLE IF NOT EXISTS `courseSystem`.`role` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `rolename` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `courseSystem`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `courseSystem`.`user` ;

CREATE TABLE IF NOT EXISTS `courseSystem`.`user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `firstname` VARCHAR(45) NOT NULL,
  `lastname` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `blocked` TINYINT NOT NULL DEFAULT 1,
  `role_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_user_role_idx` (`role_id` ASC),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC),
  CONSTRAINT `fk_user_role`
    FOREIGN KEY (`role_id`)
    REFERENCES `courseSystem`.`role` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `courseSystem`.`topic`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `courseSystem`.`topic` ;

CREATE TABLE IF NOT EXISTS `courseSystem`.`topic` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `courseSystem`.`status`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `courseSystem`.`status` ;

CREATE TABLE IF NOT EXISTS `courseSystem`.`status` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `status` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  UNIQUE INDEX `status_UNIQUE` (`status` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `courseSystem`.`course`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `courseSystem`.`course` ;

CREATE TABLE IF NOT EXISTS `courseSystem`.`course` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(45) NULL,
  `students_amount` INT NOT NULL,
  `topic_id` INT NOT NULL,
  `status_id` INT NOT NULL,
  `start_date` DATE NOT NULL,
  `finish_date` DATE NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_course_topic1_idx` (`topic_id` ASC),
  INDEX `fk_course_status1_idx` (`status_id` ASC),
  CONSTRAINT `fk_course_topic1`
    FOREIGN KEY (`topic_id`)
    REFERENCES `courseSystem`.`topic` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_course_status1`
    FOREIGN KEY (`status_id`)
    REFERENCES `courseSystem`.`status` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `courseSystem`.`user_course`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `courseSystem`.`user_course` ;

CREATE TABLE IF NOT EXISTS `courseSystem`.`user_course` (
  `course_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `mark` INT NULL,
  PRIMARY KEY (`course_id`, `user_id`),
  INDEX `fk_course_has_user_user1_idx` (`user_id` ASC),
  INDEX `fk_course_has_user_course1_idx` (`course_id` ASC),
  CONSTRAINT `fk_course_has_user_course1`
    FOREIGN KEY (`course_id`)
    REFERENCES `courseSystem`.`course` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_course_has_user_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `courseSystem`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `courseSystem`.`role`
-- -----------------------------------------------------
START TRANSACTION;
USE `courseSystem`;
INSERT INTO `courseSystem`.`role` (`id`, `rolename`) VALUES (1, 'administrator');
INSERT INTO `courseSystem`.`role` (`id`, `rolename`) VALUES (2, 'lecturer');
INSERT INTO `courseSystem`.`role` (`id`, `rolename`) VALUES (3, 'student');
INSERT INTO `courseSystem`.`role` (`id`, `rolename`) VALUES (4, 'potential_lecturer');

COMMIT;


-- -----------------------------------------------------
-- Data for table `courseSystem`.`user`
-- -----------------------------------------------------
START TRANSACTION;
USE `courseSystem`;
INSERT INTO `courseSystem`.`user` (`id`, `firstname`, `lastname`, `email`, `password`, `blocked`, `role_id`) VALUES (1, 'admin', 'admin', 'simple_email@gmail.com', md5('password'), 0, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `courseSystem`.`status`
-- -----------------------------------------------------
START TRANSACTION;
USE `courseSystem`;
INSERT INTO `courseSystem`.`status` (`id`, `status`) VALUES (DEFAULT, 'unblocked');
INSERT INTO `courseSystem`.`status` (`id`, `status`) VALUES (DEFAULT, 'blocked');

COMMIT;

