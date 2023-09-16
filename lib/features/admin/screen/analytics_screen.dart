import 'package:amazon_clone/common/widgets/loader.dart';
import 'package:amazon_clone/features/admin/model/sales.dart';
import 'package:amazon_clone/features/admin/service/admin_service.dart';
import 'package:flutter/material.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final AdminService adminService = AdminService();
  int? totalSales;
  List<Sales>? earning;
  @override
  void initState() {
    super.initState();
    getEarnings();
  }

  getEarnings() async {
    var earningData = await adminService.getEarnings(context: context);
    totalSales = earningData['totalEarning'];
    earning = earningData['sales'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return earning == null || totalSales == null
        ? Loader()
        : Column(
            children: [
              Text(
                '\$$totalSales',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          );
  }
}
