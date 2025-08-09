class TransactionModel {
  final String id;
  final String type; // "send" or "receive"
  final double amount;
  final String currency;
  final String counterparty;
  final DateTime date;
  String? senderID;
  String? receiverID;

  TransactionModel({
    required this.id,
    required this.type,
    required this.amount,
    required this.currency,
    required this.counterparty,
    required this.date,
    this.senderID = '',
    this.receiverID = '',
  });

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'],
      senderID: map['senderID'],
      receiverID: map['receiverID'],
      type: map['type'],
      amount: map['amount'],
      currency: map['currency'],
      counterparty: map['counterparty'],
      date: DateTime.parse(map['date']),
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'senderID': senderID,
    'receiverID': receiverID,
    'type': type,
    'amount': amount,
    'currency': currency,
    'counterparty': counterparty,
    'date': date.toIso8601String(),
  };
}
