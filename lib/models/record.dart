class Record {
  final String uid;
  final String item;
  final String name;
  final int quantity;
  final String store;
  final String status;
  final DateTime purchaseDate;
  final DateTime expiryDate;

  const Record({
    this.uid,
    this.item,
    this.name,
    this.quantity,
    this.store,
    this.status,
    this.purchaseDate,
    this.expiryDate,
  });

  factory Record.fromJson(Map<String, dynamic> json) => Record(
        uid: json['uid'],
        item: json['item'],
        name: json['name'],
        quantity: json['quantity'],
        store: json['store'],
        status: json['status'],
        purchaseDate: json['purchaseDate'],
        expiryDate: json['expiryDate'],
      );

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'item': item,
        'name': name,
        'quantity': quantity,
        'store': store,
        'status': status,
        'purchaseDate': purchaseDate,
        'expiryDate': expiryDate,
      };
}