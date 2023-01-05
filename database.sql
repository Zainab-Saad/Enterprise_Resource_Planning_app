-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema og_erp
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema og_erp
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `og_erp` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `og_erp` ;

-- -----------------------------------------------------
-- Table `og_erp`.`auth_group`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `og_erp`.`auth_group` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name` (`name` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `og_erp`.`django_content_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `og_erp`.`django_content_type` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `app_label` VARCHAR(100) NOT NULL,
  `model` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label` ASC, `model` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 24
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `og_erp`.`auth_permission`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `og_erp`.`auth_permission` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `content_type_id` INT NOT NULL,
  `codename` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id` ASC, `codename` ASC) VISIBLE,
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co`
    FOREIGN KEY (`content_type_id`)
    REFERENCES `og_erp`.`django_content_type` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 94
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `og_erp`.`auth_group_permissions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `og_erp`.`auth_group_permissions` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `group_id` INT NOT NULL,
  `permission_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id` ASC, `permission_id` ASC) VISIBLE,
  INDEX `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id` ASC) VISIBLE,
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm`
    FOREIGN KEY (`permission_id`)
    REFERENCES `og_erp`.`auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id`
    FOREIGN KEY (`group_id`)
    REFERENCES `og_erp`.`auth_group` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 23
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `og_erp`.`auth_user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `og_erp`.`auth_user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `password` VARCHAR(128) NOT NULL,
  `last_login` DATETIME(6) NULL DEFAULT NULL,
  `is_superuser` TINYINT(1) NOT NULL,
  `username` VARCHAR(150) NOT NULL,
  `first_name` VARCHAR(150) NOT NULL,
  `last_name` VARCHAR(150) NOT NULL,
  `email` VARCHAR(254) NOT NULL,
  `is_staff` TINYINT(1) NOT NULL,
  `is_active` TINYINT(1) NOT NULL,
  `date_joined` DATETIME(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `username` (`username` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `og_erp`.`auth_user_groups`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `og_erp`.`auth_user_groups` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `group_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id` ASC, `group_id` ASC) VISIBLE,
  INDEX `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id` ASC) VISIBLE,
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id`
    FOREIGN KEY (`group_id`)
    REFERENCES `og_erp`.`auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `og_erp`.`auth_user` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `og_erp`.`auth_user_user_permissions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `og_erp`.`auth_user_user_permissions` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `permission_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id` ASC, `permission_id` ASC) VISIBLE,
  INDEX `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id` ASC) VISIBLE,
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm`
    FOREIGN KEY (`permission_id`)
    REFERENCES `og_erp`.`auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `og_erp`.`auth_user` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `og_erp`.`carriage`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `og_erp`.`carriage` (
  `CarriageCode` VARCHAR(4) NOT NULL,
  `CarriageName` VARCHAR(30) NULL DEFAULT NULL,
  PRIMARY KEY (`CarriageCode`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `og_erp`.`city`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `og_erp`.`city` (
  `CityID` INT NOT NULL AUTO_INCREMENT,
  `CityName` VARCHAR(30) NULL DEFAULT NULL,
  `ProvinceName` VARCHAR(15) NULL DEFAULT NULL,
  PRIMARY KEY (`CityID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `og_erp`.`customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `og_erp`.`customer` (
  `CustomerCode` VARCHAR(13) NOT NULL,
  `CustomerName` VARCHAR(50) NULL DEFAULT NULL,
  `Address` VARCHAR(75) NULL DEFAULT NULL,
  `GST` VARCHAR(13) NULL DEFAULT NULL,
  `NTN` VARCHAR(8) NULL DEFAULT NULL,
  `IsActive` TINYINT(1) NOT NULL,
  PRIMARY KEY (`CustomerCode`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `og_erp`.`ldn`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `og_erp`.`ldn` (
  `LDNNumber` VARCHAR(10) NOT NULL,
  `LDNDate` DATE NULL DEFAULT NULL,
  `IsLDNVerified` TINYINT(1) NULL DEFAULT '0',
  `CarriageCode` VARCHAR(4) NULL DEFAULT NULL,
  `TruckNumber` VARCHAR(10) NULL DEFAULT NULL,
  `DriverCNIC` VARCHAR(13) NULL DEFAULT NULL,
  `CalibrationExpiryDate` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`LDNNumber`),
  INDEX `ldn_fk` (`CarriageCode` ASC) VISIBLE,
  CONSTRAINT `ldn_fk`
    FOREIGN KEY (`CarriageCode`)
    REFERENCES `og_erp`.`carriage` (`CarriageCode`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `og_erp`.`saleinvoice`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `og_erp`.`saleinvoice` (
  `InvoiceNumber` VARCHAR(11) NOT NULL,
  `InvoiceDate` DATE NULL DEFAULT NULL,
  `LDNNumber` VARCHAR(10) NULL DEFAULT NULL,
  `CustomerCode` VARCHAR(13) NULL DEFAULT NULL,
  `DeliveryCityID` INT NULL DEFAULT NULL,
  `TotalAmount` FLOAT NULL DEFAULT NULL,
  `PaymentTrxID` VARCHAR(20) NULL DEFAULT NULL,
  `CreatedBy` VARCHAR(30) NULL DEFAULT NULL,
  PRIMARY KEY (`InvoiceNumber`),
  UNIQUE INDEX `saleinvoice_PaymentTrxID_08180f11_uniq` (`PaymentTrxID` ASC) VISIBLE,
  INDEX `sale_invoice_fk_1` (`CustomerCode` ASC) VISIBLE,
  INDEX `sale_invoice_fk_2` (`DeliveryCityID` ASC) VISIBLE,
  INDEX `sale_invoice_fk_3` (`LDNNumber` ASC) VISIBLE,
  CONSTRAINT `sale_invoice_fk_1`
    FOREIGN KEY (`CustomerCode`)
    REFERENCES `og_erp`.`customer` (`CustomerCode`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `sale_invoice_fk_2`
    FOREIGN KEY (`DeliveryCityID`)
    REFERENCES `og_erp`.`city` (`CityID`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `sale_invoice_fk_3`
    FOREIGN KEY (`LDNNumber`)
    REFERENCES `og_erp`.`ldn` (`LDNNumber`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `og_erp`.`product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `og_erp`.`product` (
  `ProductCode` VARCHAR(16) NOT NULL,
  `ProductName` VARCHAR(50) NULL DEFAULT NULL,
  `Units` VARCHAR(11) NULL DEFAULT NULL,
  `IsActive` TINYINT(1) NULL DEFAULT '1',
  PRIMARY KEY (`ProductCode`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `og_erp`.`price`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `og_erp`.`price` (
  `PriceCode` VARCHAR(4) NOT NULL,
  `PriceTitle` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`PriceCode`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `og_erp`.`saleinvoicetransaction`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `og_erp`.`saleinvoicetransaction` (
  `SaleInvoiceTransactionID` INT NOT NULL AUTO_INCREMENT,
  `InvoiceNumber` VARCHAR(10) NULL DEFAULT NULL,
  `SaleTransactionNumber` INT NULL DEFAULT NULL,
  `LDNTransactionNumber` INT NULL DEFAULT NULL,
  `Gravity` FLOAT NULL DEFAULT NULL,
  `Temperature` FLOAT NULL DEFAULT NULL,
  `ProductCode` VARCHAR(16) NULL DEFAULT NULL,
  `PriceCode` VARCHAR(4) NULL DEFAULT NULL,
  `DiscountRate` FLOAT NULL DEFAULT NULL,
  `Quantity` FLOAT NULL DEFAULT NULL,
  `FreightCharges` FLOAT NULL DEFAULT NULL,
  `IsDelivered` TINYINT(1) NULL DEFAULT '0',
  PRIMARY KEY (`SaleInvoiceTransactionID`),
  INDEX `sale_inv_trans_fk_1` (`InvoiceNumber` ASC) VISIBLE,
  INDEX `sale_inv_trans_fk_2` (`ProductCode` ASC) VISIBLE,
  INDEX `sale_inv_trans_fk_3` (`PriceCode` ASC) VISIBLE,
  CONSTRAINT `sale_inv_trans_fk_1`
    FOREIGN KEY (`InvoiceNumber`)
    REFERENCES `og_erp`.`saleinvoice` (`InvoiceNumber`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `sale_inv_trans_fk_2`
    FOREIGN KEY (`ProductCode`)
    REFERENCES `og_erp`.`product` (`ProductCode`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `sale_inv_trans_fk_3`
    FOREIGN KEY (`PriceCode`)
    REFERENCES `og_erp`.`price` (`PriceCode`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `og_erp`.`customerack`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `og_erp`.`customerack` (
  `CustomerACKNumber` VARCHAR(15) NOT NULL,
  `SaleInvoiceTransactionID` INT NULL DEFAULT NULL,
  `AckQuantity` FLOAT NULL DEFAULT NULL,
  `ACKDate` DATE NULL DEFAULT NULL,
  `AckShortageQuantity` FLOAT NULL DEFAULT NULL,
  PRIMARY KEY (`CustomerACKNumber`),
  INDEX `customer_ack_fk` (`SaleInvoiceTransactionID` ASC) VISIBLE,
  CONSTRAINT `customer_ack_fk`
    FOREIGN KEY (`SaleInvoiceTransactionID`)
    REFERENCES `og_erp`.`saleinvoicetransaction` (`SaleInvoiceTransactionID`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `og_erp`.`django_admin_log`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `og_erp`.`django_admin_log` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `action_time` DATETIME(6) NOT NULL,
  `object_id` LONGTEXT NULL DEFAULT NULL,
  `object_repr` VARCHAR(200) NOT NULL,
  `action_flag` SMALLINT UNSIGNED NOT NULL,
  `change_message` LONGTEXT NOT NULL,
  `content_type_id` INT NULL DEFAULT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id` ASC) VISIBLE,
  INDEX `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id` ASC) VISIBLE,
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co`
    FOREIGN KEY (`content_type_id`)
    REFERENCES `og_erp`.`django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `og_erp`.`auth_user` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 18
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `og_erp`.`django_migrations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `og_erp`.`django_migrations` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `app` VARCHAR(255) NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `applied` DATETIME(6) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 29
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `og_erp`.`django_session`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `og_erp`.`django_session` (
  `session_key` VARCHAR(40) NOT NULL,
  `session_data` LONGTEXT NOT NULL,
  `expire_date` DATETIME(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  INDEX `django_session_expire_date_a5c62663` (`expire_date` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `og_erp`.`pricerate`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `og_erp`.`pricerate` (
  `PriceRateID` INT NOT NULL AUTO_INCREMENT,
  `PriceCode` VARCHAR(4) NULL DEFAULT NULL,
  `DateUpdated` DATE NULL DEFAULT NULL,
  `SaleTaxRate` FLOAT NULL DEFAULT NULL,
  `MaxDiscountRate` FLOAT NULL DEFAULT NULL,
  PRIMARY KEY (`PriceRateID`),
  INDEX `price_rate_fk` (`PriceCode` ASC) VISIBLE,
  CONSTRAINT `price_rate_fk`
    FOREIGN KEY (`PriceCode`)
    REFERENCES `og_erp`.`price` (`PriceCode`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 29
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `og_erp`.`productprice`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `og_erp`.`productprice` (
  `ProductPriceID` INT NOT NULL AUTO_INCREMENT,
  `ProductCode` VARCHAR(16) NULL DEFAULT NULL,
  `PriceCode` VARCHAR(4) NULL DEFAULT NULL,
  `DateAdded` DATE NULL DEFAULT NULL,
  `SellingRate` FLOAT NULL DEFAULT NULL,
  `LoadingRate` FLOAT NULL DEFAULT NULL,
  PRIMARY KEY (`ProductPriceID`),
  INDEX `product_price_fk_1` (`ProductCode` ASC) VISIBLE,
  INDEX `product_price_fk_2` (`PriceCode` ASC) VISIBLE,
  CONSTRAINT `product_price_fk_1`
    FOREIGN KEY (`ProductCode`)
    REFERENCES `og_erp`.`product` (`ProductCode`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `product_price_fk_2`
    FOREIGN KEY (`PriceCode`)
    REFERENCES `og_erp`.`price` (`PriceCode`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 17
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `og_erp`.`seller`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `og_erp`.`seller` (
  `SellerCode` VARCHAR(13) NOT NULL,
  `SellerName` VARCHAR(50) NULL DEFAULT NULL,
  `GST` VARCHAR(13) NULL DEFAULT NULL,
  `NTN` VARCHAR(8) NULL DEFAULT NULL,
  `IsActive` TINYINT(1) NULL DEFAULT '1',
  PRIMARY KEY (`SellerCode`),
  UNIQUE INDEX `seller_GST_47d89b0b_uniq` (`GST` ASC) VISIBLE,
  UNIQUE INDEX `seller_NTN_817d6d37_uniq` (`NTN` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `og_erp`.`purchaseorder`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `og_erp`.`purchaseorder` (
  `PONumber` VARCHAR(10) NOT NULL,
  `SellerCode` VARCHAR(13) NULL DEFAULT NULL,
  `PODeliveryDate` DATE NULL DEFAULT NULL,
  `TotalPayableAmount` FLOAT NULL DEFAULT NULL,
  `AdvancePayment` FLOAT NULL DEFAULT NULL,
  `AdvancePaymentTrxID` VARCHAR(20) NULL DEFAULT NULL,
  `DateCreated` DATE NULL DEFAULT NULL,
  `CreatedBy` VARCHAR(30) NULL DEFAULT NULL,
  `PurchaseInvoiceNum` VARCHAR(10) NULL DEFAULT NULL,
  `FinalPaymentTrxID` VARCHAR(20) NULL DEFAULT NULL,
  `IsVerified` TINYINT(1) NOT NULL,
  PRIMARY KEY (`PONumber`),
  UNIQUE INDEX `purchaseorder_AdvancePaymentTrxID_5af1ae0f_uniq` (`AdvancePaymentTrxID` ASC) VISIBLE,
  UNIQUE INDEX `purchaseorder_FinalPaymentTrxID_739275ef_uniq` (`FinalPaymentTrxID` ASC) VISIBLE,
  UNIQUE INDEX `purchaseorder_PurchaseInvoiceNum_7177d10e_uniq` (`PurchaseInvoiceNum` ASC) VISIBLE,
  INDEX `purchase_order_fk_1` (`SellerCode` ASC) VISIBLE,
  CONSTRAINT `purchase_order_fk_1`
    FOREIGN KEY (`SellerCode`)
    REFERENCES `og_erp`.`seller` (`SellerCode`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `og_erp`.`supplypoint`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `og_erp`.`supplypoint` (
  `SupplyPointCode` VARCHAR(11) NOT NULL,
  `SupplyPointName` VARCHAR(30) NULL DEFAULT NULL,
  `IsActive` TINYINT(1) NULL DEFAULT '1',
  PRIMARY KEY (`SupplyPointCode`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `og_erp`.`purchaseordertransaction`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `og_erp`.`purchaseordertransaction` (
  `PurchaseOrderTransactionID` INT NOT NULL AUTO_INCREMENT,
  `PONumber` VARCHAR(10) NULL DEFAULT NULL,
  `ProductCode` VARCHAR(16) NULL DEFAULT NULL,
  `Quantity` FLOAT NULL DEFAULT NULL,
  `Rate` FLOAT NULL DEFAULT NULL,
  `SupplyPointCode` VARCHAR(11) NULL DEFAULT NULL,
  `FreightCharges` FLOAT NULL DEFAULT NULL,
  `PayableAmount` FLOAT NULL DEFAULT NULL,
  `IsDelivered` TINYINT(1) NOT NULL,
  `DeliveredQuantity` FLOAT NULL DEFAULT '0',
  `DateDelivered` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`PurchaseOrderTransactionID`),
  UNIQUE INDEX `purchaseordertransaction_PONumber_ProductCode_Sup_471bd541_uniq` (`PONumber` ASC, `ProductCode` ASC, `SupplyPointCode` ASC) VISIBLE,
  INDEX `po_trans_fk_2` (`SupplyPointCode` ASC) VISIBLE,
  INDEX `po_trans_fk_3` (`ProductCode` ASC) VISIBLE,
  INDEX `purchaseordertransaction_PONumber_8d1ba5b6` (`PONumber` ASC) VISIBLE,
  CONSTRAINT `po_trans_fk_1`
    FOREIGN KEY (`PONumber`)
    REFERENCES `og_erp`.`purchaseorder` (`PONumber`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `po_trans_fk_2`
    FOREIGN KEY (`SupplyPointCode`)
    REFERENCES `og_erp`.`supplypoint` (`SupplyPointCode`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `po_trans_fk_3`
    FOREIGN KEY (`ProductCode`)
    REFERENCES `og_erp`.`product` (`ProductCode`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `og_erp`.`stock`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `og_erp`.`stock` (
  `StockID` INT NOT NULL AUTO_INCREMENT,
  `SupplyPointCode` VARCHAR(11) NULL DEFAULT NULL,
  `ProductCode` VARCHAR(16) NULL DEFAULT NULL,
  `Date` DATE NULL DEFAULT NULL,
  `Quantity` FLOAT NULL DEFAULT NULL,
  `TakenBy` VARCHAR(30) NULL DEFAULT NULL,
  PRIMARY KEY (`StockID`),
  INDEX `stock_fk_1` (`SupplyPointCode` ASC) VISIBLE,
  INDEX `stock_fk_2` (`ProductCode` ASC) VISIBLE,
  CONSTRAINT `stock_fk_1`
    FOREIGN KEY (`SupplyPointCode`)
    REFERENCES `og_erp`.`supplypoint` (`SupplyPointCode`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `stock_fk_2`
    FOREIGN KEY (`ProductCode`)
    REFERENCES `og_erp`.`product` (`ProductCode`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `og_erp`.`supplypointsproducts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `og_erp`.`supplypointsproducts` (
  `SupplyPointsProductsID` INT NOT NULL AUTO_INCREMENT,
  `SupplyPointCode` VARCHAR(10) NULL DEFAULT NULL,
  `ProductCode` VARCHAR(16) NULL DEFAULT NULL,
  PRIMARY KEY (`SupplyPointsProductsID`),
  INDEX `supply_points_products_fk_1` (`SupplyPointCode` ASC) VISIBLE,
  INDEX `supply_points_products_fk_2` (`ProductCode` ASC) VISIBLE,
  CONSTRAINT `supply_points_products_fk_1`
    FOREIGN KEY (`SupplyPointCode`)
    REFERENCES `og_erp`.`supplypoint` (`SupplyPointCode`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `supply_points_products_fk_2`
    FOREIGN KEY (`ProductCode`)
    REFERENCES `og_erp`.`product` (`ProductCode`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

USE `og_erp` ;

-- -----------------------------------------------------
-- Placeholder table for view `og_erp`.`price_generic_view`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `og_erp`.`price_generic_view` (`pricecode` INT, `pricetitle` INT, `dateupdated` INT, `saletaxrate` INT, `maxdiscountrate` INT);

-- -----------------------------------------------------
-- Placeholder table for view `og_erp`.`product_generic_view`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `og_erp`.`product_generic_view` (`ProductCode` INT, `productname` INT, `pricecode` INT, `dateadded` INT, `sellingrate` INT, `loadingrate` INT);

-- -----------------------------------------------------
-- Placeholder table for view `og_erp`.`purchase_order_detail`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `og_erp`.`purchase_order_detail` (`ponumber` INT, `totalpayableamount` INT, `podeliverydate` INT, `advancepayment` INT, `advancepaymenttrxid` INT, `username` INT, `purchaseinvoicenum` INT, `finalpaymenttrxid` INT);

-- -----------------------------------------------------
-- Placeholder table for view `og_erp`.`purchase_order_generic_view`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `og_erp`.`purchase_order_generic_view` (`Verification Status` INT, `Purchase Order Number` INT, `Seller` INT, `No Of Transactions` INT, `Date Created` INT);

-- -----------------------------------------------------
-- Placeholder table for view `og_erp`.`show_po_transactions_detail`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `og_erp`.`show_po_transactions_detail` (`ponumber` INT, `productcode` INT, `productname` INT, `quantity` INT, `rate` INT, `supplypointname` INT, `freightcharges` INT, `payableamount` INT);

-- -----------------------------------------------------
-- procedure count_completed_po
-- -----------------------------------------------------

DELIMITER $$
USE `og_erp`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `count_completed_po`()
BEGIN
	SELECT COUNT(*)
    FROM purchaseorder 
    WHERE PurchaseInvoiceNum IS NOT NULL AND FinalPaymentTrxID IS NOT NULL AND EXISTS (
				SELECT * 
                FROM purchaseordertransaction
                WHERE purchaseorder.ponumber = purchaseordertransaction.ponumber 
                AND isdelivered = 1);
    
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure count_po_final_payment_invoice_remaining
-- -----------------------------------------------------

DELIMITER $$
USE `og_erp`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `count_po_final_payment_invoice_remaining`()
BEGIN
	SELECT COUNT(*)
    FROM purchaseorder
    WHERE isverified = 1 AND PurchaseInvoiceNum IS NULL AND FinalPaymentTrxID IS NULL;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure count_purchase_orders
-- -----------------------------------------------------

DELIMITER $$
USE `og_erp`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `count_purchase_orders`()
BEGIN
	SELECT COUNT(*)
    FROM purchaseorder;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure count_verified_purchase_orders
-- -----------------------------------------------------

DELIMITER $$
USE `og_erp`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `count_verified_purchase_orders`()
BEGIN
	SELECT COUNT(*)
    FROM purchaseorder
    WHERE isverified = 1;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure get_total_payable_amount
-- -----------------------------------------------------

DELIMITER $$
USE `og_erp`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_total_payable_amount`(IN po_number VARCHAR(11))
BEGIN
UPDATE purchaseorder
SET totalpayableamount = 
				(SELECT SUM(PayableAmount)
				FROM purchaseordertransaction
				WHERE ponumber = po_number)
WHERE ponumber = po_number;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure get_transaction_number
-- -----------------------------------------------------

DELIMITER $$
USE `og_erp`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_transaction_number`(IN po_number VARCHAR(11))
BEGIN
	SELECT COUNT(*)
    FROM purchaseordertransaction
    WHERE ponumber = po_number;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure is_verification_legible
-- -----------------------------------------------------

DELIMITER $$
USE `og_erp`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `is_verification_legible`(IN po_number VARCHAR(10))
BEGIN
DECLARE var BOOLEAN;
	IF (
		(
        SELECT COUNT(*)
        FROM purchaseordertransaction
        WHERE ponumber = po_number
        ) != 0
        )
    THEN 
		SET @var = true;
    ELSE
		SET @var = false;
    END IF;
SELECT @var;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure po_transactions_detail
-- -----------------------------------------------------

DELIMITER $$
USE `og_erp`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `po_transactions_detail`(IN po_number VARCHAR(11))
BEGIN
	SELECT productcode, productname, quantity, rate, supplypointname, freightcharges, payableamount 
    FROM show_po_transactions_detail
    WHERE ponumber = po_number;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure po_transactions_info
-- -----------------------------------------------------

DELIMITER $$
USE `og_erp`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `po_transactions_info`(IN po_number VARCHAR(11))
BEGIN
	SELECT productcode, productname, quantity, rate, supplypointname, freightcharges, payableamount FROM show_po_transactions_detail
    WHERE ponumber = po_number;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure show_po_transactions
-- -----------------------------------------------------

DELIMITER $$
USE `og_erp`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `show_po_transactions`(IN po_number VARCHAR(11))
BEGIN
	SELECT ponumber AS 'Purchase Order Number'
    FROM purchaseorder
    JOIN purchaseordertransaction
    USING (ponumber)
    WHERE ponumber = po_number;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure show_product_info
-- -----------------------------------------------------

DELIMITER $$
USE `og_erp`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `show_product_info`(IN product_code VARCHAR(16))
BEGIN
	SELECT * FROM product_generic_view
    WHERE product_generic_view.productcode = product_code;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure show_purchase_order_info
-- -----------------------------------------------------

DELIMITER $$
USE `og_erp`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `show_purchase_order_info`(IN po_number VARCHAR(11) )
BEGIN
	SELECT * FROM purchase_order_detail
    WHERE ponumber = po_number;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure total_purchase_orders
-- -----------------------------------------------------

DELIMITER $$
USE `og_erp`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `total_purchase_orders`()
BEGIN
	SELECT COUNT(*)
    FROM purchaseorder;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure transactions_detail
-- -----------------------------------------------------

DELIMITER $$
USE `og_erp`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `transactions_detail`(IN po_number VARCHAR(11))
BEGIN
	SELECT * FROM show_po_transactions_detail
    WHERE ponumber = po_number;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure verified_purchase_order_payment_analysis
-- -----------------------------------------------------

DELIMITER $$
USE `og_erp`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `verified_purchase_order_payment_analysis`()
BEGIN
	SELECT SUM(totalpayableamount) AS total_payable_amount, SUM(totalpayableamount * advancepayment) advance_payed
    FROM purchaseorder
    WHERE isverified = 1 AND FinalPaymentTrxID IS NULL
    AND PurchaseInvoiceNum IS NULL;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure verified_purchase_orders
-- -----------------------------------------------------

DELIMITER $$
USE `og_erp`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `verified_purchase_orders`()
BEGIN
	SELECT COUNT(*)
    FROM purchaseorder
    WHERE isverified = 1;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- View `og_erp`.`price_generic_view`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `og_erp`.`price_generic_view`;
USE `og_erp`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `og_erp`.`price_generic_view` AS select `og_erp`.`price`.`PriceCode` AS `pricecode`,`og_erp`.`price`.`PriceTitle` AS `pricetitle`,`temp2`.`dateupdated` AS `dateupdated`,`temp2`.`saletaxrate` AS `saletaxrate`,`temp2`.`maxdiscountrate` AS `maxdiscountrate` from (`og_erp`.`price` join (select `p`.`PriceCode` AS `pricecode`,`p`.`DateUpdated` AS `dateupdated`,`p`.`SaleTaxRate` AS `saletaxrate`,`p`.`MaxDiscountRate` AS `maxdiscountrate` from `og_erp`.`pricerate` `p` where exists(select 1 from (select `og_erp`.`pricerate`.`PriceCode` AS `pricecode`,max(`og_erp`.`pricerate`.`DateUpdated`) AS `dateupdated`,max(`og_erp`.`pricerate`.`PriceRateID`) AS `pricerateid` from `og_erp`.`pricerate` group by `og_erp`.`pricerate`.`PriceCode`) `temp1` where ((`temp1`.`pricecode` = `p`.`PriceCode`) and (`temp1`.`dateupdated` = `p`.`DateUpdated`) and (`p`.`PriceRateID` = `temp1`.`pricerateid`)))) `temp2` on((`og_erp`.`price`.`PriceCode` = `temp2`.`pricecode`)));

-- -----------------------------------------------------
-- View `og_erp`.`product_generic_view`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `og_erp`.`product_generic_view`;
USE `og_erp`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `og_erp`.`product_generic_view` AS select `og_erp`.`product`.`ProductCode` AS `ProductCode`,`og_erp`.`product`.`ProductName` AS `productname`,`temp2`.`pricecode` AS `pricecode`,`temp2`.`dateadded` AS `dateadded`,`temp2`.`sellingrate` AS `sellingrate`,`temp2`.`loadingrate` AS `loadingrate` from (`og_erp`.`product` join (select `p`.`ProductCode` AS `productcode`,`p`.`PriceCode` AS `pricecode`,`p`.`DateAdded` AS `dateadded`,`p`.`SellingRate` AS `sellingrate`,`p`.`LoadingRate` AS `loadingrate` from `og_erp`.`productprice` `p` where exists(select 1 from (select `og_erp`.`productprice`.`ProductCode` AS `productcode`,`og_erp`.`productprice`.`PriceCode` AS `pricecode`,max(`og_erp`.`productprice`.`DateAdded`) AS `dateadded`,max(`og_erp`.`productprice`.`ProductPriceID`) AS `productpriceid` from `og_erp`.`productprice` group by `og_erp`.`productprice`.`ProductCode`,`og_erp`.`productprice`.`PriceCode`) `temp1` where ((`temp1`.`pricecode` = `p`.`PriceCode`) and (`temp1`.`dateadded` = `p`.`DateAdded`) and (`p`.`ProductPriceID` = `temp1`.`productpriceid`) and (`temp1`.`productcode` = `p`.`ProductCode`)))) `temp2` on((`og_erp`.`product`.`ProductCode` = `temp2`.`productcode`)));

-- -----------------------------------------------------
-- View `og_erp`.`purchase_order_detail`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `og_erp`.`purchase_order_detail`;
USE `og_erp`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `og_erp`.`purchase_order_detail` AS select `og_erp`.`purchaseorder`.`PONumber` AS `ponumber`,`og_erp`.`purchaseorder`.`TotalPayableAmount` AS `totalpayableamount`,`og_erp`.`purchaseorder`.`PODeliveryDate` AS `podeliverydate`,`og_erp`.`purchaseorder`.`AdvancePayment` AS `advancepayment`,`og_erp`.`purchaseorder`.`AdvancePaymentTrxID` AS `advancepaymenttrxid`,`og_erp`.`auth_user`.`username` AS `username`,`og_erp`.`purchaseorder`.`PurchaseInvoiceNum` AS `purchaseinvoicenum`,`og_erp`.`purchaseorder`.`FinalPaymentTrxID` AS `finalpaymenttrxid` from (`og_erp`.`purchaseorder` join `og_erp`.`auth_user` on((`og_erp`.`purchaseorder`.`CreatedBy` = `og_erp`.`auth_user`.`id`)));

-- -----------------------------------------------------
-- View `og_erp`.`purchase_order_generic_view`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `og_erp`.`purchase_order_generic_view`;
USE `og_erp`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `og_erp`.`purchase_order_generic_view` AS select if((`og_erp`.`purchaseorder`.`IsVerified` = 1),'Verified','Unverified') AS `Verification Status`,`og_erp`.`purchaseorder`.`PONumber` AS `Purchase Order Number`,`og_erp`.`seller`.`SellerName` AS `Seller`,if((`temp`.`counttrans` is null),0,`temp`.`counttrans`) AS `No Of Transactions`,`og_erp`.`purchaseorder`.`DateCreated` AS `Date Created` from ((`og_erp`.`purchaseorder` join `og_erp`.`seller` on((`og_erp`.`purchaseorder`.`SellerCode` = `og_erp`.`seller`.`SellerCode`))) left join (select `og_erp`.`purchaseordertransaction`.`PONumber` AS `ponumber`,count(0) AS `counttrans` from `og_erp`.`purchaseordertransaction` group by `og_erp`.`purchaseordertransaction`.`PONumber`) `temp` on((`og_erp`.`purchaseorder`.`PONumber` = `temp`.`ponumber`)));

-- -----------------------------------------------------
-- View `og_erp`.`show_po_transactions_detail`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `og_erp`.`show_po_transactions_detail`;
USE `og_erp`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `og_erp`.`show_po_transactions_detail` AS select `og_erp`.`purchaseordertransaction`.`PONumber` AS `ponumber`,`og_erp`.`purchaseordertransaction`.`ProductCode` AS `productcode`,`og_erp`.`product`.`ProductName` AS `productname`,`og_erp`.`purchaseordertransaction`.`Quantity` AS `quantity`,`og_erp`.`purchaseordertransaction`.`Rate` AS `rate`,`og_erp`.`supplypoint`.`SupplyPointName` AS `supplypointname`,`og_erp`.`purchaseordertransaction`.`FreightCharges` AS `freightcharges`,`og_erp`.`purchaseordertransaction`.`PayableAmount` AS `payableamount` from ((`og_erp`.`purchaseordertransaction` join `og_erp`.`supplypoint` on((`og_erp`.`purchaseordertransaction`.`SupplyPointCode` = `og_erp`.`supplypoint`.`SupplyPointCode`))) join `og_erp`.`product` on((`og_erp`.`purchaseordertransaction`.`ProductCode` = `og_erp`.`product`.`ProductCode`)));

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
