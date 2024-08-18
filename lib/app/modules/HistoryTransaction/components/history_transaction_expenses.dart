import 'package:budget_tracker/app/styles/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:get/get.dart';

import '../../../data/entities/icon_list.dart';
import '../../../data/models/category.dart';
import '../../../data/models/chart.dart';
import '../../../data/models/transaction.dart';
import 'package:budget_tracker/app/modules/HistoryTransaction/controllers/history_transaction_controller.dart';

import '../../home/components/history_card.dart';

class HistoryTransactionExpenses extends StatelessWidget {
  final HistoryTransactionController controller = Get.find();

  HistoryTransactionExpenses({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Load transactions based on the selected month
    controller.loadTransactions();

    return Obx(() {
      // Convert selectedMonth to DateTime
      DateTime selectedDate = controller.getSelectedMonthDate();

      // Filter transactions based on the selected month
      List<Transaction> expenses = controller.transactions
          .where((transaction) =>
              transaction.type == 'expense' &&
              transaction.date.month == selectedDate.month &&
              transaction.date.year == selectedDate.year)
          .toList();

      if (expenses.isEmpty) {
        // If no expenses, show the "No Expenses Data Available" message
        return Center(
          child: Text(
            "No Expenses Data Available",
            style: TextStyle(fontSize: 22.sp),
          ),
        );
      }

      // Map to get category data
      Map<String, Category> categoryMap = {
        for (var category in controller.categories) category.name: category
      };

      // Calculate totals and prepare chart data
      Map<String, double> categoryTotals = {};
      double totalExpenses = 0;

      for (var expense in expenses) {
        totalExpenses += expense.amount;
        categoryTotals.update(
          expense.categoryName,
          (value) => value + expense.amount,
          ifAbsent: () => expense.amount,
        );
      }

      // Prepare chart data
      List<ChartData> chartData = categoryTotals.entries.map((entry) {
        double percentage = (entry.value / totalExpenses) * 100;
        Category category = categoryMap[entry.key]!;

        String categoryColorString = expenses
            .firstWhere((e) => e.categoryName == entry.key)
            .categoryColor;

        // Convert color from String to int (ARGB format)
        int categoryColorInt = int.parse(categoryColorString);

        // Convert integer ARGB to Color
        Color color = Color(categoryColorInt);

        return ChartData(
          category: entry.key,
          percentage: percentage,
          color: color,
          icon: iconsList[category.icon], // Map category.icon to IconData
        );
      }).toList();

      return Column(
        children: [
          // Show chart only if there are expenses
          SfCircularChart(
            series: <CircularSeries>[
              DoughnutSeries<ChartData, String>(
                dataSource: chartData,
                xValueMapper: (ChartData data, _) => data.category,
                yValueMapper: (ChartData data, _) => data.percentage,
                pointColorMapper: (ChartData data, _) => data.color,
                innerRadius: '60%',
                dataLabelMapper: (ChartData data, _) =>
                    '${data.percentage.toStringAsFixed(1)}%',
                dataLabelSettings: DataLabelSettings(
                  isVisible: true,
                  labelPosition: ChartDataLabelPosition.inside,
                  labelIntersectAction: LabelIntersectAction.shift,
                  useSeriesColor: true,
                  angle: 0,
                  connectorLineSettings: ConnectorLineSettings(
                    width: 0,
                  ),
                  margin: EdgeInsets.only(bottom: 8.sp),
                  builder: (data, point, series, pointIndex, seriesIndex) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          data.icon,
                          color: Colors.white,
                          size: 22.sp,
                        ),
                        SizedBox(height: 4.h),
                        // Tambahkan jarak antara ikon dan teks
                        Text(
                          '${data.percentage.toStringAsFixed(1)}%',
                          style: AppFonts.semiBold.copyWith(
                            fontSize: 12.sp,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Expenses',
                  style: TextStyle(fontSize: 22.sp),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: expenses.length,
              itemBuilder: (context, index) {
                final transaction = expenses[index];
                final category =
                    controller.getCategoryByName(transaction.categoryName);

                if (category == null) {
                  // If category is not found, show error or placeholder
                  return const ListTile(
                    title: Text('Category not found'),
                  );
                }

                return HistoryCard(
                  transaction: transaction,
                  category: category,
                );
              },
            ),
          ),
        ],
      );
    });
  }
}
