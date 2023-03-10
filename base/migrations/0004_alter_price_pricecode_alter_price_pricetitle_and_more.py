# Generated by Django 4.1.4 on 2022-12-21 11:27

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('base', '0003_purchaseorder_isverified_and_more'),
    ]

    operations = [
        migrations.AlterField(
            model_name='price',
            name='pricecode',
            field=models.CharField(db_column='PriceCode', max_length=4, primary_key=True, serialize=False, verbose_name='Price Code'),
        ),
        migrations.AlterField(
            model_name='price',
            name='pricetitle',
            field=models.CharField(db_column='PriceTitle', max_length=50, verbose_name='Price Title'),
        ),
        migrations.AlterField(
            model_name='pricerate',
            name='maxdiscountrate',
            field=models.FloatField(db_column='MaxDiscountRate', verbose_name='Price Max Discount Rate'),
        ),
        migrations.AlterField(
            model_name='pricerate',
            name='saletaxrate',
            field=models.FloatField(db_column='SaleTaxRate', verbose_name='Price Sale Tax Rate'),
        ),
    ]
