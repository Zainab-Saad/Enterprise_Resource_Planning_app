# Generated by Django 4.1.4 on 2022-12-25 19:38

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('base', '0008_remove_pricerate_price_rate_check_2_and_more'),
    ]

    operations = [
        migrations.AlterField(
            model_name='purchaseorder',
            name='finalpaymenttrxid',
            field=models.CharField(db_column='FinalPaymentTrxID', default=None, max_length=20, null=True, unique=True, verbose_name='Final Payment TRX ID'),
        ),
        migrations.AlterField(
            model_name='purchaseorder',
            name='purchaseinvoicenum',
            field=models.CharField(db_column='PurchaseInvoiceNum', default=None, max_length=10, null=True, unique=True, verbose_name='Purchase Invoice Number'),
        )
    ]
