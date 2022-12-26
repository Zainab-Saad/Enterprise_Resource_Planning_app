# Generated by Django 4.1.4 on 2022-12-18 16:01

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('base', '0001_initial'),
    ]

    operations = [
        migrations.AlterField(
            model_name='customer',
            name='isactive',
            field=models.BooleanField(db_column='IsActive', default=True),
        ),
        migrations.AlterField(
            model_name='purchaseorder',
            name='advancepaymenttrxid',
            field=models.CharField(db_column='AdvancePaymentTrxID', max_length=20, unique=True),
        ),
        migrations.AlterField(
            model_name='purchaseorder',
            name='finalpaymenttrxid',
            field=models.CharField(blank=True, db_column='FinalPaymentTrxID', default=None, max_length=20, null=True, unique=True),
        ),
        migrations.AlterField(
            model_name='saleinvoice',
            name='paymenttrxid',
            field=models.CharField(db_column='PaymentTrxID', max_length=20, unique=True),
        ),
    ]
