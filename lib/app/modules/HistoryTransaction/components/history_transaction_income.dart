import 'package:budget_tracker/app/styles/app_colors.dart';
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

class HistoryTransactionIncome extends StatelessWidget {
  final HistoryTransactionController controller = Get.find();

  HistoryTransactionIncome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.loadTransactions();
    return Column(
      children: [
        // Grafik dengan height yang tetap
        Obx(() {
          List<Transaction> incomes = controller.transactions
              .where((transaction) => transaction.type == 'income')
              .toList();

          if (incomes.isEmpty) {
            return const Center(
              child: Text("No Income Data Available"),
            );
          }

          // Map to get category data
          Map<String, Category> categoryMap = {
            for (var category in controller.categories) category.name: category
          };

          // Calculate totals and prepare chart data
          Map<String, double> categoryTotals = {};
          double totalIncomes = 0;

          for (var income in incomes) {
            totalIncomes += income.amount;
            categoryTotals.update(
              income.categoryName,
              (value) => value + income.amount,
              ifAbsent: () => income.amount,
            );
          }

          // Prepare chart data
          List<ChartData> chartData = categoryTotals.entries.map((entry) {
            double percentage = (entry.value / totalIncomes) * 100;
            Category category = categoryMap[entry.key]!;

            String categoryColorString = incomes
                .firstWhere((e) => e.categoryName == entry.key)
                .categoryColor;

            // Konversi warna dari String ke int (format ARGB)
            int categoryColorInt = int.parse(categoryColorString);

            // Konversi integer ARGB ke Color
            Color color = Color(categoryColorInt);

            return ChartData(
              category: entry.key,
              percentage: percentage,
              color: color,
              icon: iconsList[category.icon], // Map category.icon to IconData
            );
          }).toList();

          return SfCircularChart(
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
                  margin: EdgeInsets.only(bottom: 8.sp),
                  builder: (data, point, series, pointIndex, seriesIndex) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          data.icon,
                          color: AppColors.white,
                          size: 22.sp,
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          '${data.percentage.toStringAsFixed(1)}%',
                          style: AppFonts.semiBold.copyWith(
                            fontSize: 12.sp,
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          );
        }),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Incomes',
                style: TextStyle(fontSize: 22.sp),
              ),
            ],
          ),
        ),
        Expanded(
          child: Obx(() {
            // Filter transaksi bertipe 'income'
            List<Transaction> filteredTransactions = controller.transactions
                .where((transaction) => transaction.type == 'income')
                .toList();

            return ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: filteredTransactions.length,
              itemBuilder: (context, index) {
                final transaction = filteredTransactions[index];
                final category =
                    controller.getCategoryByName(transaction.categoryName);

                if (category == null) {
                  // Jika kategori tidak ditemukan, tampilkan error atau placeholder
                  return const ListTile(
                    title: Text('Category not found'),
                  );
                }

                return HistoryCard(
                  transaction: transaction,
                  category: category,
                );
              },
            );
          }),
        ),
      ],
    );
  }
}
