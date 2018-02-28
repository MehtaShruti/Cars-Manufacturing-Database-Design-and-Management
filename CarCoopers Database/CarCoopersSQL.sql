-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema CarCoopers
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `CarCoopers` ;

-- -----------------------------------------------------
-- Schema CarCoopers
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `CarCoopers` DEFAULT CHARACTER SET utf8 ;
SHOW WARNINGS;
USE `CarCoopers` ;

-- -----------------------------------------------------
-- Table `CarCoopers`.`Location`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CarCoopers`.`Location` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `CarCoopers`.`Location` (
  `LocationID` INT NOT NULL AUTO_INCREMENT,
  `LocationName` VARCHAR(20) NOT NULL,
  `ZipCode` INT NOT NULL,
  PRIMARY KEY (`LocationID`))
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE INDEX `LocationID_idx` ON `CarCoopers`.`Location` (`LocationID` ASC);

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `CarCoopers`.`VehicleCompany`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CarCoopers`.`VehicleCompany` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `CarCoopers`.`VehicleCompany` (
  `CompanyID` INT NOT NULL AUTO_INCREMENT,
  `CompanyName` VARCHAR(20) NOT NULL,
  `LocationID` INT NOT NULL,
  PRIMARY KEY (`CompanyID`),
  CONSTRAINT `LocationIDVC`
    FOREIGN KEY (`LocationID`)
    REFERENCES `CarCoopers`.`Location` (`LocationID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE INDEX `LocationID_idx` ON `CarCoopers`.`VehicleCompany` (`LocationID` ASC);

SHOW WARNINGS;
CREATE UNIQUE INDEX `CompanyName_UNIQUE` ON `CarCoopers`.`VehicleCompany` (`CompanyName` ASC);

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `CarCoopers`.`VehicleEnterprise`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CarCoopers`.`VehicleEnterprise` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `CarCoopers`.`VehicleEnterprise` (
  `VehicleEnterpriseID` INT NOT NULL AUTO_INCREMENT,
  `VehicleEnterpriseName` VARCHAR(20) NOT NULL,
  `CompanyID` INT NOT NULL,
  `Type` ENUM('Car', 'Bike') NOT NULL,
  PRIMARY KEY (`VehicleEnterpriseID`),
  CONSTRAINT `CarCompanyIDVE`
    FOREIGN KEY (`CompanyID`)
    REFERENCES `CarCoopers`.`VehicleCompany` (`CompanyID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE INDEX `CarCompanyID_idx` ON `CarCoopers`.`VehicleEnterprise` (`CompanyID` ASC);

SHOW WARNINGS;
CREATE UNIQUE INDEX `VehicleEnterpriseName_UNIQUE` ON `CarCoopers`.`VehicleEnterprise` (`VehicleEnterpriseName` ASC);

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `CarCoopers`.`Department`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CarCoopers`.`Department` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `CarCoopers`.`Department` (
  `DepartmentID` INT NOT NULL AUTO_INCREMENT,
  `DepartmentName` VARCHAR(20) NOT NULL,
  `CompanyID` INT NOT NULL,
  PRIMARY KEY (`DepartmentID`),
  CONSTRAINT `CarCompanyD`
    FOREIGN KEY (`CompanyID`)
    REFERENCES `CarCoopers`.`VehicleCompany` (`CompanyID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE INDEX `CarCompany_idx` ON `CarCoopers`.`Department` (`CompanyID` ASC);

SHOW WARNINGS;
CREATE UNIQUE INDEX `DepartmentName_UNIQUE` ON `CarCoopers`.`Department` (`DepartmentName` ASC);

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `CarCoopers`.`Employee`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CarCoopers`.`Employee` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `CarCoopers`.`Employee` (
  `EmployeeID` INT NOT NULL AUTO_INCREMENT,
  `EmployeeName` VARCHAR(20) NOT NULL,
  `Salary` DECIMAL(10,2) NOT NULL,
  `DepartmentID` INT NOT NULL,
  `Photo` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`EmployeeID`),
  CONSTRAINT `DepartmentIDE`
    FOREIGN KEY (`DepartmentID`)
    REFERENCES `CarCoopers`.`Department` (`DepartmentID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE INDEX `DepartmentID_idx` ON `CarCoopers`.`Employee` (`DepartmentID` ASC);

SHOW WARNINGS;
CREATE UNIQUE INDEX `EmployeeName_UNIQUE` ON `CarCoopers`.`Employee` (`EmployeeName` ASC);

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `CarCoopers`.`Supplier`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CarCoopers`.`Supplier` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `CarCoopers`.`Supplier` (
  `SupplierID` INT NOT NULL AUTO_INCREMENT,
  `SupplierName` VARCHAR(20) NOT NULL,
  `CompanyID` INT NOT NULL,
  PRIMARY KEY (`SupplierID`),
  CONSTRAINT `CompanyIDS`
    FOREIGN KEY (`CompanyID`)
    REFERENCES `CarCoopers`.`VehicleCompany` (`CompanyID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE INDEX `CarCompanyID_idx` ON `CarCoopers`.`Supplier` (`CompanyID` ASC);

SHOW WARNINGS;
CREATE UNIQUE INDEX `SupplierID_UNIQUE` ON `CarCoopers`.`Supplier` (`SupplierID` ASC);

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `CarCoopers`.`Customer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CarCoopers`.`Customer` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `CarCoopers`.`Customer` (
  `CustomerID` INT NOT NULL AUTO_INCREMENT,
  `CustomerName` VARCHAR(20) NOT NULL,
  `Type` ENUM('Online', 'Showroom') NOT NULL,
  `Email` VARCHAR(30) NOT NULL,
  `Phonenumber` VARCHAR(13) NOT NULL,
  `CreditLimit` DOUBLE(10,2) NOT NULL,
  PRIMARY KEY (`CustomerID`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `CarCoopers`.`UserAccount`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CarCoopers`.`UserAccount` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `CarCoopers`.`UserAccount` (
  `UserID` INT NOT NULL AUTO_INCREMENT,
  `UserName` VARCHAR(20) CHARACTER SET 'utf8' NOT NULL,
  `AccountCreationDate` DATE NOT NULL,
  `Password` VARCHAR(40) NOT NULL,
  `Status` ENUM('Active', 'Inactive') NOT NULL,
  PRIMARY KEY (`UserID`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `CarCoopers`.`OnlineCustomer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CarCoopers`.`OnlineCustomer` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `CarCoopers`.`OnlineCustomer` (
  `CustomerID` INT NOT NULL,
  `UserID` INT NOT NULL,
  PRIMARY KEY (`CustomerID`),
  CONSTRAINT `CustomerIDOC`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `CarCoopers`.`Customer` (`CustomerID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `UserIDOC`
    FOREIGN KEY (`UserID`)
    REFERENCES `CarCoopers`.`UserAccount` (`UserID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE INDEX `UserID_idx` ON `CarCoopers`.`OnlineCustomer` (`UserID` ASC);

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `CarCoopers`.`ShowroomCustomer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CarCoopers`.`ShowroomCustomer` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `CarCoopers`.`ShowroomCustomer` (
  `CustomerID` INT NOT NULL,
  `ModeOfPayment` ENUM('Cash', 'Card') NOT NULL,
  PRIMARY KEY (`CustomerID`),
  CONSTRAINT `CustomerIDSC`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `CarCoopers`.`Customer` (`CustomerID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `CarCoopers`.`Showroom`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CarCoopers`.`Showroom` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `CarCoopers`.`Showroom` (
  `ShowroomID` INT NOT NULL AUTO_INCREMENT,
  `ShowroomName` VARCHAR(20) NOT NULL,
  `LocationID` INT NOT NULL,
  PRIMARY KEY (`ShowroomID`),
  CONSTRAINT `LocationIDS`
    FOREIGN KEY (`LocationID`)
    REFERENCES `CarCoopers`.`Location` (`LocationID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE INDEX `LocationID_idx` ON `CarCoopers`.`Showroom` (`LocationID` ASC);

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `CarCoopers`.`Product`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CarCoopers`.`Product` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `CarCoopers`.`Product` (
  `ProductID` INT NOT NULL AUTO_INCREMENT,
  `ProductName` VARCHAR(20) CHARACTER SET 'utf8' NOT NULL,
  `Type` ENUM('Ordered', 'Stocked') NOT NULL,
  `ShowroomID` INT NOT NULL,
  `Price` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`ProductID`),
  CONSTRAINT `ShowroomIDP`
    FOREIGN KEY (`ShowroomID`)
    REFERENCES `CarCoopers`.`Showroom` (`ShowroomID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE UNIQUE INDEX `ProductID_UNIQUE` ON `CarCoopers`.`Product` (`ProductID` ASC);

SHOW WARNINGS;
CREATE INDEX `ShowroomID_idx` ON `CarCoopers`.`Product` (`ShowroomID` ASC);

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `CarCoopers`.`Order`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CarCoopers`.`Order` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `CarCoopers`.`Order` (
  `OrderID` INT NOT NULL AUTO_INCREMENT,
  `Quantity` INT NOT NULL,
  `CustomiseVehicleID` INT NULL,
  `VehicleEnterpriseID` INT NULL,
  `VehicleAmount` DECIMAL(10) NOT NULL,
  `Type` ENUM('VehicleEnterprise', 'Customised') NOT NULL,
  `DeliveryDate` DATE NOT NULL,
  PRIMARY KEY (`OrderID`),
  CONSTRAINT `VehicleEnterpriseIDO`
    FOREIGN KEY (`VehicleEnterpriseID`)
    REFERENCES `CarCoopers`.`VehicleEnterprise` (`VehicleEnterpriseID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE INDEX `VehicleEnterpriseID_idx` ON `CarCoopers`.`Order` (`VehicleEnterpriseID` ASC);

SHOW WARNINGS;
CREATE UNIQUE INDEX `OrderID_UNIQUE` ON `CarCoopers`.`Order` (`OrderID` ASC);

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `CarCoopers`.`OrderedProduct`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CarCoopers`.`OrderedProduct` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `CarCoopers`.`OrderedProduct` (
  `ProductID` INT NOT NULL,
  `CustomerID` INT NOT NULL,
  `OrderID` INT NOT NULL,
  PRIMARY KEY (`ProductID`),
  CONSTRAINT `ProductIDOP`
    FOREIGN KEY (`ProductID`)
    REFERENCES `CarCoopers`.`Product` (`ProductID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `CustomerIDOP`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `CarCoopers`.`OnlineCustomer` (`CustomerID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `OrderIDOP`
    FOREIGN KEY (`OrderID`)
    REFERENCES `CarCoopers`.`Order` (`OrderID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE INDEX `CustomerID_idx` ON `CarCoopers`.`OrderedProduct` (`CustomerID` ASC);

SHOW WARNINGS;
CREATE INDEX `OrderID_idx` ON `CarCoopers`.`OrderedProduct` (`OrderID` ASC);

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `CarCoopers`.`StockedProduct`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CarCoopers`.`StockedProduct` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `CarCoopers`.`StockedProduct` (
  `ProductID` INT NOT NULL AUTO_INCREMENT,
  `CustomerID` INT NOT NULL,
  PRIMARY KEY (`ProductID`),
  CONSTRAINT `ProductIDSP`
    FOREIGN KEY (`ProductID`)
    REFERENCES `CarCoopers`.`Product` (`ProductID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `CustomerIDSP`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `CarCoopers`.`ShowroomCustomer` (`CustomerID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE INDEX `CustomerID_idx` ON `CarCoopers`.`StockedProduct` (`CustomerID` ASC);

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `CarCoopers`.`CustomiseVehicle`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CarCoopers`.`CustomiseVehicle` ;
SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `CarCoopers`.`CustomiseVehicle` (
  `CustomiseVehicleID` INT NOT NULL AUTO_INCREMENT,
  `Type` ENUM('Car', 'Bike') NOT NULL,
  `Wheel` ENUM('Alloy', 'Steel') NOT NULL,
  `Color` SET('Red', 'Blue', 'Black', 'Silver', 'Green') NOT NULL,
  `Engine` VARCHAR(20) NOT NULL,
  `Battery` VARCHAR(20) NOT NULL,
  `UserID` INT NOT NULL,
  `OrderID` INT NOT NULL,
  PRIMARY KEY (`CustomiseVehicleID`),
  CONSTRAINT `UserIDCV`
    FOREIGN KEY (`UserID`)
    REFERENCES `CarCoopers`.`UserAccount` (`UserID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `OrderIDCV`
    FOREIGN KEY (`OrderID`)
    REFERENCES `CarCoopers`.`Order` (`OrderID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE INDEX `UserID_idx` ON `CarCoopers`.`CustomiseVehicle` (`UserID` ASC);

SHOW WARNINGS;
CREATE INDEX `OrderID_idx` ON `CarCoopers`.`CustomiseVehicle` (`OrderID` ASC);

SHOW WARNINGS;

-- -----------------------------------------------------


-- -----------------------------------------------------
-- Table `CarCoopers`.`Delivery`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CarCoopers`.`Delivery` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `CarCoopers`.`Delivery` (
  `OrderID` INT NOT NULL,
  `DeliveryDate` DATE NOT NULL,
  PRIMARY KEY (`OrderID`),
  CONSTRAINT `OrderIDD`
    FOREIGN KEY (`OrderID`)
    REFERENCES `CarCoopers`.`Order` (`OrderID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `CarCoopers`.`Price_Log`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CarCoopers`.`PriceLog` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `CarCoopers`.`PriceLog` (
  `ProductID` INT NOT NULL,
  `Price` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`ProductID`),
  CONSTRAINT `ProductIDPL`
    FOREIGN KEY (`ProductID`)
    REFERENCES `CarCoopers`.`Product` (`ProductID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `CarCoopers`.`CustomerAudit`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CarCoopers`.`CustomerAudit` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `CarCoopers`.`CustomerAudit` (
  `CustomerID` INT NOT NULL,
  `DeletedDate` DATE NOT NULL,
  `DeletedBy` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`CustomerID`))
  
ENGINE = InnoDB;

SHOW WARNINGS;
USE `CarCoopers` ;

-- -----------------------------------------------------
-- Placeholder table for view `CarCoopers`.`Online_Customer_View`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CarCoopers`.`Online_Customer_View` (`CustomerID` INT, `CustomerName` INT, `UserID` INT, `OrderID` INT, `ProductName` INT);
SHOW WARNINGS;

-- -----------------------------------------------------
-- Placeholder table for view `CarCoopers`.`Count_OfEmpl_InDeptt_Of_Company_View`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CarCoopers`.`Count_OfEmpl_InDeptt_Of_Company_View` (`companyId` INT, `companyname` INT, `departmentId` INT, `departmentname` INT, `count(employeeId)` INT);
SHOW WARNINGS;

-- -----------------------------------------------------
-- Placeholder table for view `CarCoopers`.`Customer_View`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CarCoopers`.`Customer_View` (`customerId` INT, `customername` INT, `type` INT, `email` INT, `phonenumber` INT);
SHOW WARNINGS;

-- -----------------------------------------------------
-- procedure ShowroomsVehicleCompaniesLocation
-- -----------------------------------------------------

USE `CarCoopers`;
DROP procedure IF EXISTS `CarCoopers`.`ShowroomsVehicleCompaniesLocation`;
SHOW WARNINGS;

DELIMITER $$
USE `CarCoopers`$$
CREATE PROCEDURE `ShowroomsVehicleCompaniesLocation` ()
BEGIN
select location.locationid,location.locationname,location.zipcode,vc.companyId, vc.companyname,
showroom.showroomid,showroom.showroomname from VehicleCompany vc inner join Location location
on vc.locationid=location.locationid
inner join Showroom showroom on location.locationid=showroom.locationid;
END$$

DELIMITER ;
SHOW WARNINGS;

-- -----------------------------------------------------
-- procedure EmployeeInDepartment
-- -----------------------------------------------------

USE `CarCoopers`;
DROP procedure IF EXISTS `CarCoopers`.`EmployeeInDepartment`;
SHOW WARNINGS;

DELIMITER $$
USE `CarCoopers`$$
CREATE PROCEDURE `EmployeeInDepartment`  (departmentid int)
BEGIN 
Select employee.employeeID,employee.employeeName,employee.salary,
deptt.DepartmentID,deptt.DepartmentName from Employee employee inner join 
Department deptt on employee.departmentID=deptt.DepartmentID where employee.departmentID=departmentid;

END$$

DELIMITER ;
SHOW WARNINGS;

-- -----------------------------------------------------
-- procedure GetOrderedProducts
-- -----------------------------------------------------

USE `CarCoopers`;
DROP procedure IF EXISTS `CarCoopers`.`GetOrderedProducts`;
SHOW WARNINGS;

DELIMITER $$
USE `CarCoopers`$$
CREATE PROCEDURE `GetOrderedProducts`()
BEGIN
   Select product.productID,product.productname,op.orderID,op.CustomerID from
   Product product inner join OrderedProduct op on product.productID=op.productID;
END$$

DELIMITER ;
SHOW WARNINGS;
-- -----------------------------------------------------
-- procedure GetShowroomByLocation
-- -----------------------------------------------------
USE `CarCoopers`;
DROP procedure IF EXISTS `CarCoopers`.`GetShowroomByLocation`;
SHOW WARNINGS;

DELIMITER $$
USE `CarCoopers`$$
CREATE PROCEDURE GetShowroomByLocation(IN locationname varchar(20))
 BEGIN
 SELECT location.locationname, showroom.showroomname  
 FROM showroom inner join location on showroom.LocationID=location.LocationID
 WHERE location.locationname =locationname;
 END$$

DELIMITER ;
SHOW WARNINGS;

-- -----------------------------------------------------
-- procedure CountOrderByDeliveryDate
-- -----------------------------------------------------
USE `CarCoopers`;
DROP procedure IF EXISTS `CarCoopers`.`CountOrderByDeliveryDate`;
SHOW WARNINGS;

DELIMITER $$
USE `CarCoopers`$$

CREATE PROCEDURE CountOrderByDeliveryDate(
 IN delivdate VARCHAR(25),
 OUT total INT)
BEGIN
 SELECT count(orderID)
 INTO total
 FROM CarCoopers.Order
 WHERE deliverydate = delivdate;
END$$
DELIMITER ;

-- -----------------------------------------------------
-- procedure 
-- -----------------------------------------------------
USE `CarCoopers`;
DROP procedure IF EXISTS `CarCoopers`.`CountNulls`;
SHOW WARNINGS; 

delimiter $$
Create procedure `CountNulls`()
BEGIN
SELECT 'customiseVehicleID', COUNT(*)-count(customiseVehicleID)as NumberofNulls from CarCoopers.Order
union all
SELECT 'vehicleEnterpriseID', COUNT(*)-count(vehicleEnterpriseID) as NumberofNulls from CarCoopers.Order;
End$$
Delimiter ;

-- -----------------------------------------------------
-- function customer level 
-- -----------------------------------------------------
USE `CarCoopers`;
DROP procedure IF EXISTS `CarCoopers`.`CustomerLevel`;
SHOW WARNINGS; 



DELIMITER $$
 
CREATE FUNCTION CustomerLevel(p_creditLimit double) RETURNS VARCHAR(10)
    DETERMINISTIC
BEGIN
    DECLARE lvl varchar(10);
 
    IF p_creditLimit > 50000 THEN
 SET lvl = 'PLATINUM';
    ELSEIF (p_creditLimit <= 50000 AND p_creditLimit >= 20000) THEN
        SET lvl = 'GOLD';
    ELSEIF p_creditLimit < 20000 THEN
        SET lvl = 'SILVER';
    END IF;
 
 RETURN (lvl);
END $$
DELIMITER ;

-- -----------------------------------------------------
-- procedure `CarCoopers`.`backup_customer_details`
-- -----------------------------------------------------
USE `CarCoopers`;
DROP procedure IF EXISTS `CarCoopers`.`backup_customer_details`;
SHOW WARNINGS; 

Delimiter $$
Create Procedure backup_customer_details()
Begin
CREATE TABLE Customer_new AS SELECT * FROM Customer;
CREATE TABLE OnlineCustomer_new AS SELECT * FROM OnlineCustomer;
CREATE TABLE ShowroomCustomer_new AS SELECT * FROM ShowroomCustomer;
END $$
DELIMITER ;
-- -----------------------------------------------------
-- procedure `CarCoopers`.`CarCoopers`.`backup_customer_details`
-- -----------------------------------------------------
USE `CarCoopers`;
DROP procedure IF EXISTS `CarCoopers`.`DumpData`;
SHOW WARNINGS; 

Delimiter $$
Create procedure DumpData()
Begin
SELECT customerId,customername INTO OUTFILE '/mysql-out/DumpaTableNew.csv'
  FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
  LINES TERMINATED BY '\n'
  FROM customer; 
End $$
Delimiter ;
-- -----------------
-- event
-- ------------------
DELIMITER //
CREATE EVENT customer_backup
ON SCHEDULE EVERY 1 HOUR
STARTS '2016-12-11 05:15:00'
DO
BEGIN
   SELECT * INTO OUTFILE '/mysql-out/DumpaTable2.csv'
   FROM Customer;
END//
DELIMITER ;


-- -----------------------------------------------------
-- View `CarCoopers`.`Online_Customer_View`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `CarCoopers`.`Online_Customer_View` ;
SHOW WARNINGS;
DROP TABLE IF EXISTS `CarCoopers`.`Online_Customer_View`;
SHOW WARNINGS;
USE `CarCoopers`;
CREATE VIEW `Online_Customer_View` AS
Select customer.CustomerID,customer.CustomerName,oc.UserID,op.OrderID,product.ProductName
from Customer customer inner join OnlineCustomer oc on customer.CustomerID=oc.CustomerID
inner join OrderedProduct op on oc.CustomerID=op.CustomerID 
inner join Product product on op.ProductID=product.ProductID;
SHOW WARNINGS;

-- -----------------------------------------------------
-- View `CarCoopers`.`Count_OfEmpl_InDeptt_Of_Company_View`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `CarCoopers`.`Count_OfEmpl_InDeptt_Of_Company_View` ;
SHOW WARNINGS;
DROP TABLE IF EXISTS `CarCoopers`.`Count_OfEmpl_InDeptt_Of_Company_View`;
SHOW WARNINGS;
USE `CarCoopers`;
CREATE  OR REPLACE VIEW `Count_OfEmpl_InDeptt_Of_Company_View` AS
Select company.companyId,company.companyname,department.departmentId,department.departmentname,count(employeeId) as NumberOfEmployees
from VehicleCompany company
inner join department department on company.companyId=department.companyId
inner join employee emp on department.departmentId=emp.departmentId 
group by company.companyId,company.companyname,department.departmentId,department.departmentname;
SHOW WARNINGS;

-- -----------------------------------------------------
-- View `CarCoopers`.`Customer_View`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `CarCoopers`.`Customer_View` ;
SHOW WARNINGS;
DROP TABLE IF EXISTS `CarCoopers`.`Customer_View`;
SHOW WARNINGS;
USE `CarCoopers`;
CREATE VIEW `Customer_View` AS
select cust.customerId, cust.customername,cust.type, cust.email,cust.phonenumber from ShowroomCustomer sc
right join Customer cust  on cust.customerId=sc.customerId 
left join OnlineCustomer oc on cust.customerId=oc.customerId;
SHOW WARNINGS;
USE `CarCoopers`;
-- -----------------------------------------------------
-- View `CarCoopers`.`ListofProductsInShowroom`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `CarCoopers`.`ListofProductsInShowroom` ;
SHOW WARNINGS;
DROP TABLE IF EXISTS `CarCoopers`.`ListofProductsInShowroom`;
SHOW WARNINGS;
use `CarCoopers`;
CREATE VIEW `ListofProductsInShowroom`
AS 
Select  showroom.ShowroomName,Count(product.ProductID) as TotalProducts 
From    Showroom showroom
INNER JOIN Product product
ON showroom.showroomID = product.showroomID
INNER JOIN OrderedProduct op
ON product.productID = op.productID
group by showroom.showroomname;



-- -----------------------------------

 -- Triggers

-- -----------------------------------


DELIMITER $$

SHOW WARNINGS$$

USE `CarCoopers`$$
DROP TRIGGER IF EXISTS `CarCoopers`.`Customer_deleted_audit` $$
SHOW WARNINGS$$
USE `CarCoopers`$$
CREATE DEFINER = CURRENT_USER TRIGGER `Customer_deleted_audit` AFTER DELETE ON `Customer` FOR EACH ROW
BEGIN
DECLARE vUser varchar(50);
-- Find username of person performing the DELETE into table
Select USER() into vUser;
-- Insert record into audit table
Insert into CustomerAudit(CustomerID,DeletedDate,DeletedBy) values(old.customerID,NOW(),vUser);
END$$

SHOW WARNINGS$$

USE `CarCoopers`$$
DROP TRIGGER IF EXISTS `CarCoopers`.`account_create_date` $$
SHOW WARNINGS$$
USE `CarCoopers`$$
CREATE DEFINER = CURRENT_USER TRIGGER `CarCoopers`.`account_create_date` BEFORE INSERT ON `UserAccount` FOR EACH ROW
BEGIN
SET NEW.AccountCreationDate=NOW();
END$$

SHOW WARNINGS$$

USE `CarCoopers`$$
DROP TRIGGER IF EXISTS `CarCoopers`.`before_product_update` $$
SHOW WARNINGS$$
USE `CarCoopers`$$
CREATE DEFINER = CURRENT_USER TRIGGER `CarCoopers`.`before_product_update` BEFORE UPDATE ON `Product` FOR EACH ROW
BEGIN
INSERT INTO PriceLog(ProductID,Price) values(old.productid,old.price);
END$$

SHOW WARNINGS$$

USE `CarCoopers`$$
DROP TRIGGER IF EXISTS `CarCoopers`.`Order_BEFORE_UPDATE` $$
SHOW WARNINGS$$
USE `CarCoopers`$$
CREATE DEFINER = CURRENT_USER TRIGGER `CarCoopers`.`Order_BEFORE_UPDATE` BEFORE UPDATE  ON `Order`  FOR EACH ROW
BEGIN
  UPDATE Delivery d
  set d.deliverydate=new.deliverydate
  where d.orderid=new.orderid;
END$$


SHOW WARNINGS$$

DELIMITER ;
SET SQL_MODE = '';


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `CarCoopers`.`Location`
-- -----------------------------------------------------
START TRANSACTION;
USE `CarCoopers`;
INSERT INTO `CarCoopers`.`Location` (`LocationID`, `LocationName`, `ZipCode`) VALUES (1, 'India', 12345);
INSERT INTO `CarCoopers`.`Location` (`LocationID`, `LocationName`, `ZipCode`) VALUES (2, 'China', 23456);
INSERT INTO `CarCoopers`.`Location` (`LocationID`, `LocationName`, `ZipCode`) VALUES (3, 'Nepal', 34567);
INSERT INTO `CarCoopers`.`Location` (`LocationID`, `LocationName`, `ZipCode`) VALUES (4, 'Bangladesh', 45678);
INSERT INTO `CarCoopers`.`Location` (`LocationID`, `LocationName`, `ZipCode`) VALUES (5, 'United States', 56789);

COMMIT;


-- -----------------------------------------------------
-- Data for table `CarCoopers`.`VehicleCompany`
-- -----------------------------------------------------
START TRANSACTION;
USE `CarCoopers`;
INSERT INTO `CarCoopers`.`VehicleCompany` (`CompanyID`, `CompanyName`, `LocationID`) VALUES (1, 'Car Bombers', 1);
INSERT INTO `CarCoopers`.`VehicleCompany` (`CompanyID`, `CompanyName`, `LocationID`) VALUES (2, 'Motor Race', 2);
INSERT INTO `CarCoopers`.`VehicleCompany` (`CompanyID`, `CompanyName`, `LocationID`) VALUES (3, 'Vehicle People', 1);
INSERT INTO `CarCoopers`.`VehicleCompany` (`CompanyID`, `CompanyName`, `LocationID`) VALUES (4, 'Automob', 2);
INSERT INTO `CarCoopers`.`VehicleCompany` (`CompanyID`, `CompanyName`, `LocationID`) VALUES (5, 'Auto Motor Corp', 3);
INSERT INTO `CarCoopers`.`VehicleCompany` (`CompanyID`, `CompanyName`, `LocationID`) VALUES (6, 'National Motors', 4);
INSERT INTO `CarCoopers`.`VehicleCompany` (`CompanyID`, `CompanyName`, `LocationID`) VALUES (7, 'Miki Parts', 5);

COMMIT;


-- -----------------------------------------------------
-- Data for table `CarCoopers`.`VehicleEnterprise`
-- -----------------------------------------------------
START TRANSACTION;
USE `CarCoopers`;
INSERT INTO `CarCoopers`.`VehicleEnterprise` (`VehicleEnterpriseID`, `VehicleEnterpriseName`, `CompanyID`, `Type`) VALUES (1, 'Volkswagon', 1, 'Car');
INSERT INTO `CarCoopers`.`VehicleEnterprise` (`VehicleEnterpriseID`, `VehicleEnterpriseName`, `CompanyID`, `Type`) VALUES (2, 'Maruti', 2, 'Car');
INSERT INTO `CarCoopers`.`VehicleEnterprise` (`VehicleEnterpriseID`, `VehicleEnterpriseName`, `CompanyID`, `Type`) VALUES (3, 'Honda', 3, 'Bike');
INSERT INTO `CarCoopers`.`VehicleEnterprise` (`VehicleEnterpriseID`, `VehicleEnterpriseName`, `CompanyID`, `Type`) VALUES (4, 'KTM', 4, 'Bike');
INSERT INTO `CarCoopers`.`VehicleEnterprise` (`VehicleEnterpriseID`, `VehicleEnterpriseName`, `CompanyID`, `Type`) VALUES (5, 'Royal Enfield', 5, 'Bike');
INSERT INTO `CarCoopers`.`VehicleEnterprise` (`VehicleEnterpriseID`, `VehicleEnterpriseName`, `CompanyID`, `Type`) VALUES (6, 'Pulsar', 1, 'Bike');
INSERT INTO `CarCoopers`.`VehicleEnterprise` (`VehicleEnterpriseID`, `VehicleEnterpriseName`, `CompanyID`, `Type`) VALUES (7, 'Unicorn', 3, 'Bike');

COMMIT;


-- -----------------------------------------------------
-- Data for table `CarCoopers`.`Department`
-- -----------------------------------------------------
START TRANSACTION;
USE `CarCoopers`;
INSERT INTO `CarCoopers`.`Department` (`DepartmentID`, `DepartmentName`, `CompanyID`) VALUES (1, 'Manufacturing', 1);
INSERT INTO `CarCoopers`.`Department` (`DepartmentID`, `DepartmentName`, `CompanyID`) VALUES (2, 'Design', 2);
INSERT INTO `CarCoopers`.`Department` (`DepartmentID`, `DepartmentName`, `CompanyID`) VALUES (3, 'Sales', 3);
INSERT INTO `CarCoopers`.`Department` (`DepartmentID`, `DepartmentName`, `CompanyID`) VALUES (4, 'Inventory', 4);
INSERT INTO `CarCoopers`.`Department` (`DepartmentID`, `DepartmentName`, `CompanyID`) VALUES (5, 'HR', 1);
INSERT INTO `CarCoopers`.`Department` (`DepartmentID`, `DepartmentName`, `CompanyID`) VALUES (6, 'Marketing', 2);
INSERT INTO `CarCoopers`.`Department` (`DepartmentID`, `DepartmentName`, `CompanyID`) VALUES (7, 'Finance', 4);
INSERT INTO `CarCoopers`.`Department` (`DepartmentID`, `DepartmentName`, `CompanyID`) VALUES (8, 'Administration', 1);
INSERT INTO `CarCoopers`.`Department` (`DepartmentID`, `DepartmentName`, `CompanyID`) VALUES (9, 'Public Relations', 4);

COMMIT;


-- -----------------------------------------------------
-- Data for table `CarCoopers`.`Employee`
-- -----------------------------------------------------
START TRANSACTION;
USE `CarCoopers`;
INSERT INTO `CarCoopers`.`Employee` (`EmployeeID`, `EmployeeName`, `Salary`, `DepartmentID`, `Photo`) VALUES (1, 'Shruti Mehta', 24567, 1, 'LOAD_FILE(\'/Users/shrutimehta/Desktop/car.jpg\')');
INSERT INTO `CarCoopers`.`Employee` (`EmployeeID`, `EmployeeName`, `Salary`, `DepartmentID`, `Photo`) VALUES (2, 'Akul Narang', 22442, 2, 'LOAD_FILE(\'/Users/shrutimehta/Desktop/car.jpg)');
INSERT INTO `CarCoopers`.`Employee` (`EmployeeID`, `EmployeeName`, `Salary`, `DepartmentID`, `Photo`) VALUES (3, 'Jee Wosh', 6658.45, 3, 'LOAD_FILE(\'/Users/shrutimehta/Desktop/car.jpg)');
INSERT INTO `CarCoopers`.`Employee` (`EmployeeID`, `EmployeeName`, `Salary`, `DepartmentID`, `Photo`) VALUES (4, 'Akin Soop', 4342.34, 1, 'LOAD_FILE(\'/Users/shrutimehta/Desktop/car.jpg)');
INSERT INTO `CarCoopers`.`Employee` (`EmployeeID`, `EmployeeName`, `Salary`, `DepartmentID`, `Photo`) VALUES (5, 'Lemmi Wash', 5352.23, 2, 'LOAD_FILE(\'/Users/shrutimehta/Desktop/car.jpg)');
INSERT INTO `CarCoopers`.`Employee` (`EmployeeID`, `EmployeeName`, `Salary`, `DepartmentID`, `Photo`) VALUES (6, 'Kartik Nein', 2421.32, 3, 'LOAD_FILE(\'/Users/shrutimehta/Desktop/car.jpg)');

COMMIT;


-- -----------------------------------------------------
-- Data for table `CarCoopers`.`Supplier`
-- -----------------------------------------------------
START TRANSACTION;
USE `CarCoopers`;
INSERT INTO `CarCoopers`.`Supplier` (`SupplierID`, `SupplierName`, `CompanyID`) VALUES (1, 'Super Supplies', 1);
INSERT INTO `CarCoopers`.`Supplier` (`SupplierID`, `SupplierName`, `CompanyID`) VALUES (2, 'Auto Supplies', 2);
INSERT INTO `CarCoopers`.`Supplier` (`SupplierID`, `SupplierName`, `CompanyID`) VALUES (3, 'Parts Suppliers', 3);
INSERT INTO `CarCoopers`.`Supplier` (`SupplierID`, `SupplierName`, `CompanyID`) VALUES (4, 'National goods', 4);
INSERT INTO `CarCoopers`.`Supplier` (`SupplierID`, `SupplierName`, `CompanyID`) VALUES (5, 'Swan Supplies', 5);

COMMIT;


-- -----------------------------------------------------
-- Data for table `CarCoopers`.`Customer`
-- -----------------------------------------------------
START TRANSACTION;
USE `CarCoopers`;
INSERT INTO `CarCoopers`.`Customer` (`CustomerID`, `CustomerName`, `Type`, `Email`, `Phonenumber`,`CreditLimit`) VALUES (1, 'Kanishk Mehra', 'Online', 'kanishk@gmail.com', '1234567890',50000);
INSERT INTO `CarCoopers`.`Customer` (`CustomerID`, `CustomerName`, `Type`, `Email`, `Phonenumber`,`CreditLimit`) VALUES (2, 'Adams', 'Showroom', 'adams@hotmail.com', '2345678901',65000);
INSERT INTO `CarCoopers`.`Customer` (`CustomerID`, `CustomerName`, `Type`, `Email`, `Phonenumber`,`CreditLimit`) VALUES (3, 'Soumiya', 'Showroom', 'soumiya@yahoo.com', '3456789012',40000);
INSERT INTO `CarCoopers`.`Customer` (`CustomerID`, `CustomerName`, `Type`, `Email`, `Phonenumber`,`CreditLimit`) VALUES (4, 'Raj', 'Online', 'raj@gmail.com', '4567890123',20000);
INSERT INTO `CarCoopers`.`Customer` (`CustomerID`, `CustomerName`, `Type`, `Email`, `Phonenumber`,`CreditLimit`) VALUES (5, 'Ronak', 'Online', 'ronak@yahoo.com', '5678901234',30000);
INSERT INTO `CarCoopers`.`Customer` (`CustomerID`, `CustomerName`, `Type`, `Email`, `Phonenumber`,`CreditLimit`) VALUES (6, 'Rony', 'Showroom', 'rony@gmail.com', '6789012345',24000);
INSERT INTO `CarCoopers`.`Customer` (`CustomerID`, `CustomerName`, `Type`, `Email`, `Phonenumber`,`CreditLimit`) VALUES (7, 'Sufi', 'Online', 'sufi@gmail.com', '7890123456',34000);
INSERT INTO `CarCoopers`.`Customer` (`CustomerID`, `CustomerName`, `Type`, `Email`, `Phonenumber`,`CreditLimit`) VALUES (8, 'Rachan Raj', 'Online', 'rachan.raj@gmail.com', '8901234567',67000);
INSERT INTO `CarCoopers`.`Customer` (`CustomerID`, `CustomerName`, `Type`, `Email`, `Phonenumber`,`CreditLimit`) VALUES (9, 'Ishan', 'Showroom', 'ishan@gmail.com', '9012345678',50000);
INSERT INTO `CarCoopers`.`Customer` (`CustomerID`, `CustomerName`, `Type`, `Email`, `Phonenumber`,`CreditLimit`) VALUES (10, 'Rubal', 'Online', 'rubal1234@gmail.com', '1023456789',30000);
INSERT INTO `CarCoopers`.`Customer` (`CustomerID`, `CustomerName`, `Type`, `Email`, `Phonenumber`,`CreditLimit`) VALUES (11, 'Rohan', 'Showroom', 'rohan@gmail.com', '1203456789',60000);
INSERT INTO `CarCoopers`.`Customer` (`CustomerID`, `CustomerName`, `Type`, `Email`, `Phonenumber`,`CreditLimit`) VALUES (12, 'Ishki Kay', 'Online', 'ishki.ray@gmail.com', '1302456789',70000);
INSERT INTO `CarCoopers`.`Customer` (`CustomerID`, `CustomerName`, `Type`, `Email`, `Phonenumber`,`CreditLimit`) VALUES (13, 'Prakshep Kumar', 'Online', 'prakshep@gmail.com', '1467802345',56000);
INSERT INTO `CarCoopers`.`Customer` (`CustomerID`, `CustomerName`, `Type`, `Email`, `Phonenumber`,`CreditLimit`) VALUES (14, 'Pooran', 'Online', 'pooran@gmail.com', '1245367890',45000);
INSERT INTO `CarCoopers`.`Customer` (`CustomerID`, `CustomerName`, `Type`, `Email`, `Phonenumber`,`CreditLimit`) VALUES (15, 'Ayushi', 'Online', 'ayushi@gmail.com', '1567890356',34000);
INSERT INTO `CarCoopers`.`Customer` (`CustomerID`, `CustomerName`, `Type`, `Email`, `Phonenumber`,`CreditLimit`) VALUES (16, 'Yogesh', 'Online', 'yogesh1234@gmail.com', '1678901234',90000);
INSERT INTO `CarCoopers`.`Customer` (`CustomerID`, `CustomerName`, `Type`, `Email`, `Phonenumber`,`CreditLimit`) VALUES (17, 'Namita Rana', 'Online', 'namita@gmail.com', '1789012345',56000);
INSERT INTO `CarCoopers`.`Customer` (`CustomerID`, `CustomerName`, `Type`, `Email`, `Phonenumber`,`CreditLimit`) VALUES (18, 'Shweta Singh', 'Online', 'shweta.singh@gmail.com', '1890123456',45000);
INSERT INTO `CarCoopers`.`Customer` (`CustomerID`, `CustomerName`, `Type`, `Email`, `Phonenumber`,`CreditLimit`) VALUES (19, 'Kanishk Gupta', 'Online', 'kanishk.gupta@yahoo.com', '1902345677',23000);
INSERT INTO `CarCoopers`.`Customer` (`CustomerID`, `CustomerName`, `Type`, `Email`, `Phonenumber`,`CreditLimit`) VALUES (20, 'Kaajal Ray', 'Showroom', 'ray.kaajal@gmail.com', '1023456789',40000);
INSERT INTO `CarCoopers`.`Customer` (`CustomerID`, `CustomerName`, `Type`, `Email`, `Phonenumber`,`CreditLimit`) VALUES (21, 'Vishal Passi', 'Online', 'passi.vishal@gmail.com', '8932942399',34000);
INSERT INTO `CarCoopers`.`Customer` (`CustomerID`, `CustomerName`, `Type`, `Email`, `Phonenumber`,`CreditLimit`) VALUES (22, 'Kunwar Raj', 'Online', 'raj.kunwar@yahoo.com', '3847326893',60000);
INSERT INTO `CarCoopers`.`Customer` (`CustomerID`, `CustomerName`, `Type`, `Email`, `Phonenumber`,`CreditLimit`) VALUES (23, 'Pin Martin', 'Online', 'martin.pin@yahoo.com', '5754375395',56000);
INSERT INTO `CarCoopers`.`Customer` (`CustomerID`, `CustomerName`, `Type`, `Email`, `Phonenumber`,`CreditLimit`) VALUES (24, 'Parth', 'Online', 'parth.pin@yahoo.com', '5750075395',67000);
INSERT INTO `CarCoopers`.`Customer` (`CustomerID`, `CustomerName`, `Type`, `Email`, `Phonenumber`,`CreditLimit`) VALUES (25, 'Poku', 'Online', 'poku.pin@yahoo.com', '5154375395',50000);
INSERT INTO `CarCoopers`.`Customer` (`CustomerID`, `CustomerName`, `Type`, `Email`, `Phonenumber`,`CreditLimit`) VALUES (26, 'Ishaank', 'Online', 'ishaank.pin@yahoo.com', '5712375395',70000);
INSERT INTO `CarCoopers`.`Customer` (`CustomerID`, `CustomerName`, `Type`, `Email`, `Phonenumber`,`CreditLimit`) VALUES (27, 'JohnK', 'Online', 'john.pin@yahoo.com', '5754300395',34000);

COMMIT;


-- -----------------------------------------------------
-- Data for table `CarCoopers`.`UserAccount`
-- -----------------------------------------------------
START TRANSACTION;
USE `CarCoopers`;
INSERT INTO `CarCoopers`.`UserAccount` (`UserID`, `UserName`, `AccountCreationDate`, `Password`, `Status`) VALUES (1, 'Kanishk', '1999-11-06', md5('K@1234'), 'Active');
INSERT INTO `CarCoopers`.`UserAccount` (`UserID`, `UserName`, `AccountCreationDate`, `Password`, `Status`) VALUES (2, 'Raj', '2001-04-20', md5('raj@1234'), 'Active');
INSERT INTO `CarCoopers`.`UserAccount` (`UserID`, `UserName`, `AccountCreationDate`, `Password`, `Status`) VALUES (3, 'Ronak', '2012-10-23', md5('ronak@1234'), 'Active');
INSERT INTO `CarCoopers`.`UserAccount` (`UserID`, `UserName`, `AccountCreationDate`, `Password`, `Status`) VALUES (4, 'Sufi', '2014-05-06', md5('sufi@1234'), 'Inactive');
INSERT INTO `CarCoopers`.`UserAccount` (`UserID`, `UserName`, `AccountCreationDate`, `Password`, `Status`) VALUES (5, 'Rubal', '2016-03-12', md5('rubal@1234'), 'Inactive');
INSERT INTO `CarCoopers`.`UserAccount` (`UserID`, `UserName`, `AccountCreationDate`, `Password`, `Status`) VALUES (6, 'Rachan', '2015-05-23',md5('rachan@1234'), 'Active');
INSERT INTO `CarCoopers`.`UserAccount` (`UserID`, `UserName`, `AccountCreationDate`, `Password`, `Status`) VALUES (7, 'Ishki', '2016-05-14', md5('ishki@1234'), 'Active');
INSERT INTO `CarCoopers`.`UserAccount` (`UserID`, `UserName`, `AccountCreationDate`, `Password`, `Status`) VALUES (8, 'Prakshep', '2013-06-12',md5('prakshep@1234'), 'Active');
INSERT INTO `CarCoopers`.`UserAccount` (`UserID`, `UserName`, `AccountCreationDate`, `Password`, `Status`) VALUES (9, 'Pooran', '1996-01-05', md5('pooran@1234'), 'Active');
INSERT INTO `CarCoopers`.`UserAccount` (`UserID`, `UserName`, `AccountCreationDate`, `Password`, `Status`) VALUES (10, 'Ayushi', '1997-05-09', md5('ayushi@1234'), 'Active');
INSERT INTO `CarCoopers`.`UserAccount` (`UserID`, `UserName`, `AccountCreationDate`, `Password`, `Status`) VALUES (11, 'Yogesh', '2011-04-05', md5('yogesh@1234'), 'Inactive');
INSERT INTO `CarCoopers`.`UserAccount` (`UserID`, `UserName`, `AccountCreationDate`, `Password`, `Status`) VALUES (12, 'Shweta', '2015-05-14', md5('shweta@1234'), 'Active');
INSERT INTO `CarCoopers`.`UserAccount` (`UserID`, `UserName`, `AccountCreationDate`, `Password`, `Status`) VALUES (13, 'KanishkR', '2015-05-12', md5('kar@1234'), 'Active');
INSERT INTO `CarCoopers`.`UserAccount` (`UserID`, `UserName`, `AccountCreationDate`, `Password`, `Status`) VALUES (14, 'VishalP', '2017-05-12', md5('vis@1234'), 'Active');
INSERT INTO `CarCoopers`.`UserAccount` (`UserID`, `UserName`, `AccountCreationDate`, `Password`, `Status`) VALUES (15, 'RajK', '2014-02-12', md5('raj@1234'), 'Active');
INSERT INTO `CarCoopers`.`UserAccount` (`UserID`, `UserName`, `AccountCreationDate`, `Password`, `Status`) VALUES (16, 'MartinP', '2013-01-12', md5('mar@1234'), 'Active');
INSERT INTO `CarCoopers`.`UserAccount` (`UserID`, `UserName`, `AccountCreationDate`, `Password`, `Status`) VALUES (17, 'Namita', '2011-01-12', md5('nam@1234'), 'Active');

COMMIT;


-- -----------------------------------------------------
-- Data for table `CarCoopers`.`OnlineCustomer`
-- -----------------------------------------------------
START TRANSACTION;
USE `CarCoopers`;
INSERT INTO `CarCoopers`.`OnlineCustomer` (`CustomerID`, `UserID`) VALUES (1, 1);
INSERT INTO `CarCoopers`.`OnlineCustomer` (`CustomerID`, `UserID`) VALUES (4, 2);
INSERT INTO `CarCoopers`.`OnlineCustomer` (`CustomerID`, `UserID`) VALUES (5, 3);
INSERT INTO `CarCoopers`.`OnlineCustomer` (`CustomerID`, `UserID`) VALUES (7, 4);
INSERT INTO `CarCoopers`.`OnlineCustomer` (`CustomerID`, `UserID`) VALUES (8, 5);
INSERT INTO `CarCoopers`.`OnlineCustomer` (`CustomerID`, `UserID`) VALUES (10, 6);
INSERT INTO `CarCoopers`.`OnlineCustomer` (`CustomerID`, `UserID`) VALUES (12, 7);
INSERT INTO `CarCoopers`.`OnlineCustomer` (`CustomerID`, `UserID`) VALUES (13, 8);
INSERT INTO `CarCoopers`.`OnlineCustomer` (`CustomerID`, `UserID`) VALUES (14, 9);
INSERT INTO `CarCoopers`.`OnlineCustomer` (`CustomerID`, `UserID`) VALUES (15, 10);
INSERT INTO `CarCoopers`.`OnlineCustomer` (`CustomerID`, `UserID`) VALUES (16, 11);
INSERT INTO `CarCoopers`.`OnlineCustomer` (`CustomerID`, `UserID`) VALUES (18, 12);
INSERT INTO `CarCoopers`.`OnlineCustomer` (`CustomerID`, `UserID`) VALUES (19, 13);
INSERT INTO `CarCoopers`.`OnlineCustomer` (`CustomerID`, `UserID`) VALUES (21, 14);
INSERT INTO `CarCoopers`.`OnlineCustomer` (`CustomerID`, `UserID`) VALUES (22, 15);
INSERT INTO `CarCoopers`.`OnlineCustomer` (`CustomerID`, `UserID`) VALUES (23, 16);
INSERT INTO `CarCoopers`.`OnlineCustomer` (`CustomerID`, `UserID`) VALUES (17, 17);

COMMIT;


-- -----------------------------------------------------
-- Data for table `CarCoopers`.`ShowroomCustomer`
-- -----------------------------------------------------
START TRANSACTION;
USE `CarCoopers`;
INSERT INTO `CarCoopers`.`ShowroomCustomer` (`CustomerID`, `ModeOfPayment`) VALUES (2, 'Cash');
INSERT INTO `CarCoopers`.`ShowroomCustomer` (`CustomerID`, `ModeOfPayment`) VALUES (3, 'Card');
INSERT INTO `CarCoopers`.`ShowroomCustomer` (`CustomerID`, `ModeOfPayment`) VALUES (6, 'Cash');
INSERT INTO `CarCoopers`.`ShowroomCustomer` (`CustomerID`, `ModeOfPayment`) VALUES (9, 'Card');
INSERT INTO `CarCoopers`.`ShowroomCustomer` (`CustomerID`, `ModeOfPayment`) VALUES (11, 'Cash');
INSERT INTO `CarCoopers`.`ShowroomCustomer` (`CustomerID`, `ModeOfPayment`) VALUES (17, 'Cash');
INSERT INTO `CarCoopers`.`ShowroomCustomer` (`CustomerID`, `ModeOfPayment`) VALUES (20, 'Card');

COMMIT;


-- -----------------------------------------------------
-- Data for table `CarCoopers`.`Showroom`
-- -----------------------------------------------------
START TRANSACTION;
USE `CarCoopers`;
INSERT INTO `CarCoopers`.`Showroom` (`ShowroomID`, `ShowroomName`, `LocationID`) VALUES (1, 'Car and Garage', 1);
INSERT INTO `CarCoopers`.`Showroom` (`ShowroomID`, `ShowroomName`, `LocationID`) VALUES (2, 'Cars and Bikes', 2);
INSERT INTO `CarCoopers`.`Showroom` (`ShowroomID`, `ShowroomName`, `LocationID`) VALUES (3, 'Lakes Showroom', 3);
INSERT INTO `CarCoopers`.`Showroom` (`ShowroomID`, `ShowroomName`, `LocationID`) VALUES (4, 'Boss Showroom', 4);
INSERT INTO `CarCoopers`.`Showroom` (`ShowroomID`, `ShowroomName`, `LocationID`) VALUES (5, 'Car Care', 5);
INSERT INTO `CarCoopers`.`Showroom` (`ShowroomID`, `ShowroomName`, `LocationID`) VALUES (6, 'Motors ', 1);
INSERT INTO `CarCoopers`.`Showroom` (`ShowroomID`, `ShowroomName`, `LocationID`) VALUES (7, 'Car Brothers', 2);
INSERT INTO `CarCoopers`.`Showroom` (`ShowroomID`, `ShowroomName`, `LocationID`) VALUES (8, 'Niks Shop', 3);
INSERT INTO `CarCoopers`.`Showroom` (`ShowroomID`, `ShowroomName`, `LocationID`) VALUES (9, 'Bike and Cars', 4);

COMMIT;


-- -----------------------------------------------------
-- Data for table `CarCoopers`.`Product`
-- -----------------------------------------------------
START TRANSACTION;
USE `CarCoopers`;
INSERT INTO `CarCoopers`.`Product` (`ProductID`, `ProductName`, `Type`, `ShowroomID`, `Price`) VALUES (1, 'Red Suzuki 456', 'Ordered', 1, 4567.23);
INSERT INTO `CarCoopers`.`Product` (`ProductID`, `ProductName`, `Type`, `ShowroomID`, `Price`) VALUES (2, 'Limelight 45', 'Stocked', 2, 2345.45);
INSERT INTO `CarCoopers`.`Product` (`ProductID`, `ProductName`, `Type`, `ShowroomID`, `Price`) VALUES (3, 'Kenzar 12', 'Ordered', 3, 7454.34);
INSERT INTO `CarCoopers`.`Product` (`ProductID`, `ProductName`, `Type`, `ShowroomID`, `Price`) VALUES (4, 'Yoyo 2', 'Ordered', 4, 2335.34);
INSERT INTO `CarCoopers`.`Product` (`ProductID`, `ProductName`, `Type`, `ShowroomID`, `Price`) VALUES (5, 'Zoom 67', 'Ordered', 5, 2423.50);
INSERT INTO `CarCoopers`.`Product` (`ProductID`, `ProductName`, `Type`, `ShowroomID`, `Price`) VALUES (6, 'Opera 78', 'Ordered', 6, 3456.50);
INSERT INTO `CarCoopers`.`Product` (`ProductID`, `ProductName`, `Type`, `ShowroomID`, `Price`) VALUES (7, 'Smash 2', 'Ordered', 7, 2345.50);
INSERT INTO `CarCoopers`.`Product` (`ProductID`, `ProductName`, `Type`, `ShowroomID`, `Price`) VALUES (8, 'Zip ', 'Ordered', 8, 5643.50);
INSERT INTO `CarCoopers`.`Product` (`ProductID`, `ProductName`, `Type`, `ShowroomID`, `Price`) VALUES (9, 'Irene 222', 'Stocked', 9, 5434.50);
INSERT INTO `CarCoopers`.`Product` (`ProductID`, `ProductName`, `Type`, `ShowroomID`, `Price`) VALUES (10, 'Benz 567', 'Stocked', 1, 5678.50);
INSERT INTO `CarCoopers`.`Product` (`ProductID`, `ProductName`, `Type`, `ShowroomID`, `Price`) VALUES (11, 'Yokohama 56', 'Stocked', 2, 5000.45);
INSERT INTO `CarCoopers`.`Product` (`ProductID`, `ProductName`, `Type`, `ShowroomID`, `Price`) VALUES (12, 'Ruby 34', 'Ordered', 3, 1234.00);
INSERT INTO `CarCoopers`.`Product` (`ProductID`, `ProductName`, `Type`, `ShowroomID`, `Price`) VALUES (13, 'Spirit X45', 'Ordered', 4, 4500.50);
INSERT INTO `CarCoopers`.`Product` (`ProductID`, `ProductName`, `Type`, `ShowroomID`, `Price`) VALUES (14, 'Rin 34', 'Ordered', 6, 5600.45);
INSERT INTO `CarCoopers`.`Product` (`ProductID`, `ProductName`, `Type`, `ShowroomID`, `Price`) VALUES (15, 'Shine Star 56', 'Ordered', 5, 2300.45);
INSERT INTO `CarCoopers`.`Product` (`ProductID`, `ProductName`, `Type`, `ShowroomID`, `Price`) VALUES (16, 'Yes 45', 'Ordered', 3, 4545.50);
INSERT INTO `CarCoopers`.`Product` (`ProductID`, `ProductName`, `Type`, `ShowroomID`, `Price`) VALUES (17, 'Yoyo 345', 'Ordered', 5, 3460.00);
INSERT INTO `CarCoopers`.`Product` (`ProductID`, `ProductName`, `Type`, `ShowroomID`, `Price`) VALUES (18, 'Rio 4545', 'Ordered', 3, 7800.00);
INSERT INTO `CarCoopers`.`Product` (`ProductID`, `ProductName`, `Type`, `ShowroomID`, `Price`) VALUES (19, 'Weny 231', 'Ordered', 2, 1200.00);
INSERT INTO `CarCoopers`.`Product` (`ProductID`, `ProductName`, `Type`, `ShowroomID`, `Price`) VALUES (20, 'Git 65', 'Ordered', 2, 4500.50);

COMMIT;


-- -----------------------------------------------------
-- Data for table `CarCoopers`.`Order`
-- -----------------------------------------------------
START TRANSACTION;
USE `CarCoopers`;
INSERT INTO `CarCoopers`.`Order` (`OrderID`, `Quantity`, `CustomiseVehicleID`, `VehicleEnterpriseID`, `VehicleAmount`, `Type`, `DeliveryDate`) VALUES (1, 20, NULL, 1, 200, 'VehicleEnterprise', '2016-02-11');
INSERT INTO `CarCoopers`.`Order` (`OrderID`, `Quantity`, `CustomiseVehicleID`, `VehicleEnterpriseID`, `VehicleAmount`, `Type`, `DeliveryDate`) VALUES (2, 43, NULL, 2, 450, 'VehicleEnterprise', '2015-04-23');
INSERT INTO `CarCoopers`.`Order` (`OrderID`, `Quantity`, `CustomiseVehicleID`, `VehicleEnterpriseID`, `VehicleAmount`, `Type`, `DeliveryDate`) VALUES (3, 34, NULL, 3, 700, 'VehicleEnterprise', '2016-03-01');
INSERT INTO `CarCoopers`.`Order` (`OrderID`, `Quantity`, `CustomiseVehicleID`, `VehicleEnterpriseID`, `VehicleAmount`, `Type`, `DeliveryDate`) VALUES (4, 200, NULL, 4, 345, 'VehicleEnterprise', '2015-05-23');
INSERT INTO `CarCoopers`.`Order` (`OrderID`, `Quantity`, `CustomiseVehicleID`, `VehicleEnterpriseID`, `VehicleAmount`, `Type`, `DeliveryDate`) VALUES (5, 342, NULL, 5, 670, 'VehicleEnterprise', '2014-09-23');
INSERT INTO `CarCoopers`.`Order` (`OrderID`, `Quantity`, `CustomiseVehicleID`, `VehicleEnterpriseID`, `VehicleAmount`, `Type`, `DeliveryDate`) VALUES (6, 30, NULL, 6, 7890, 'VehicleEnterprise', '2013-08-12');
INSERT INTO `CarCoopers`.`Order` (`OrderID`, `Quantity`, `CustomiseVehicleID`, `VehicleEnterpriseID`, `VehicleAmount`, `Type`, `DeliveryDate`) VALUES (7, 34, NULL, 7, 3456, 'VehicleEnterprise', '2014-09-03');
INSERT INTO `CarCoopers`.`Order` (`OrderID`, `Quantity`, `CustomiseVehicleID`, `VehicleEnterpriseID`, `VehicleAmount`, `Type`, `DeliveryDate`) VALUES (8, 1, 1, NULL, 3452, 'Customised', '2012-08-05');
INSERT INTO `CarCoopers`.`Order` (`OrderID`, `Quantity`, `CustomiseVehicleID`, `VehicleEnterpriseID`, `VehicleAmount`, `Type`, `DeliveryDate`) VALUES (9, 2, 2, NULL, 1234, 'Customised', '2016-09-04');
INSERT INTO `CarCoopers`.`Order` (`OrderID`, `Quantity`, `CustomiseVehicleID`, `VehicleEnterpriseID`, `VehicleAmount`, `Type`, `DeliveryDate`) VALUES (10, 1, 3, NULL, 768, 'Customised', '2016-09-06');
INSERT INTO `CarCoopers`.`Order` (`OrderID`, `Quantity`, `CustomiseVehicleID`, `VehicleEnterpriseID`, `VehicleAmount`, `Type`, `DeliveryDate`) VALUES (12, 3, 4, NULL, 456, 'Customised', '2016-09-04');
INSERT INTO `CarCoopers`.`Order` (`OrderID`, `Quantity`, `CustomiseVehicleID`, `VehicleEnterpriseID`, `VehicleAmount`, `Type`, `DeliveryDate`) VALUES (13, 1, 5, NULL, 345, 'Customised', '2006-09-23');
INSERT INTO `CarCoopers`.`Order` (`OrderID`, `Quantity`, `CustomiseVehicleID`, `VehicleEnterpriseID`, `VehicleAmount`, `Type`, `DeliveryDate`) VALUES (14, 2, 6, NULL, 334, 'Customised', '2001-09-23');
INSERT INTO `CarCoopers`.`Order` (`OrderID`, `Quantity`, `CustomiseVehicleID`, `VehicleEnterpriseID`, `VehicleAmount`, `Type`, `DeliveryDate`) VALUES (15, 4, 7, NULL, 869.30, 'Customised', '2011-09-03');
INSERT INTO `CarCoopers`.`Order` (`OrderID`, `Quantity`, `CustomiseVehicleID`, `VehicleEnterpriseID`, `VehicleAmount`, `Type`, `DeliveryDate`) VALUES (16, 2, 8, NULL, 245.30, 'Customised', '2012-09-05');
INSERT INTO `CarCoopers`.`Order` (`OrderID`, `Quantity`, `CustomiseVehicleID`, `VehicleEnterpriseID`, `VehicleAmount`, `Type`, `DeliveryDate`) VALUES (17, 4, 9, NULL, 6424.50, 'Customised', '2013-09-04');
INSERT INTO `CarCoopers`.`Order` (`OrderID`, `Quantity`, `CustomiseVehicleID`, `VehicleEnterpriseID`, `VehicleAmount`, `Type`, `DeliveryDate`) VALUES (18, 5, 10, NULL, 3434.20, 'Customised', '2016-09-06');
INSERT INTO `CarCoopers`.`Order` (`OrderID`, `Quantity`, `CustomiseVehicleID`, `VehicleEnterpriseID`, `VehicleAmount`, `Type`, `DeliveryDate`) VALUES (19, 3, 11, NULL, 634, 'Customised', '2015-09-03');
INSERT INTO `CarCoopers`.`Order` (`OrderID`, `Quantity`, `CustomiseVehicleID`, `VehicleEnterpriseID`, `VehicleAmount`, `Type`, `DeliveryDate`) VALUES (20, 5, 12, NULL, 634, 'Customised', '2015-03-05');
INSERT INTO `CarCoopers`.`Order` (`OrderID`, `Quantity`, `CustomiseVehicleID`, `VehicleEnterpriseID`, `VehicleAmount`, `Type`, `DeliveryDate`) VALUES (21, 3, 13, NULL, 2522, 'Customised', '2016-05-01');
INSERT INTO `CarCoopers`.`Order` (`OrderID`, `Quantity`, `CustomiseVehicleID`, `VehicleEnterpriseID`, `VehicleAmount`, `Type`, `DeliveryDate`) VALUES (22, 1, 14, NULL, 6433, 'Customised', '2012-02-02');
INSERT INTO `CarCoopers`.`Order` (`OrderID`, `Quantity`, `CustomiseVehicleID`, `VehicleEnterpriseID`, `VehicleAmount`, `Type`, `DeliveryDate`) VALUES (23, 1, 15, NULL, 4353, 'Customised', '2013-09-06');
INSERT INTO `CarCoopers`.`Order` (`OrderID`, `Quantity`, `CustomiseVehicleID`, `VehicleEnterpriseID`, `VehicleAmount`, `Type`, `DeliveryDate`) VALUES (24, 1, 16, NULL, 5225, 'Customised', '2013-09-05');
INSERT INTO `CarCoopers`.`Order` (`OrderID`, `Quantity`, `CustomiseVehicleID`, `VehicleEnterpriseID`, `VehicleAmount`, `Type`, `DeliveryDate`) VALUES (25, 1, 17, NULL, 5252, 'Customised', '2013-09-09');
INSERT INTO `CarCoopers`.`Order` (`OrderID`, `Quantity`, `CustomiseVehicleID`, `VehicleEnterpriseID`, `VehicleAmount`, `Type`, `DeliveryDate`) VALUES (11, 11, 18, NULL, 5212, 'Customised', '2011-09-09');

COMMIT;


-- -----------------------------------------------------
-- Data for table `CarCoopers`.`OrderedProduct`
-- -----------------------------------------------------
START TRANSACTION;
USE `CarCoopers`;
INSERT INTO `CarCoopers`.`OrderedProduct` (`ProductID`, `CustomerID`, `OrderID`) VALUES (1, 1, 8);
INSERT INTO `CarCoopers`.`OrderedProduct` (`ProductID`, `CustomerID`, `OrderID`) VALUES (3, 4, 9);
INSERT INTO `CarCoopers`.`OrderedProduct` (`ProductID`, `CustomerID`, `OrderID`) VALUES (4, 5, 10);
INSERT INTO `CarCoopers`.`OrderedProduct` (`ProductID`, `CustomerID`, `OrderID`) VALUES (5, 7, 11);
INSERT INTO `CarCoopers`.`OrderedProduct` (`ProductID`, `CustomerID`, `OrderID`) VALUES (6, 8, 12);
INSERT INTO `CarCoopers`.`OrderedProduct` (`ProductID`, `CustomerID`, `OrderID`) VALUES (7, 10, 13);
INSERT INTO `CarCoopers`.`OrderedProduct` (`ProductID`, `CustomerID`, `OrderID`) VALUES (8, 12, 14);
INSERT INTO `CarCoopers`.`OrderedProduct` (`ProductID`, `CustomerID`, `OrderID`) VALUES (12, 13, 15);
INSERT INTO `CarCoopers`.`OrderedProduct` (`ProductID`, `CustomerID`, `OrderID`) VALUES (13, 14, 16);
INSERT INTO `CarCoopers`.`OrderedProduct` (`ProductID`, `CustomerID`, `OrderID`) VALUES (14, 15, 20);
INSERT INTO `CarCoopers`.`OrderedProduct` (`ProductID`, `CustomerID`, `OrderID`) VALUES (15, 16, 21);
INSERT INTO `CarCoopers`.`OrderedProduct` (`ProductID`, `CustomerID`, `OrderID`) VALUES (16, 17, 22);
INSERT INTO `CarCoopers`.`OrderedProduct` (`ProductID`, `CustomerID`, `OrderID`) VALUES (17, 18, 23);
INSERT INTO `CarCoopers`.`OrderedProduct` (`ProductID`, `CustomerID`, `OrderID`) VALUES (18, 21, 17);
INSERT INTO `CarCoopers`.`OrderedProduct` (`ProductID`, `CustomerID`, `OrderID`) VALUES (19, 22, 18);
INSERT INTO `CarCoopers`.`OrderedProduct` (`ProductID`, `CustomerID`, `OrderID`) VALUES (20, 23, 19);

COMMIT;


-- -----------------------------------------------------
-- Data for table `CarCoopers`.`StockedProduct`
-- -----------------------------------------------------
START TRANSACTION;
USE `CarCoopers`;
INSERT INTO `CarCoopers`.`StockedProduct` (`ProductID`, `CustomerID`) VALUES (2, 2);
INSERT INTO `CarCoopers`.`StockedProduct` (`ProductID`, `CustomerID`) VALUES (9, 3);
INSERT INTO `CarCoopers`.`StockedProduct` (`ProductID`, `CustomerID`) VALUES (10, 6);
INSERT INTO `CarCoopers`.`StockedProduct` (`ProductID`, `CustomerID`) VALUES (11, 9);

COMMIT;


-- -----------------------------------------------------
-- Data for table `CarCoopers`.`CustomiseVehicle`
-- -----------------------------------------------------
START TRANSACTION;
USE `CarCoopers`;
INSERT INTO `CarCoopers`.`CustomiseVehicle` (`CustomiseVehicleID`, `Type`, `Wheel`, `Color`, `Engine`, `Battery`, `UserID`, `OrderID`) VALUES (1, 'Bike', 'Alloy', 'Red', 'three 4-cyl. turbos', 'Nickel-hydride', 1, 1);
INSERT INTO `CarCoopers`.`CustomiseVehicle` (`CustomiseVehicleID`, `Type`, `Wheel`, `Color`, `Engine`, `Battery`, `UserID`, `OrderID`) VALUES (2, 'Car', 'Steel', 'Blue', 'V-8s', 'Lead', 4, 2);
INSERT INTO `CarCoopers`.`CustomiseVehicle` (`CustomiseVehicleID`, `Type`, `Wheel`, `Color`, `Engine`, `Battery`, `UserID`, `OrderID`) VALUES (3, 'Bike', 'Steel', 'Black', 'diesel V-6', 'Nickel-hydride', 5, 3);
INSERT INTO `CarCoopers`.`CustomiseVehicle` (`CustomiseVehicleID`, `Type`, `Wheel`, `Color`, `Engine`, `Battery`, `UserID`, `OrderID`) VALUES (4, 'Bike', 'Alloy', 'Silver', 'two 2-cyl', 'Lead', 7, 4);
INSERT INTO `CarCoopers`.`CustomiseVehicle` (`CustomiseVehicleID`, `Type`, `Wheel`, `Color`, `Engine`, `Battery`, `UserID`, `OrderID`) VALUES (5, 'Car', 'Alloy', 'Green', 'three 4-cyl. turbos', 'Nickel-hydride', 8, 5);
INSERT INTO `CarCoopers`.`CustomiseVehicle` (`CustomiseVehicleID`, `Type`, `Wheel`, `Color`, `Engine`, `Battery`, `UserID`, `OrderID`) VALUES (6, 'Car', 'Alloy', ('Red,Black'), 'V-8s', 'Nickel-hydride', 10, 6);
INSERT INTO `CarCoopers`.`CustomiseVehicle` (`CustomiseVehicleID`, `Type`, `Wheel`, `Color`, `Engine`, `Battery`, `UserID`, `OrderID`) VALUES (7, 'Car', 'Steel', 'Blue', 'three 4-cyl. turbos', 'Nickel-hydride', 12, 7);
INSERT INTO `CarCoopers`.`CustomiseVehicle` (`CustomiseVehicleID`, `Type`, `Wheel`, `Color`, `Engine`, `Battery`, `UserID`, `OrderID`) VALUES (8, 'Bike', 'Steel', 'Black', 'three 4-cyl. turbos', 'Lead', 13, 8);
INSERT INTO `CarCoopers`.`CustomiseVehicle` (`CustomiseVehicleID`, `Type`, `Wheel`, `Color`, `Engine`, `Battery`, `UserID`, `OrderID`) VALUES (9, 'Bike', 'Steel', 'Silver', 'diesel V-6', 'Lead', 1, 9);
INSERT INTO `CarCoopers`.`CustomiseVehicle` (`CustomiseVehicleID`, `Type`, `Wheel`, `Color`, `Engine`, `Battery`, `UserID`, `OrderID`) VALUES (10, 'Bike', 'Steel', 'Green', 'three 4-cyl. turbos', 'Lead', 2, 10);
INSERT INTO `CarCoopers`.`CustomiseVehicle` (`CustomiseVehicleID`, `Type`, `Wheel`, `Color`, `Engine`, `Battery`, `UserID`, `OrderID`) VALUES (11, 'Car', 'Alloy', 'Red', 'V-8s', 'Lead', 3, 11);
INSERT INTO `CarCoopers`.`CustomiseVehicle` (`CustomiseVehicleID`, `Type`, `Wheel`, `Color`, `Engine`, `Battery`, `UserID`, `OrderID`) VALUES (12, 'Car', 'Alloy', 'Blue', 'three 4-cyl. turbos', 'Lead', 4, 12);
INSERT INTO `CarCoopers`.`CustomiseVehicle` (`CustomiseVehicleID`, `Type`, `Wheel`, `Color`, `Engine`, `Battery`, `UserID`, `OrderID`) VALUES (13, 'Car', 'Alloy', ('Black,Silver'), 'three 4-cyl. turbos', 'Nickel-hydride', 5, 13);
INSERT INTO `CarCoopers`.`CustomiseVehicle` (`CustomiseVehicleID`, `Type`, `Wheel`, `Color`, `Engine`, `Battery`, `UserID`, `OrderID`) VALUES (14, 'Bike', 'Steel', 'Silver', 'three 4-cyl. turbos', 'Nickel-hydride', 6, 14);
INSERT INTO `CarCoopers`.`CustomiseVehicle` (`CustomiseVehicleID`, `Type`, `Wheel`, `Color`, `Engine`, `Battery`, `UserID`, `OrderID`) VALUES (15, 'Bike', 'Steel', 'Green', 'V-8s', 'Lead', 7, 15);
INSERT INTO `CarCoopers`.`CustomiseVehicle` (`CustomiseVehicleID`, `Type`, `Wheel`, `Color`, `Engine`, `Battery`, `UserID`, `OrderID`) VALUES (16, 'Bike', 'Alloy', 'Red', 'two 2-cyl', 'Lead', 8, 16);
INSERT INTO `CarCoopers`.`CustomiseVehicle` (`CustomiseVehicleID`, `Type`, `Wheel`, `Color`, `Engine`, `Battery`, `UserID`, `OrderID`) VALUES (17, 'Bike', 'Alloy', 'Blue', 'two 2-cyl', 'Nickel-hydride', 9, 17);
INSERT INTO `CarCoopers`.`CustomiseVehicle` (`CustomiseVehicleID`, `Type`, `Wheel`, `Color`, `Engine`, `Battery`, `UserID`, `OrderID`) VALUES (18, 'Car', 'Steel', 'Black', 'diesel V-6', 'Nickel-hydride', 10, 18);
INSERT INTO `CarCoopers`.`CustomiseVehicle` (`CustomiseVehicleID`, `Type`, `Wheel`, `Color`, `Engine`, `Battery`, `UserID`, `OrderID`) VALUES (19, 'Car', 'Steel', ('Silver,Red'), 'V-8s', 'Lead', 11, 19);
INSERT INTO `CarCoopers`.`CustomiseVehicle` (`CustomiseVehicleID`, `Type`, `Wheel`, `Color`, `Engine`, `Battery`, `UserID`, `OrderID`) VALUES (20, 'Bike', 'Alloy', 'Red', 'diesel V-6', 'Nickel-hydride', 12, 20);

COMMIT;

