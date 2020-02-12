import 'package:myapp/models/bill.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:myapp/models/product.dart';
import 'package:myapp/models/transaction.dart';


class DbHelper{
  DbHelper._();

  static final DbHelper db = DbHelper._();

  Database _database;

  Future<Database> get database async{
    if(_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async{
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'tammu.db');
    return await openDatabase(path, version: 2, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      
      
      await db.execute("CREATE TABLE tblproduct("
          "productID INTEGER PRIMARY KEY NOT NULL,"
          "productName VARCHAR(50) NOT NULL,"
          "qty INTEGER NOT NULL,"
          "price INTEGER NOT NULL,"
          "fee INTEGER NOT NULL,"
          "status INTEGER NOT NULL"
          ");");

      await db.execute("CREATE TABLE tblitemtransaction("
          "transactionID VARCHAR(50) NOT NULL,"
          "productID INTEGER NOT NULL,"
          "qty INTEGER NOT NULL,"
          "itemPrice INTEGER NOT NULL,"
          "discount INTEGER NOT NULL,"
          "urutan INTEGER PRIMARY KEY NOT NULL"
          ");");


      await db.execute("CREATE TABLE tbltransaction("
          "transactionID INTEGER PRIMARY KEY NOT NULL,"          
          "totalPrice INTEGER NOT NULL,"
          "totalDiscount INTEGER,"
          "voucherCode VARCHAR(20),"
          "totalVoucher INTEGER,"
          "userID INTEGER NOT NULL,"
          "transactionDate INTEGER NOT NULL,"
          "status INTEGER NOT NULL"
          ");");



      await db.execute("CREATE TABLE tblvoucher("
          "voucherCode VARCHAR(50) PRIMARY KEY NOT NULL,"
          "nominal INTEGER NOT NULL,"
          "voucherDescription VARCHAR(50) NOT NULL,"
          "startDate INTEGER NOT NULL,"
          "endDate INTEGER NOT NULL"
          ");");


      await db.execute("CREATE TABLE user("
          "userID CHAR(10) PRIMARY KEY NOT NULL,"
          "userName VARCHAR(20) NOT NULL,"
          "fullName VARCHAR(50) NOT NULL,"
          "email VARCHAR(50) NOT NULL,"
          "password VARCHAR(255) NOT NULL,"
          "referralCode CHAR(50),"
          "saldo INTEGER NOT NULL,"
          "joinDate INTEGER NOT NULL,"
          "resignDate INTEGER NOT NULL,"
          "status INTEGER NOT NULL"
          ");");    

    });
  }

  insertProduct(Product product) async{
    final db = await database;
    var raw = await db.rawInsert(
      "INSERT into tblproduct (productName, qty, price, fee, status) VALUES (?, ?, ?,0,1)",
      [product.productName, product.qty, product.price, product.fee, product.status]
    );
    return raw;
  }

 insertTransaction(TransactionData transaction) async{
    
    final db = await database;
    var raw = await db.rawInsert(
      "INSERT into ItemTransaction (product_id, count, bill_id, item_price) VALUES (?, ?, ?, ?)",
      [transaction.productId, transaction.count, transaction.billId, transaction.itemPrice]
    );
    return raw;
  }

  insertBill(Bill bill) async{

    final db = await database;
    var raw = await db.rawInsert(
      "INSERT into Bill (date, total_price) VALUES (?, ?)",
      [bill.date, bill.totalPrice]
    );
    print("bill id "+raw.toString());
    return raw;

  }


  Future<List<Product>> getAllproduct() async {
    final db = await database;
    var res = await db.rawQuery("SELECT * FROM Product");
    print("load product "+res.isEmpty.toString());
    List<Product> list =res.isNotEmpty ? res.map((c) => Product.fromMap(c)).toList() : [];
    
    return list;
  }

  Future<List<Product>> searchProduct(String name) async{

    final db = await database;
    var res = await db.rawQuery("SELECT * FROM Product WHERE product_name like '%"+name+"%'");
    List<Product> list =res.isNotEmpty ? res.map((c) => Product.fromMap(c)).toList() : [];
    
    return list;
  }


Future<Product> getProduct(String name) async{

    final db = await database;
    var res = await db.rawQuery("SELECT * FROM Product WHERE product_name ='"+name+"'");
    List<Product> list =res.isNotEmpty ? res.map((c) => Product.fromMap(c)).toList() : [];
    
    return list[0];
  }

  Future<List<Bill>> getBills() async{

    final db = await database;
    var res = await db.rawQuery("SELECT id_bill, date, total_price, SUM(ItemTransaction.count) AS qty   FROM Bill JOIN ItemTransaction ON Bill.id_bill = ItemTransaction.Bill_id GROUP BY Bill.id_bill, Bill.date, Bill.total_price");

    // var res = await db.rawQuery("SELECT a.date, a.total_price, SUM(b.count) AS qty FROM Bill a INNER  JOIN ItemTransaction b ON a.bill_id = b.bill_id GROUP BY a.bill_id, a.date, a.total_price ");
    List<Bill> list =res.isNotEmpty ? res.map((c) => Bill.fromMap(c)).toList() : [];
    
    return list;
  }

  Future<List<TransactionData>> getDetailTransaction(int idBill) async {
    final db = await database;
    var res = await db.rawQuery("SELECT id, product_id, count, item_price, bill_id, product.product_name as name FROM ItemTransaction INNER JOIN Product ON ItemTransaction.product_id = Product.id WHERE bill_id = "+idBill.toString());
    List<TransactionData> list =res.isNotEmpty ? res.map((c) => TransactionData.fromMap(c)).toList() : [];
    
    return list;

  }

}