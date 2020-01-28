class Bill{
  final int id;
  final int date;
  final int qty;
  final int totalPrice;
  Bill({this.id, this.date, this.qty, this.totalPrice});

  factory Bill.fromMap(Map<String, dynamic> json) => new Bill(    
        id: json["id_bill"],
        date: json["date"],
        qty: json["qty"],
        totalPrice: json["total_price"],
      );

}