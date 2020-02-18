// class Product{
//    int productID;
//    String productName;
//    int qty;
//    int price;
//    int fee;
//    int status;

//   Product({this.productID, this.productName, this.qty, this.price, this.fee, this.status});

//   factory Product.fromMap(Map<String, dynamic> json) => new Product(
//         productID: json["productID"],
//         productName: json["productName"],
//         qty : json["qty"],
//         price: json["price"],
//         fee: json["fee"],
//         status: json["status"]
//       );

//   void setData(int productID, String productName, int qty, int price, int fee, int status){
//     this.productID = productID;
//     this.productName= productName;
//     this.qty = qty;    
//     this.price = price;    
//     this.fee = fee;
//     this.status = status;
//   }
// }


import 'dart:convert';
// BEGIN API
List<Product> employeeFromJson(String str) =>
    List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
   int productID;
   String productName;
   int qty;
   int price;
   int fee;
   int status;


  Product({
    this.productID,
    this.productName,
    this.qty,  
    this.price,   
    this.fee,
    this.status,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        productID: json["productID"],
        productName: json["productName"],
        qty : json["qty"],
        price: json["price"],
        fee: json["fee"],
        status: json["status"]
      );

  Map<String, dynamic> toJson() => {
        "productID" : productID,
        "productName" : productName,
        "qty" : qty,
        "price" : price,
        "fee" : fee,
        "status" : status,
    };

// END API
  factory Product.fromMap(Map<String, dynamic> json) => new Product(
        productID: json["productID"],
        productName: json["productName"],
        qty : json["qty"],
        price: json["price"],
        fee: json["fee"],
        status: json["status"]
      );

  void setData(int productID, String productName, int qty, int price, int fee, int status){
      this.productID = productID;
      this.productName= productName;
      this.qty = qty;    
      this.price = price;    
      this.fee = fee;
      this.status = status;
  }
}