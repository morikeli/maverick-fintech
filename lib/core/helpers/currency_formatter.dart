import 'package:intl/intl.dart';

class CurrencyHelper {
  // Formats a number with commas, e.g. 1,000 or 10,000,000
  static String formatWithCommas(double amount) {
    final formatter = NumberFormat('#,##0', 'en_US');
    return formatter.format(amount);
  }

  // Abbreviates large numbers: 1K, 100K, 1M, etc.
  static String formatAbbreviated(double amount) {
    if (amount >= 1000000) {
      return '${(amount / 1000000).toStringAsFixed((amount % 1000000 == 0) ? 0 : 1)}M';
    } else if (amount >= 1000) {
      return '${(amount / 1000).toStringAsFixed((amount % 1000 == 0) ? 0 : 1)}K';
    } else {
      return amount.toStringAsFixed(0);
    }
  }

  // Combines prefix with formatted amount
  static String formatTransactionAmount({
    required double amount,
    String? currency,
    required bool isSent,
    bool abbreviated = false,
  }) {
    final formattedAmount = abbreviated
        ? formatAbbreviated(amount)
        : formatWithCommas(amount);

    // Prefix with '-' for sent transactions, '+' for received
    final prefix = isSent ? '+' : '-';
    return '$prefix$currency $formattedAmount';
  }
}
