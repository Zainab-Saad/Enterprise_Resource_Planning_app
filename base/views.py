from django.shortcuts import render, redirect
from . import templates
# from django.http import Json
from .forms import PurchaseOrderForm, CustomerForm, CityForm, SellerForm, ProductForm, SaleInvoiceForm, PriceForm, PriceRateForm, ProductUpdateForm, ProductPriceForm, PurchaseOrderUpdateForm_Unverified, PoTransactionFormSet, PoTransactionUpdateFormSet, PurchaseOrderUpdateForm_Verified
from .models import Purchaseorder, Seller, Product, Customer, Purchaseordertransaction, Saleinvoice, Saleinvoicetransaction, Price, Pricerate, Productprice
from django.forms.models import model_to_dict
from django.contrib.auth.models import User
from django.contrib.auth.decorators import login_required, permission_required
from django.contrib.auth import authenticate, login, logout
from django.forms import modelformset_factory, inlineformset_factory
from copy import copy
from django.contrib import messages

# Create your views here.
@login_required(login_url='login')
def home(request):
    context = {
        
    }
    return render(request, 'base/dashboard.html', context)

def login_user(request):
    if request.user.is_authenticated:
        return redirect('dashboard')
    if request.method == 'POST':
        username = request.POST.get('username').lower()
        password = request.POST.get('password')
        try:
            user = User.objects.get(username=username)
        except:
            messages.error(request, 'Username does not exist')
            return render(request, 'base/login.html', {})
        # verify password of user after username is validated
        user = authenticate(request, username=username, password=password)
        if user is not None:
            login(request, user)
            return redirect('dashboard')
        else:
            messages.error(request, 'Invalid Password')
    context = {
        
    }
    return render(request, 'base/login.html', context)

@login_required(login_url='login')
def logout_user(request):
    logout(request)
    return redirect('login')


# method to update the POST request dictionary
def UPOST(post, obj):
    post = copy(post)
    for k,v in model_to_dict(obj).items():
        if k not in post: post[k] = v
    
    return post

@login_required(login_url='login')
@permission_required('base.view_purchaseorder', raise_exception=True)
def purchase_orders(request):
    purchase_orders = purchase_order_generic_view()
    context = {
        'purchase_orders' : purchase_orders
    }
    return render(request, 'base/purchase_orders.html', context)

@login_required(login_url='login')
@permission_required('base.add_purchaseordertransaction', raise_exception=True)
def purchase_transactions_add(request, pk):
    purchase_order = Purchaseorder.objects.get(ponumber=pk)
    if request.method == 'POST':
        print(request.POST)
        transaction_form = PoTransactionFormSet(request.POST, instance=purchase_order)
        if transaction_form.is_valid():
            if request.POST.get('purchaseordertransaction_set-0-productcode') == '':
                if 'po_complete' in request.POST:
                    return redirect('purchase_orders')
                elif 'add_transaction' in request.POST:
                    return redirect('purchase_add_transactions', purchase_order)
            
            for tran in transaction_form:
                tran.save()
            sp_po_total_payable_amount(pk)
            if 'po_complete' in request.POST:
                return redirect('purchase_orders')
            elif 'add_transaction' in request.POST:
                return redirect('purchase_add_transactions', purchase_order)
        else:
            messages.error(request, 'Required fields not fileld or filled incorrectly')
        
    form_set = PoTransactionFormSet()
    context = {
        'form_set' : form_set,
        'trans_submit_button' : True,
    }
    return render(request, 'base/form.html', context)

@login_required(login_url='login')
@permission_required('base.add_purchaseorder', raise_exception=True)
def purchase_orders_add(request):
    if request.method == 'POST':
        form = PurchaseOrderForm(request.POST)
        if 'submit_incomplete_po' in request.POST:
            print(request.POST)
            print("form is valid or nt ", form.is_valid())
            if form.is_valid():
                purchase_order = form.save(commit=False)
                purchase_order.createdby = request.user
                purchase_order.save()
                return redirect('purchase_orders')
            else:
                messages.error(request, 'Required fields not filled or filled incorrectly')
        if 'add_transaction' in request.POST:
            if form.is_valid():
                purchase_order = form.save(commit=False)
                purchase_order.createdby = request.user
                purchase_order.save()
                return redirect('purchase_add_transactions', purchase_order)
            else:
                messages.error(request, 'Required fields not filled or filled incorrectly')
        
    form = PurchaseOrderForm()
    context = {
        'form' : form,
        'po_submit_button' : True
    }
    return render(request, 'base/form.html', context)

@login_required(login_url='login')
@permission_required('base.view_purchaseorder', raise_exception=True)
@permission_required('base.view_purchaseordertransaction', raise_exception=True)
def purchase_order_info(request, instance_ponumber):
    purchase_order = Purchaseorder.objects.get(ponumber=instance_ponumber)
    purchase_order_detail = sp_show_purchase_order_info(instance_ponumber)
    po_trans_detail = sp_show_po_transactions_info(instance_ponumber)
    context = {
        'po_trans_detail' : po_trans_detail,
        'purchase_order_detail' : purchase_order_detail,
        'purchase_order' : purchase_order
    }
    return render(request, 'base/purchase_order_info.html', context)

@login_required(login_url='login')
@permission_required('base.change_purchaseorder', raise_exception=True)
def update_purchase_order(request, pk):
    purchase_order = Purchaseorder.objects.get(ponumber=pk)
    if request.method == 'POST':
        if purchase_order.isverified:
            form = PurchaseOrderUpdateForm_Verified(request.POST, instance=purchase_order)
        else:
            form = PurchaseOrderUpdateForm_Unverified(request.POST, instance=purchase_order)
        print(form.is_valid())
        print(form.errors)
        if form.is_valid():
            form.save()
            return redirect(purchase_order_info, pk)
        else:
            messages.error(request, 'Purchase order not updated, incorrect data enetered')
    if purchase_order.isverified:
        form = PurchaseOrderUpdateForm_Verified(instance=purchase_order)
    else:
        form = PurchaseOrderUpdateForm_Unverified(instance=purchase_order)
    context = {
        'form' : form
    }
    return render(request, 'base/form.html', context)

@login_required(login_url='login')
@permission_required('base.change_purchaseordertransaction', raise_exception=True)
@permission_required('base.delete_purchaseordertransaction', raise_exception=True)
def update_transactions(request, pk):
    purchase_order = Purchaseorder.objects.get(ponumber=pk)
    trans_update_form = None
    if request.method == 'POST':
        print(request.POST)
        form_set = PoTransactionUpdateFormSet(request.POST, instance=purchase_order)
        trans_update_form = PoTransactionFormSet(request.POST, instance=purchase_order)
        if form_set.is_valid():
            form_set.save()
            sp_po_total_payable_amount(pk)
        else:
            trans_update_form = None
            messages.error(request, 'Required fields not filled or filled inaccurately')
        if 'add_transaction' in request.POST:
            print("yes i am here ")
            trans_update_form = PoTransactionFormSet()
        elif form_set.is_valid() and 'add_transaction' not in request.POST:
            return redirect('purchase_order_info', pk)
    form_set = PoTransactionUpdateFormSet(instance=purchase_order)
    context = {
        'form_set' : form_set,
        'trans_update_form' : trans_update_form,
        'trans_update_button' : True,
    }
    return render(request, 'base/form.html', context)

@login_required(login_url='login')
@permission_required('base.verify_purchaseorder', raise_exception=True)
def verify_purchase_order(request, pk):
    if request.method == 'POST':
        print(request.POST)
        if 'yes' in request.POST:
            purchase_order = Purchaseorder.objects.get(ponumber=pk)
            purchase_order.isverified = 1
            purchase_order.save()
        return redirect('purchase_order_info', pk)

    status = sp_is_verification_legible(pk)[0]
    print("status is ", status)
    # if legible 
    context = {
        'status' : status
    }
    return render(request, 'base/verify.html', context)

@login_required(login_url='login')
@permission_required('base.delete_purchaseorder', raise_exception=True)
def delete_purchase_order(request, pk):
    if request.method == 'POST':
        print(request.POST)
        if 'yes' in request.POST:
            purchase_order = Purchaseorder.objects.filter(ponumber=pk)
            purchase_order.delete()
            return redirect('purchase_orders') 
        if 'no' in request.POST:
            return redirect('purchase_order_info', pk)
    context = {
        
    }
    return render(request, 'base/delete.html', context)

@login_required(login_url='login')
def po_transaction_delivery(request):
    return 

@login_required(login_url='login')
@permission_required('base.view_seller', raise_exception=True)
def sellers(request):
    sellers = Seller.objects.all()
    context = {
        'sellers' : sellers
    }
    return render(request, 'base/sellers.html', context)

@login_required(login_url='login')
@permission_required('base.add_seller', raise_exception=True)
def sellers_add(request):
    if request.method == 'POST':
        form = SellerForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect('sellers')
        else:
            messages.error(request, 'Seller data not saved, Something went wrong')
        
    form = SellerForm()
    context = {
        'form' : form
    }
    return render(request, 'base/form.html', context)

@login_required(login_url='login')
@permission_required('base.change_seller', raise_exception=True)
def sellers_info(request, instance_sellercode):
    seller = Seller.objects.get(sellercode = instance_sellercode)
    form = SellerForm(instance=seller)
    if request.method == 'POST':
        if request.POST.get('isactive') == None:
            seller.isactive = False
        form = SellerForm(UPOST(request.POST, seller), instance=seller)
        if form.is_valid():
            form.save()
            return redirect('sellers')
        else:
            messages.error(request, 'Seller data not Updated, Something went wrong')
    context = {
        'form' : form
    }
    return render(request, 'base/is_active.html', context)

@login_required(login_url='login')
@permission_required('base.view_product', raise_exception=True)
def products(request):
    products = Product.objects.all()
    context = {
        'products' : products
    }
    return render(request, 'base/products.html', context)

@login_required(login_url='login')
@permission_required('base.view_product', raise_exception=True)
def products_info(request, instance_productcode):
    product = sp_show_product_info(instance_productcode)
    context = {
        'product' : product
    }
    return render(request, 'base/product_info.html', context)

@login_required(login_url='login')
@permission_required('base.add_product', raise_exception=True)
def products_add(request):
    ProductPriceFormSet = inlineformset_factory(Product, Productprice,
                            fields = ('pricecode', 'sellingrate', 'loadingrate'),
                            extra=0,              
                            can_delete=False, 
                            min_num=1, validate_min=True,               
                        )
    if request.method == 'POST':
        form = ProductForm(request.POST)
        print("form is ", form.is_valid())
        if form.is_valid():
            product = form.save(commit=False)
            form_set = ProductPriceFormSet(request.POST, instance=product)
            print("formm set is ", form_set.is_valid())
            if form_set.is_valid():
                product.save()
                form_set.save()
                return redirect('products')
            else:
                messages.error(request, 'Required fields not filled or filled incorrectly')
        else:
            messages.error(request, 'Required fields not filled or filled incorrectly')
            
    form = ProductForm()
    form_set = ProductPriceFormSet()
    context = {
        'form' : form,
        'form_set' : form_set
    }
    return render(request, 'base/form.html', context)

@login_required(login_url='login')
@permission_required('base.change_product', raise_exception=True)
def products_update(request, pk):
    product = Product.objects.get(productcode=pk)
    product_update_form = ProductUpdateForm(instance = product)
    product_price = Productprice.objects.filter(productcode=pk)
    initial_data = {
        'pricecode' : product_price[len(product_price)-1].pricecode,
        'sellingrate' : product_price[len(product_price)-1].sellingrate,
        'loadingrate' : product_price[len(product_price)-1].loadingrate
    }
    product_price_update_form = ProductPriceForm(initial=initial_data)
    if request.method == 'POST':
        if request.POST.get('isactive') == None:
            product.isactive = False
        product_update_form = ProductForm(UPOST(request.POST, product), instance=product)
        product_price_update_form = ProductPriceForm(request.POST, initial=initial_data)
        if product_update_form.is_valid():
            product_update_form.save()
            if product_price_update_form.has_changed():
                if product_price_update_form.is_valid():
                    unsaved_product_price = product_price_update_form.save(commit=False)
                    unsaved_product_price.productcode = Product.objects.get(productcode=pk)
                    unsaved_product_price.save()
                    return redirect('products')
                else:
                    messages.error(request, 'Required fields not filled or filled incorrectly')
            else:
                return redirect('products')
        else:
            messages.error(request, 'Required fields not filled or filled incorrectly')

            
    context = {
        'product_update_form' : product_update_form,
        'product_price_update_form' : product_price_update_form
    }
    return render(request, 'base/form.html', context)

@login_required(login_url='login')
@permission_required('base.view_customer', raise_exception=True)
def customers(request):
    customers = Customer.objects.all()
    context = {
        'customers' : customers
    }
    return render(request, 'base/customers.html', context)

@login_required(login_url='login')
@permission_required('base.add_customer', raise_exception=True)
def customers_add(request):
    if request.method == 'POST':
        form = CustomerForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect('customers')
        else:
            messages.error(request, 'Custoemr could not be added, maybe you entered incorrect data')
    form = CustomerForm()
    context = {
        'form' : form
    }
    return render(request, 'base/form.html', context)

@login_required(login_url='login')
@permission_required('base.change_customer', raise_exception=True)
def customers_info(request, instance_customercode):
    customer = Customer.objects.get(customercode = instance_customercode)
    form = CustomerForm(instance=customer)
    if request.method == 'POST':
        if request.POST.get('isactive') == None:
            customer.isactive = False
        form = CustomerForm(UPOST(request.POST, customer), instance=customer)
        if form.is_valid():
            form.save()
            return redirect('customers')
        else:
            messages.error(request, 'Customer info could not be updated, try again')
    context = {
        'form' : form
    }
    return render(request, 'base/is_active.html', context)

@login_required(login_url='login')
@permission_required('base.view_saleinvoice', raise_exception=True)
def sale_invoices(request):
    sale_invoices = Saleinvoice.objects.all()
    context = {
        'sale_invoices' : sale_invoices
    }
    return render(request, 'base/sale_invoice.html', context)

@login_required(login_url='login')
@permission_required('base.add_saleinvoicetransaction', raise_exception=True)
def sale_transactions_add(request, pk):
    TransFormSet = inlineformset_factory(Saleinvoice, Saleinvoicetransaction, 
                    fields = ('saletransactionnumber', 'productcode', 'pricecode', 'discountrate', 'quantity',
                              'freightcharges'
                              ),
                    extra = 4
    )
    sale_invoice = Saleinvoice.objects.get(invoicenumber = pk)
    form_set = TransFormSet(instance = sale_invoice)
    if request.method == 'POST':
        form_set = TransFormSet(request.POST, instance = sale_invoice)
        if form_set.is_valid():
            form_set.save()
            sale_invoice_trans = Saleinvoicetransaction.objects.filter(invoicenumber = sale_invoice.invoicenumber)
            sale_invoice.save()
            return redirect('sale_invoices')
        else:
            messages.error(request, 'Sale Invoice transactions not saved, try again')
    context = {
        'form_set' : form_set
    }
    
    return render(request, 'base/form.html', context)

@login_required(login_url='login')
@permission_required('base.add_saleinvoice', raise_exception=True)
def sale_invoice_add(request):
    if request.method == 'POST':
        form = SaleInvoiceForm(request.POST)
        if form.is_valid():
            sale_invoice = form.save(commit=False)
            form.save()
            return redirect('sale_add_transactions', pk = sale_invoice.invoicenumber)
        else:
            messages.error(request, 'Sale Invoice not made, Seems like you entered wrong data')
        
    form = SaleInvoiceForm()
    context = {
        'form' : form
    }
    return render(request, 'base/form.html', context)


@login_required(login_url='login')
@permission_required('base.view_price', raise_exception=True)
def prices(request):
    prices = price_generic_view()
    context = {
        'prices' : prices
    }
    return render(request, 'base/prices.html', context)

@login_required(login_url='login')
@permission_required('base.add_price', raise_exception=True)
def prices_add(request):
    PriceRateFormSet = inlineformset_factory(Price, Pricerate, 
                            fields=('saletaxrate', 'maxdiscountrate') , 
                            extra=0,              
                            can_delete=False, 
                            min_num=1, validate_min=True,               
                        )
    
    if request.method == 'POST':
        print(request.POST)
        form = PriceForm(request.POST)
        if form.is_valid():
            price = form.save(commit=False)
            form_set = PriceRateFormSet(request.POST, instance=price)
            if form_set.is_valid():
                price.save()
                form_set.save()
                return redirect('prices')
            else:
                messages.error(request, 'Required fields not filled or filled incorrectly')
        else:
            messages.error(request, 'Required fields not filled or filled incorrectly')
            
    form = PriceForm()
    form_set = PriceRateFormSet()
    context = {
        'form' : form,
        'form_set' : form_set
    }
    return render(request, 'base/form.html', context)

@login_required(login_url='login')
@permission_required('base.change_price', raise_exception=True)
def prices_update(request, pk):
    price_rate = Pricerate.objects.filter(pricecode=pk)
    form = PriceRateForm(instance=(price_rate[len(price_rate)-1]))
    if request.method == 'POST':
        print(request.POST)
        form = PriceRateForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect('prices')
        else:
            messages.error(request, 'Required Fields not filled, or filled incorrectly')
    context = {
        'form' : form
    }
    return render(request, 'base/form.html', context)




# methods to call mysql stored procedures
from django.db import connection

def dictfetchall(cursor):
    "Return all rows from a cursor as a dict"
    columns = [col[0] for col in cursor.description]
    return [
        dict(zip(columns, row))
        for row in cursor.fetchall()
    ]
    
def sp_po_total_payable_amount(ponumber):
    with connection.cursor() as cursor:
        print(cursor.callproc('get_total_payable_amount', [ponumber]))
    
def sp_po_transaction_number(ponumber):
    with connection.cursor() as cursor:
        cursor.callproc('get_transaction_number', [ponumber])
        result = cursor.fetchone()
    if result == None:
        return 1
    return result[0]
    
def sp_show_po_transactions(ponumber):
    with connection.cursor() as cursor:
        cursor.callproc('show_po_transactions', [ponumber])
        result = dictfetchall(cursor)
    return result

def sp_is_verification_legible(ponumber):
    with connection.cursor() as cursor:
        cursor.callproc('is_verification_legible', [ponumber])
        result = cursor.fetchone()
        cursor.close()
    return result

def purchase_order_generic_view():
    with connection.cursor() as cursor:
        cursor.execute("SELECT * FROM purchase_order_generic_view")
        result = cursor.fetchall()
    return result

def price_generic_view():
    with connection.cursor() as cursor:
        cursor.execute("SELECT * FROM price_generic_view")
        result = cursor.fetchall()
    return result

def sp_show_product_info(productcode):
    with connection.cursor() as cursor:
        cursor.callproc('show_product_info', [productcode])
        result = cursor.fetchall()
    return result

def sp_show_purchase_order_info(ponumber):
    with connection.cursor() as cursor:
        cursor.callproc('show_purchase_order_info', [ponumber])
        result = cursor.fetchone()
        cursor.close()
    return result

def sp_show_po_transactions_info(ponumber):
    with connection.cursor() as cursor:
        cursor.callproc('po_transactions_detail', [ponumber])
        result = cursor.fetchall()
        cursor.close()
    return result

def results_data(request, ):
    pass