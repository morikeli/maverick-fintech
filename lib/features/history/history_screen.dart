import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:maverick_app/widgets/appbar.dart';
import '../../controllers/history_controller.dart';
import 'widgets/history_screen_body.dart';

class HistoryScreen extends StatelessWidget {
  HistoryScreen({super.key});
  final controller = Get.put(HistoryController());
  final dateFormatter = DateFormat('yyyy-MM-dd');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: sharedAppBar(context, 'Transaction history', false),
      body: HistoryScreenBodyWidget(controller: controller, dateFormatter: dateFormatter),
    );
  }
}
