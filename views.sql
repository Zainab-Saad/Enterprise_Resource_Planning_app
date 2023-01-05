CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `price_generic_view` AS
    SELECT 
        `price`.`PriceCode` AS `pricecode`,
        `price`.`PriceTitle` AS `pricetitle`,
        `temp2`.`dateupdated` AS `dateupdated`,
        `temp2`.`saletaxrate` AS `saletaxrate`,
        `temp2`.`maxdiscountrate` AS `maxdiscountrate`
    FROM
        (`price`
        JOIN (SELECT 
            `p`.`PriceCode` AS `pricecode`,
                `p`.`DateUpdated` AS `dateupdated`,
                `p`.`SaleTaxRate` AS `saletaxrate`,
                `p`.`MaxDiscountRate` AS `maxdiscountrate`
        FROM
            `pricerate` `p`
        WHERE
            EXISTS( SELECT 
                    1
                FROM
                    (SELECT 
                    `pricerate`.`PriceCode` AS `pricecode`,
                        MAX(`pricerate`.`DateUpdated`) AS `dateupdated`,
                        MAX(`pricerate`.`PriceRateID`) AS `pricerateid`
                FROM
                    `pricerate`
                GROUP BY `pricerate`.`PriceCode`) `temp1`
                WHERE
                    ((`temp1`.`pricecode` = `p`.`PriceCode`)
                        AND (`temp1`.`dateupdated` = `p`.`DateUpdated`)
                        AND (`p`.`PriceRateID` = `temp1`.`pricerateid`)))) `temp2` ON ((`price`.`PriceCode` = `temp2`.`pricecode`)));
                        
CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `product_generic_view` AS
    SELECT 
        `product`.`ProductCode` AS `ProductCode`,
        `product`.`ProductName` AS `productname`,
        `temp2`.`pricecode` AS `pricecode`,
        `temp2`.`dateadded` AS `dateadded`,
        `temp2`.`sellingrate` AS `sellingrate`,
        `temp2`.`loadingrate` AS `loadingrate`
    FROM
        (`product`
        JOIN (SELECT 
            `p`.`ProductCode` AS `productcode`,
                `p`.`PriceCode` AS `pricecode`,
                `p`.`DateAdded` AS `dateadded`,
                `p`.`SellingRate` AS `sellingrate`,
                `p`.`LoadingRate` AS `loadingrate`
        FROM
            `productprice` `p`
        WHERE
            EXISTS( SELECT 
                    1
                FROM
                    (SELECT 
                    `productprice`.`ProductCode` AS `productcode`,
                        `productprice`.`PriceCode` AS `pricecode`,
                        MAX(`productprice`.`DateAdded`) AS `dateadded`,
                        MAX(`productprice`.`ProductPriceID`) AS `productpriceid`
                FROM
                    `productprice`
                GROUP BY `productprice`.`ProductCode` , `productprice`.`PriceCode`) `temp1`
                WHERE
                    ((`temp1`.`pricecode` = `p`.`PriceCode`)
                        AND (`temp1`.`dateadded` = `p`.`DateAdded`)
                        AND (`p`.`ProductPriceID` = `temp1`.`productpriceid`)
                        AND (`temp1`.`productcode` = `p`.`ProductCode`)))) `temp2` ON ((`product`.`ProductCode` = `temp2`.`productcode`)));
					
CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `purchase_order_detail` AS
    SELECT 
        `purchaseorder`.`PONumber` AS `ponumber`,
        `purchaseorder`.`TotalPayableAmount` AS `totalpayableamount`,
        `purchaseorder`.`PODeliveryDate` AS `podeliverydate`,
        `purchaseorder`.`AdvancePayment` AS `advancepayment`,
        `purchaseorder`.`AdvancePaymentTrxID` AS `advancepaymenttrxid`,
        `auth_user`.`username` AS `username`,
        `purchaseorder`.`PurchaseInvoiceNum` AS `purchaseinvoicenum`,
        `purchaseorder`.`FinalPaymentTrxID` AS `finalpaymenttrxid`
    FROM
        (`purchaseorder`
        JOIN `auth_user` ON ((`purchaseorder`.`CreatedBy` = `auth_user`.`id`)))
        
CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `purchase_order_generic_view` AS
    SELECT 
        IF((`purchaseorder`.`IsVerified` = 1),
            'Verified',
            'Unverified') AS `Verification Status`,
        `purchaseorder`.`PONumber` AS `Purchase Order Number`,
        `seller`.`SellerName` AS `Seller`,
        IF((`temp`.`counttrans` IS NULL),
            0,
            `temp`.`counttrans`) AS `No Of Transactions`,
        `purchaseorder`.`DateCreated` AS `Date Created`
    FROM
        ((`purchaseorder`
        JOIN `seller` ON ((`purchaseorder`.`SellerCode` = `seller`.`SellerCode`)))
        LEFT JOIN (SELECT 
            `purchaseordertransaction`.`PONumber` AS `ponumber`,
                COUNT(0) AS `counttrans`
        FROM
            `purchaseordertransaction`
        GROUP BY `purchaseordertransaction`.`PONumber`) `temp` ON ((`purchaseorder`.`PONumber` = `temp`.`ponumber`)));
        
CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `show_po_transactions_detail` AS
    SELECT 
        `purchaseordertransaction`.`PONumber` AS `ponumber`,
        `purchaseordertransaction`.`ProductCode` AS `productcode`,
        `product`.`ProductName` AS `productname`,
        `purchaseordertransaction`.`Quantity` AS `quantity`,
        `purchaseordertransaction`.`Rate` AS `rate`,
        `supplypoint`.`SupplyPointName` AS `supplypointname`,
        `purchaseordertransaction`.`FreightCharges` AS `freightcharges`,
        `purchaseordertransaction`.`PayableAmount` AS `payableamount`
    FROM
        ((`purchaseordertransaction`
        JOIN `supplypoint` ON ((`purchaseordertransaction`.`SupplyPointCode` = `supplypoint`.`SupplyPointCode`)))
        JOIN `product` ON ((`purchaseordertransaction`.`ProductCode` = `product`.`ProductCode`)))