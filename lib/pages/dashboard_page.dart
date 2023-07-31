import 'package:bukulaundry/constant/colors.dart';
import 'package:bukulaundry/widgets/info_saldo.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DashboardPage extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<SalesData> chartData = [
      SalesData("Jan", 200000),
      SalesData("Feb", 289000),
      SalesData("Mar", 342000),
      SalesData("Apr", 321000),
      SalesData("Mei", 402000)
    ];

    return Scaffold(
      body: Stack(
        children: [
          // Backgorund
          Container(
            // ignore: prefer_const_constructors
            decoration: BoxDecoration(
                // ignore: prefer_const_constructors
                gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              // ignore: prefer_const_literals_to_create_immutables
              colors: [
                appBlueSoft.withOpacity(0.4),
                appRedSoft.withOpacity(0.6),
              ],
            )),
          ),
          SafeArea(
            child: Column(
              children: [
                // ignore: prefer_const_constructors
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text("Saldo Saat Ini"),
                const SizedBox(height: 10),
                const Text(
                  "IDR 900.000",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InfoBalance(isIncome: true, balance: 900000),
                    InfoBalance(isIncome: false, balance: 45000),
                  ],
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          "Pendapatan per-bulan ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      // ignore: avoid_unnecessary_containers
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        // ignore: avoid_unnecessary_containers, sized_box_for_whitespace
                        child: Container(
                          height: 250,
                          width: chartData.length * 100,
                          child: SfCartesianChart(
                            primaryXAxis: CategoryAxis(),
                            series: <ChartSeries>[
                              // Renders line chart
                              SplineSeries<SalesData, String>(
                                width: 4,
                                color: appPrimary,
                                dataSource: chartData,
                                xValueMapper: (SalesData sales, _) =>
                                    sales.month,
                                yValueMapper: (SalesData sales, _) =>
                                    sales.sales,
                              ),
                              SplineSeries<SalesData, String>(
                                width: 2,
                                color: appPrimary,
                                dataSource: chartData,
                                xValueMapper: (SalesData sales, _) =>
                                    sales.month,
                                yValueMapper: (SalesData sales, _) => 300000,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class SalesData {
  SalesData(this.month, this.sales);
  final String month;
  final double sales;
}
