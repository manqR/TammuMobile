class Product{
   int productID;
   String productName;
   int qty;
   int price;
   int fee;
   int status;

  Product({this.productID, this.productName, this.qty, this.price, this.fee, this.status});

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