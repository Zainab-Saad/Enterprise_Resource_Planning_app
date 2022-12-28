from django.db.models import CheckConstraint, Q
from django.db import models
from django.contrib.auth.models import User
from datetime import date


class Carriage(models.Model):
    carriagecode = models.CharField(db_column='CarriageCode', primary_key=True, max_length=4)  # Field name made lowercase.
    carriagename = models.CharField(db_column='CarriageName', max_length=30)  # Field name made lowercase.

    class Meta:
        # managed = False
        db_table = 'carriage'
    
    def __str__(self):
        return self.carriagename


class City(models.Model):
    cityid = models.AutoField(db_column='CityID', primary_key=True)  # Field name made lowercase.
    cityname = models.CharField(db_column='CityName', max_length=30)  # Field name made lowercase.
    provincename = models.CharField(db_column='ProvinceName', max_length=15)  # Field name made lowercase.

    class Meta:
        # managed = False
        db_table = 'city'
    
    def __str__(self):
        return self.cityname


class Customer(models.Model):
    customercode = models.CharField(db_column='CustomerCode', primary_key=True, max_length=13)  # Field name made lowercase.
    customername = models.CharField(db_column='CustomerName', max_length=50)  # Field name made lowercase.
    address = models.CharField(db_column='Address', max_length=75)  # Field name made lowercase.
    gst = models.CharField(db_column='GST', max_length=13)  # Field name made lowercase.
    ntn = models.CharField(db_column='NTN', max_length=8)  # Field name made lowercase.
    isactive = models.BooleanField(db_column='IsActive', default=True)  # Field name made lowercase.

    class Meta:
        # managed = False
        db_table = 'customer'
    
    def __str__(self):
        return self.customercode


class Customerack(models.Model):
    customeracknumber = models.CharField(db_column='CustomerACKNumber', primary_key=True, max_length=15)  # Field name made lowercase.
    saleinvoicetransactionid = models.ForeignKey('Saleinvoicetransaction', on_delete=models.RESTRICT, db_column='SaleInvoiceTransactionID', related_name='invoivenumbercustack')  # Field name made lowercase.
    ackquantity = models.FloatField(db_column='AckQuantity')  # Field name made lowercase.
    ackdate = models.DateField(auto_now_add=True,db_column='ACKDate')  # Field name made lowercase.
    ackshortagequantity = models.FloatField(db_column='AckShortageQuantity')  # Field name made lowercase.

    class Meta:
        # managed = False
        db_table = 'customerack'
        constraints = [
            CheckConstraint(
                check = Q(ackquantity__gt=0), 
                name = 'customer_ack_check_01',
            ),
            CheckConstraint(
                check = Q(ackshortagequantity__gte=0), 
                name = 'customer_ack_check_02',
            ),
        ]
    
    def __str__(self):
        return self.customeracknumber


class Ldn(models.Model):
    ldnnumber = models.CharField(db_column='LDNNumber', primary_key=True, max_length=10)  # Field name made lowercase.
    ldndate = models.DateField(auto_now_add=True,db_column='LDNDate')  # Field name made lowercase.
    isldnverified = models.IntegerField(db_column='IsLDNVerified', default=False)  # Field name made lowercase.
    carriagecode = models.ForeignKey(Carriage,on_delete=models.RESTRICT, db_column='CarriageCode')  # Field name made lowercase.
    trucknumber = models.CharField(db_column='TruckNumber', max_length=10)  # Field name made lowercase.
    drivercnic = models.CharField(db_column='DriverCNIC', max_length=13)  # Field name made lowercase.
    calibrationexpirydate = models.DateField(db_column='CalibrationExpiryDate')  # Field name made lowercase.

    class Meta:
        # managed = False
        db_table = 'ldn'
    
    def __str__(self):
        return self.ldnnumber


class Price(models.Model):
    pricecode = models.CharField('Price Code', db_column='PriceCode', primary_key=True, max_length=4)  # Field name made lowercase.
    pricetitle = models.CharField('Price Title', db_column='PriceTitle', max_length=50)  # Field name made lowercase.

    class Meta:
        # managed = False
        db_table = 'price'
    
    def __str__(self):
        return self.pricecode


class Pricerate(models.Model):
    pricerateid = models.AutoField(db_column='PriceRateID', primary_key=True)  # Field name made lowercase.
    pricecode = models.ForeignKey(Price, on_delete=models.RESTRICT, db_column='PriceCode')  # Field name made lowercase.
    dateupdated = models.DateField(auto_now_add=True,db_column='DateUpdated')  # Field name made lowercase.
    saletaxrate = models.FloatField('Price Sale Tax Rate', db_column='SaleTaxRate')  # Field name made lowercase.
    maxdiscountrate = models.FloatField('Price Max Discount Rate', db_column='MaxDiscountRate')  # Field name made lowercase.

    class Meta:
        # managed = False
        db_table = 'pricerate'
        unique_together = (('pricecode', 'dateupdated'),)
        constraints = [
            CheckConstraint(
                check = Q(saletaxrate__gt=0), 
                name = 'price_rate_check_1',
            ),
            CheckConstraint(
                check = Q(maxdiscountrate__gt=0) & Q(maxdiscountrate__lt=100), 
                name = 'price_rate_check_2',
            ),
            CheckConstraint(
                check = Q(maxdiscountrate__gt=0) & Q(maxdiscountrate__lt=100), 
                name = 'price_rate_check_3',
            ),
        ]
        


class Product(models.Model):
    productcode = models.CharField('Product Code', db_column='ProductCode', primary_key=True, max_length=16)  # Field name made lowercase.
    productname = models.CharField('Product Name', db_column='ProductName', max_length=50)  # Field name made lowercase.
    units = models.CharField('Units', db_column='Units', max_length=11)  # Field name made lowercase.
    isactive = models.BooleanField('Is Active', db_column='IsActive', default=True)  # Field name made lowercase.

    class Meta:
        # managed = False
        db_table = 'product'
    
    def __str__(self):
        return self.productname

class Productprice(models.Model):
    productpriceid = models.AutoField(db_column='ProductPriceID', primary_key=True)  # Field name made lowercase.
    productcode = models.ForeignKey(Product, on_delete=models.RESTRICT, db_column='ProductCode')  # Field name made lowercase.
    pricecode = models.ForeignKey(Price, on_delete=models.RESTRICT, db_column='PriceCode')  # Field name made lowercase.
    dateadded = models.DateField(auto_now_add=True,db_column='DateAdded')  # Field name made lowercase.
    sellingrate = models.FloatField('Selling rate', db_column='SellingRate')  # Field name made lowercase.
    loadingrate = models.FloatField('Loading Rate', db_column='LoadingRate')  # Field name made lowercase.

    class Meta:
        # managed = False
        db_table = 'productprice'
        unique_together = (('productcode', 'pricecode', 'dateadded'),)
        constraints = [
            CheckConstraint(
                check = Q(sellingrate__gt=0), 
                name = 'product_price_check_1',
            ),
            CheckConstraint(
                check = Q(loadingrate__gt=0), 
                name = 'product_price_check_2',
            ),
        ]


class Purchaseorder(models.Model):
    ponumber = models.CharField('Purchase Order Number', db_column='PONumber', primary_key=True, max_length=10)  # Field name made lowercase.
    sellercode = models.ForeignKey('Seller', on_delete=models.RESTRICT, db_column='SellerCode')  # Field name made lowercase.
    podeliverydate = models.DateField('Purchase Order Delievery Date', db_column='PODeliveryDate')  # Field name made lowercase.
    totalpayableamount = models.FloatField(db_column='TotalPayableAmount', blank=True)  # Field name made lowercase.
    advancepayment = models.FloatField('Advance Payment (0-1)', db_column='AdvancePayment')  # Field name made lowercase.
    advancepaymenttrxid = models.CharField('Advance Payment TRX ID', db_column='AdvancePaymentTrxID', max_length=20, unique=True)  # Field name made lowercase.
    datecreated = models.DateField(auto_now_add=True, db_column='DateCreated')  # Field name made lowercase.
    createdby = models.ForeignKey(User,db_column='CreatedBy', on_delete=models.RESTRICT)  # Field name made lowercase.
    purchaseinvoicenum = models.CharField('Purchase Invoice Number', db_column='PurchaseInvoiceNum', max_length=10, default=None, null=True, unique=True)  # Field name made lowercase.
    finalpaymenttrxid = models.CharField('Final Payment TRX ID', db_column='FinalPaymentTrxID', max_length=20, default=None, null=True, unique=True)  # Field name made lowercase.
    isverified = models.BooleanField(db_column='IsVerified', default=False)
    # CONSTRAINT purchase_order_check
		# CHECK (TotalPayableAmount > 0 AND (AdvancePayment BETWEEN 0 AND 1))
    class Meta:
        # managed = False
        db_table = 'purchaseorder'
        constraints = [
            CheckConstraint(
                check = Q(totalpayableamount__gt=0), 
                name = 'purchase_order_check_1',
            ),
            CheckConstraint(
                check = Q(advancepayment__gte=0)
                & Q(advancepayment__lte=1), 
                name = 'purchase_order_check_2',
            ),
            CheckConstraint(
                check = Q(podeliverydate__gte=models.F('datecreated')),
                name = 'purchase_order_chek_3'
            )
        ]
        permissions = [('verify_purchaseorder', 'verify purchase order')]

    def __str__(self):
        return self.ponumber


class Purchaseordertransaction(models.Model):
    purchaseordertransactionid = models.AutoField(db_column='PurchaseOrderTransactionID', primary_key=True)  # Field name made lowercase.
    ponumber = models.ForeignKey(Purchaseorder, on_delete=models.CASCADE, db_column='PONumber')  # Field name made lowercase.
    # potransactionnum = models.IntegerField(db_column='POTransactionNum')  # Field name made lowercase.
    productcode = models.ForeignKey(Product, on_delete=models.RESTRICT, db_column='ProductCode')  # Field name made lowercase.
    quantity = models.FloatField(db_column='Quantity')  # Field name made lowercase.
    supplypointcode = models.ForeignKey('Supplypoint', on_delete=models.RESTRICT, db_column='SupplyPointCode')  # Field name made lowercase.
    rate = models.FloatField(db_column='Rate')  # Field name made lowercase.models.ForeignKey('Supplypoint', on_delete=models.RESTRICT, db_column='SupplyPointCode')  # Field name made lowercase.
    freightcharges = models.FloatField(db_column='FreightCharges')  # Field name made lowercase.
    payableamount = models.FloatField(db_column='PayableAmount')  # Field name made lowercase.
    isdelivered = models.BooleanField(db_column='IsDelivered', default=False, blank=False)  # Field name made lowercase.
    deliveredquantity = models.FloatField(db_column='DeliveredQuantity', blank=True)  # Field name made lowercase.
    datedelivered = models.DateField(db_column='DateDelivered', blank=True, null=True)  # Field name made lowercase.

    class Meta:
        # managed = False
        db_table = 'purchaseordertransaction'
        unique_together = (('ponumber', 'productcode', 'supplypointcode'),)
        constraints = [
            # CheckConstraint(
            #     check = Q(potransactionnum__gt=0), 
            #     name = 'purchase_order_trans_check_1',
            # ),
            CheckConstraint(
                check = Q(quantity__gt=0), 
                name = 'purchase_order_trans_check_2',
            ),
            CheckConstraint(
                check = Q(rate__gt=0), 
                name = 'purchase_order_trans_check_3',
            ),
            CheckConstraint(
                check = Q(freightcharges__gte=0), 
                name = 'purchase_order_trans_check_4',
            ),
            CheckConstraint(
                check = Q(payableamount__gt=0), 
                name = 'purchase_order_trans_check_5',
            ),
            CheckConstraint(
                check = Q(deliveredquantity__gt=0), 
                name = 'purchase_order_trans_check_6',
            ),
        ]


class Saleinvoice(models.Model):
    invoicenumber = models.CharField(db_column='InvoiceNumber', primary_key=True, max_length=11)  # Field name made lowercase.
    invoicedate = models.DateField(auto_now_add=True, db_column='InvoiceDate')  # Field name made lowercase.
    ldnnumber = models.ForeignKey(Ldn, on_delete=models.RESTRICT, db_column='LDNNumber', blank=True)  # Field name made lowercase.
    customercode = models.ForeignKey(Customer, on_delete=models.RESTRICT, db_column='CustomerCode')  # Field name made lowercase.
    deliverycityid = models.ForeignKey(City, on_delete=models.RESTRICT, db_column='DeliveryCityID')  # Field name made lowercase.
    totalamount = models.FloatField(db_column='TotalAmount')  # Field name made lowercase.
    paymenttrxid = models.CharField(db_column='PaymentTrxID', max_length=20, unique=True)  # Field name made lowercase.
    createdby = models.ForeignKey(User, db_column='CreatedBy', on_delete=models.RESTRICT)  # Field name made lowercase.

    # CONSTRAINT sale_invoice_check
	# 	CHECK (TotalAmount > 0)
    class Meta:
        # managed = False
        db_table = 'saleinvoice'
        constraints = [
            CheckConstraint(
                check = Q(totalamount__gt=0), 
                name = 'sale_invoice_check_1',
            ),
        ]
    
    def __str__(self):
        return self.invoicenumber


class Saleinvoicetransaction(models.Model):
    saleinvoicetransactionid = models.AutoField(db_column='SaleInvoiceTransactionID', primary_key=True)  # Field name made lowercase.
    invoicenumber = models.ForeignKey(Saleinvoice, on_delete=models.RESTRICT, db_column='InvoiceNumber')  # Field name made lowercase.
    saletransactionnumber = models.IntegerField(db_column='SaleTransactionNumber')  # Field name made lowercase.
    ldntransactionnumber = models.IntegerField(db_column='LDNTransactionNumber')  # Field name made lowercase.
    gravity = models.FloatField(db_column='Gravity')  # Field name made lowercase.
    temperature = models.FloatField(db_column='Temperature')  # Field name made lowercase.
    productcode = models.ForeignKey(Product,on_delete=models.RESTRICT, db_column='ProductCode')  # Field name made lowercase.
    pricecode = models.ForeignKey(Price, on_delete=models.RESTRICT, db_column='PriceCode')  # Field name made lowercase.
    discountrate = models.FloatField(db_column='DiscountRate')  # Field name made lowercase.
    quantity = models.FloatField(db_column='Quantity')  # Field name made lowercase.
    freightcharges = models.FloatField(db_column='FreightCharges')  # Field name made lowercase.
    isdelivered = models.IntegerField(db_column='IsDelivered', default=False)  # Field name made lowercase.

    class Meta:
        # managed = False
        db_table = 'saleinvoicetransaction'
        unique_together = (('invoicenumber', 'saletransactionnumber'),)
        constraints = [
            CheckConstraint(
                check = Q(saletransactionnumber__gt=0), 
                name = 'sale_invoice_trans_check_1',
            ),
            CheckConstraint(
                check = Q(ldntransactionnumber__gt=0), 
                name = 'sale_invoice_trans_check_2',
            ),
            CheckConstraint(
                check = Q(gravity__gt=0)
                & Q(gravity__lt=1), 
                name = 'sale_invoice_trans_check_3',
            ),
            CheckConstraint(
                check = Q(temperature__gt=0), 
                name = 'sale_invoice_trans_check_4',
            ),
            CheckConstraint(
                check = Q(discountrate__gte=0)
                & Q(discountrate__lte=100), 
                name = 'sale_invoice_trans_check_5',
            ),
            CheckConstraint(
                check = Q(quantity__gt=0), 
                name = 'sale_invoice_trans_check_6',
            ),
            CheckConstraint(
                check = Q(freightcharges__gte=0), 
                name = 'sale_invoice_trans_check_7',
            ),
        ]


class Seller(models.Model):
    sellercode = models.CharField('Seller Code', db_column='SellerCode', primary_key=True, max_length=13)  # Field name made lowercase.
    sellername = models.CharField('Seller Name', db_column='SellerName', max_length=50)  # Field name made lowercase.
    gst = models.CharField('Seller GST', db_column='GST', max_length=13, unique=True)  # Field name made lowercase.
    ntn = models.CharField('Seller NTN', db_column='NTN', max_length=8, unique=True)  # Field name made lowercase.
    isactive = models.BooleanField('Seller Active or Not', default=True, db_column='IsActive', blank=True)  # Field name made lowercase.

    class Meta:
        # managed = False
        db_table = 'seller'
    
    def __str__(self):
        return self.sellername + "-" + self.ntn


class Stock(models.Model):
    stockid = models.AutoField(db_column='StockID', primary_key=True)  # Field name made lowercase.
    supplypointcode = models.ForeignKey('Supplypoint',on_delete=models.RESTRICT, db_column='SupplyPointCode')  # Field name made lowercase.
    productcode = models.ForeignKey(Product, on_delete=models.RESTRICT, db_column='ProductCode')  # Field name made lowercase.
    date = models.DateField(auto_now_add=True, db_column='Date')  # Field name made lowercase.
    quantity = models.FloatField(db_column='Quantity')  # Field name made lowercase.
    takenby = models.ForeignKey(User, db_column='TakenBy', max_length=30, on_delete=models.RESTRICT)  # Field name made lowercase.

    class Meta:
        # managed = False
        db_table = 'stock'
        unique_together = (('supplypointcode', 'productcode', 'date'),)
        constraints = [
            CheckConstraint(
                check = Q(quantity__gte=0), 
                name = 'stock_check_1',
            )
        ]
    


class Supplypoint(models.Model):
    supplypointcode = models.CharField(db_column='SupplyPointCode', primary_key=True, max_length=11)  # Field name made lowercase.
    supplypointname = models.CharField(db_column='SupplyPointName', max_length=30)  # Field name made lowercase.
    isactive = models.BooleanField(default=True, db_column='IsActive')  # Field name made lowercase.

    class Meta:
        # managed = False
        db_table = 'supplypoint'
        
    def __str__(self):
        return self.supplypointname


class Supplypointsproducts(models.Model):
    supplypointsproductsid = models.AutoField(db_column='SupplyPointsProductsID', primary_key=True)  # Field name made lowercase.
    supplypointcode = models.ForeignKey(Supplypoint, on_delete=models.RESTRICT, db_column='SupplyPointCode')  # Field name made lowercase.
    productcode = models.ForeignKey(Product, on_delete=models.RESTRICT, db_column='ProductCode')  # Field name made lowercase.

    class Meta:
        # managed = False
        db_table = 'supplypointsproducts'
        unique_together = (('supplypointcode', 'productcode'),)