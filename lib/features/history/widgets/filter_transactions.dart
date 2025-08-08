import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../controllers/history_controller.dart';
import '../../../core/theme/colors.dart';

class FilterTransactionsWidget extends StatelessWidget {
  const FilterTransactionsWidget({
    super.key,
    required this.controller,
    required this.dateFormatter,
  });

  final HistoryController controller;
  final DateFormat dateFormatter;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Filters", style: TextStyle(fontSize: 18)),
          Row(
            children: [
              transactionTypeDropdownButton(
                context,
              ), // transaction type: "sent", "received", default: "All"
              Spacer(),

              //pick start date to filter transactions
              pickStartDate(context),
              // pick end date to filter transactions
              pickEndDate(context),
            ],
          ),
        ],
      ),
    );
  }

  TextButton pickEndDate(BuildContext context) {
    return TextButton(
      onPressed: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2020),
          lastDate: DateTime.now(),
        );
        if (picked != null) {
          controller.endDate.value = picked;
          controller.applyFilters();
        }
      },
      child: Row(
        children: [
          Text(
            "To: ${controller.endDate.value != null ? dateFormatter.format(controller.endDate.value!) : '---'}",
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontSize: 12.0,
            ),
          ),
          Icon(Icons.arrow_drop_down, size: 32.0),
        ],
      ),
    );
  }

  TextButton pickStartDate(BuildContext context) {
    return TextButton(
      onPressed: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now().subtract(Duration(days: 7)),
          firstDate: DateTime(2020),
          lastDate: DateTime.now(),
        );
        if (picked != null) {
          controller.startDate.value = picked;
          controller.applyFilters();
        }
      },
      child: Row(
        children: [
          Text(
            "From: ${controller.startDate.value != null ? dateFormatter.format(controller.startDate.value!) : '---'}",
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontSize: 12.0,
            ),
          ),
          Icon(Icons.arrow_drop_down, size: 32.0),
        ],
      ),
    );
  }

  DropdownButton<String> transactionTypeDropdownButton(BuildContext context) {
    return DropdownButton<String>(
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
        color: kTextSecondaryColor,
        fontSize: 20.0,
      ),
      value: controller.filterType.value,
      items: ['all', 'send', 'receive']
          .map(
            (type) =>
                DropdownMenuItem(value: type, child: Text(type.capitalize!)),
          )
          .toList(),
      onChanged: (val) {
        controller.filterType.value = val!;
        controller.applyFilters();
      },
    );
  }
}
