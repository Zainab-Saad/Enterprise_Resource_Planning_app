from django.forms import ModelForm, inlineformset_factory
from django import forms
from django.db.models import CheckConstraint, Q
from .models import Purchaseorder, Customer, City, Seller, Product, Purchaseordertransaction, Saleinvoice, Price, Pricerate, Productprice
from datetime import date

class DateInput(forms.DateInput):
    input_type = 'date'
    
    
class PurchaseOrderForm(ModelForm):
    def __init__(self, *args, **kwargs):
        super(PurchaseOrderForm, self).__init__(*args, **kwargs)
        self.fields['sellercode'].queryset = Seller.objects.filter(
                                                                    isactive=True
                                                                )
    class Meta:
        model = Purchaseorder
        fields = ('ponumber', 'sellercode', 'podeliverydate', 'advancepayment', 'advancepaymenttrxid', 
                  )
        widgets = {
            'podeliverydate': DateInput(),
        }
    
    def clean_podeliverydate(self):
        po_delieverydate = self.cleaned_data['podeliverydate']
        if po_delieverydate < date.today():
            raise forms.ValidationError('Delivery Date not chosen correctly')
        return po_delieverydate

class PurchaseOrderUpdateForm_Unverified(ModelForm):
    def __init__(self, *args, **kwargs):
        super(PurchaseOrderUpdateForm_Unverified, self).__init__(*args, **kwargs)
        self.fields['sellercode'].queryset = Seller.objects.filter(
                                                                    isactive=True
                                                                )
        
    class Meta:
        model = Purchaseorder
        exclude = ('isverified', 'purchaseinvoicenum', 'finalpaymenttrxid', 'createdby')
        
        widgets = {
        'totalpayableamount': forms.TextInput(attrs={'readonly': True}),
        'ponumber': forms.TextInput(attrs={'readonly': True}),
        'podeliverydate': DateInput(),
    }
    
    def clean_podeliverydate(self):
        po_delieverydate = self.cleaned_data['podeliverydate']
        if po_delieverydate < self.instance.datecreated:
            raise forms.ValidationError('Delivery Date not chosen correctly')
        return po_delieverydate


class PurchaseOrderUpdateForm_Verified(ModelForm):
    class Meta:
        model = Purchaseorder
        fields = '__all__'
        widgets = {
        'ponumber': forms.TextInput(attrs={'readonly': True}),
        'sellercode': forms.TextInput(attrs={'readonly': True}),
        'podeliverydate': forms.TextInput(attrs={'readonly': True}),
        'totalpayableamount': forms.TextInput(attrs={'readonly': True}),
        'advancepayment': forms.TextInput(attrs={'readonly': True}),
        'advancepaymenttrxid': forms.TextInput(attrs={'readonly': True}),
        'datecreated': DateInput(),
        'createdby': forms.TextInput(attrs={'readonly': True}),
        'isverified': forms.TextInput(attrs={'readonly': True}),

    }

class CustomerForm(ModelForm):
    class Meta:
        model = Customer
        fields = '__all__'

class CityForm(ModelForm):
    class Meta:
        model = City
        fields = '__all__'
        
    
class SellerForm(ModelForm):
    class Meta:
        model = Seller
        fields = '__all__'
        
        
class ProductForm(ModelForm):
    class Meta:
        model = Product
        fields = '__all__'
        
class SaleInvoiceForm(ModelForm):
    class Meta:
        model = Saleinvoice
        fields = ('invoicenumber', 'customercode', 'deliverycityid',
                'paymenttrxid', 'createdby'
        )
    

class PriceForm(ModelForm):
    class Meta:
        model = Price
        fields = '__all__'
        
class PriceRateForm(ModelForm):
    class Meta:
        model = Pricerate
        fields = '__all__'
        widgets = {
        'pricecode': forms.TextInput(attrs={'readonly': True}),
    }
        
class ProductUpdateForm(ModelForm):
    class Meta:
        model = Product
        fields = '__all__'
        widgets = {
        'productcode': forms.TextInput(attrs={'readonly': True}),
        'productname': forms.TextInput(attrs={'readonly': True}),
        'units': forms.TextInput(attrs={'readonly': True}),
    }
        
class ProductPriceForm(ModelForm):
    class Meta:
        model = Productprice
        fields = ('pricecode', 'sellingrate', 'loadingrate')
        
        
PoTransactionFormSet = inlineformset_factory(Purchaseorder, Purchaseordertransaction,
                                                exclude=('potransactionnum', 'isdelivered', 'deliveredquantity', 'datedelivered'),
                                                extra=1, 
                                                can_delete=False
                                                )


PoTransactionUpdateFormSet = inlineformset_factory(Purchaseorder, Purchaseordertransaction,
                                                exclude=('isdelivered', 'deliveredquantity', 'datedelivered'),
                                                extra=0, 
                                                can_delete=True
                                                )