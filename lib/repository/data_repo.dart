import 'package:myapp/models/bill.dart';
import 'package:myapp/models/product.dart';
import 'package:myapp/models/transaction.dart';

abstract class DataRepository{

  Future<List<Product>> loadAllProducts();

  Future<List<Product>> searchProducts(String name);

  Future<Product> getProducts(String name);

  Future saveProduct(Product products);

  Future<int> saveBill(Bill bill);

  Future saveItemTransaction(List<TransactionData> data);

  Future<List<Bill>> getBills();

  Future<List<TransactionData>> getTransactionDetail(int idBill);
}