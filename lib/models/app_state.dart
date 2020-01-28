import 'package:myapp/models/bill.dart';
import 'package:myapp/models/product.dart';
import 'package:meta/meta.dart';
import 'package:myapp/models/transaction.dart';

@immutable
class AppState{
  final bool isLoading;
  final List<Product> products;
  final Product product;
  final List<TransactionData> transactions;
  final List<Bill> bills;
  final String query;
  final int idBill;
  final Bill insertedBill;

  AppState({this.isLoading = false, this.products = const [], this.product, this.transactions, this.bills, this.query, this.insertedBill, this.idBill});
  factory AppState.loading() => AppState(isLoading: true);
}