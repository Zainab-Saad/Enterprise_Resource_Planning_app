DELIMITER $$
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `count_po_final_payment_invoice_remaining`()
BEGIN
	SELECT COUNT(*)
    FROM purchaseorder
    WHERE isverified = 1 AND PurchaseInvoiceNum IS NULL AND FinalPaymentTrxID IS NULL;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `count_purchase_orders`()
BEGIN
	SELECT COUNT(*)
    FROM purchaseorder;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `count_verified_purchase_orders`()
BEGIN
	SELECT COUNT(*)
    FROM purchaseorder
    WHERE isverified = 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_total_payable_amount`(IN po_number VARCHAR(11))
BEGIN
UPDATE purchaseorder
SET totalpayableamount = 
				(SELECT SUM(PayableAmount)
				FROM purchaseordertransaction
				WHERE ponumber = po_number)
WHERE ponumber = po_number;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_transaction_number`(IN po_number VARCHAR(11))
BEGIN
	SELECT COUNT(*)
    FROM purchaseordertransaction
    WHERE ponumber = po_number;
END$$

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

CREATE DEFINER=`root`@`localhost` PROCEDURE `po_transactions_detail`(IN po_number VARCHAR(11))
BEGIN
	SELECT productcode, productname, quantity, rate, supplypointname, freightcharges, payableamount 
    FROM show_po_transactions_detail
    WHERE ponumber = po_number;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `po_transactions_info`(IN po_number VARCHAR(11))
BEGIN
	SELECT productcode, productname, quantity, rate, supplypointname, freightcharges, payableamount FROM show_po_transactions_detail
    WHERE ponumber = po_number;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `show_po_transactions`(IN po_number VARCHAR(11))
BEGIN
	SELECT ponumber AS 'Purchase Order Number'
    FROM purchaseorder
    JOIN purchaseordertransaction
    USING (ponumber)
    WHERE ponumber = po_number;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `show_product_info`(IN product_code VARCHAR(16))
BEGIN
	SELECT * FROM product_generic_view
    WHERE product_generic_view.productcode = product_code;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `show_purchase_order_info`(IN po_number VARCHAR(11) )
BEGIN
	SELECT * FROM purchase_order_detail
    WHERE ponumber = po_number;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `total_purchase_orders`()
BEGIN
	SELECT COUNT(*)
    FROM purchaseorder;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `transactions_detail`(IN po_number VARCHAR(11))
BEGIN
	SELECT * FROM show_po_transactions_detail
    WHERE ponumber = po_number;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `verified_purchase_order_payment_analysis`()
BEGIN
	SELECT SUM(totalpayableamount) AS total_payable_amount, SUM(totalpayableamount * advancepayment) advance_payed
    FROM purchaseorder
    WHERE isverified = 1 AND FinalPaymentTrxID IS NULL
    AND PurchaseInvoiceNum IS NULL;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `verified_purchase_orders`()
BEGIN
	SELECT COUNT(*)
    FROM purchaseorder
    WHERE isverified = 1;
END$$

DELIMITER ;


