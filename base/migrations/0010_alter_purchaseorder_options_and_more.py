# Generated by Django 4.1.4 on 2022-12-28 05:18

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('base', '0009_remove_pricerate_price_rate_check_2_and_more'),
    ]

    operations = [
        migrations.AlterModelOptions(
            name='purchaseorder',
            options={'permissions': [('verify_purchaseorder', 'verify purchase order')]},
        ),
    ]
