import 'package:myapp/db/db_helper.dart';
import 'package:myapp/models/bill.dart';
import 'package:myapp/models/transaction.dart';
import 'package:myapp/repository/data_repo.dart';
import 'package:myapp/models/product.dart';
import 'dart:async';


class LocalRepository implements DataRepository{

  const LocalRepository();

  @override
  Future<List<Product>> loadAllProducts() async {
    
    final products = await DbHelper.db.getAllproduct();
    print("load product : "+products.length.toString());
    return products;
  }

  @override
  Future saveProduct(Product product) async {
    print("Name : "+product.productName+" price : "+product.price.toString()+"  qty : "+product.qty.toString());
    final prod = await DbHelper.db.insertProduct(product);
    return prod;
  }

  @override
  Future<List<Product>> searchProducts(String name) async{
     final prod = await DbHelper.db.searchProduct(name);
    return prod;
  }

  @override
  Future saveItemTransaction(List<TransactionData> data) async{
    var insert =  data.forEach((data) async =>
         await DbHelper.db.insertTransaction(data)
    );

    return insert;
  
  }

  @override
  Future<int> saveBill(Bill billData) async{
    final bill = await DbHelper.db.insertBill(billData);
    return bill;
  }

  @override
  Future<Product> getProducts(String name) async{
    final product = await DbHelper.db.getProduct(name);
    return product;
  }

  @override
  Future<List<Bill>> getBills() async{
    final bills = await DbHelper.db.getBills();
    print("get bills : "+bills.toString());
    return bills;
  }

  @override
  Future<List<TransactionData>> getTransactionDetail(int idBill) async{
    final transactions = await DbHelper.db.getDetailTransaction(idBill);
    return transactions;
  }



}