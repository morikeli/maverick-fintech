class TransactionModel {
  final String id;
  final String type; // "send" or "receive"
  final double amount;
  final String currency;
  final String counterparty;
  final DateTime date;
  final String? senderID;

  TransactionModel({
    required this.id,
    required this.type,
    required this.amount,
    required this.currency,
    required this.counterparty,
    required this.date,
    this.senderID = '',
  });

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'],
      senderID: map['senderID'],
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
    'type': type,
    'amount': amount,
    'currency': currency,
    'counterparty': counterparty,
    'date': date.toIso8601String(),
  };
}
