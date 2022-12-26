# Generated by Django 4.1.4 on 2022-12-22 05:53

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('base', '0004_alter_price_pricecode_alter_price_pricetitle_and_more'),
    ]

    operations = [
        migrations.AlterField(
            model_name='product',
            name='isactive',
            field=models.BooleanField(db_column='IsActive', default=True, verbose_name='Is Active'),
        ),
        migrations.AlterField(
            model_name='product',
            name='productcode',
            field=models.CharField(db_column='ProductCode', max_length=16, primary_key=True, serialize=False, verbose_name='Product Code'),
        ),
        migrations.AlterField(
            model_name='product',
            name='productname',
            field=models.CharField(db_column='ProductName', max_length=50, verbose_name='Product Name'),
        ),
        migrations.AlterField(
            model_name='product',
            name='units',
            field=models.CharField(db_column='Units', max_length=11, verbose_name='Units'),
        ),
        migrations.AlterField(
            model_name='productprice',
            name='loadingrate',
            field=models.FloatField(db_column='LoadingRate', verbose_name='Loading Rate'),
        ),
        migrations.AlterField(
            model_name='productprice',
            name='sellingrate',
            field=models.FloatField(db_column='SellingRate', verbose_name='Selling rate'),
        )
    ]
