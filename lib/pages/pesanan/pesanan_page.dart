// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:flutter/material.dart';

class PesananPage extends StatefulWidget {
  const PesananPage({Key? key}) : super(key: key);

  @override
  State<PesananPage> createState() => _PesananPageState();
}

class _PesananPageState extends State<PesananPage> {
  final DataTableSource _data = MyData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            PaginatedDataTable(
              source: _data,
              columns: [
                DataColumn(label: Text('No')),
                DataColumn(label: Text('Name')),
                DataColumn(label: Text('Price')),
              ],
              header: Text(
                "Data Pesanan",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              columnSpacing: 100,
              horizontalMargin: 60,
            ),
          ],
        ),
      ),
    );
  }
}

class MyData extends DataTableSource {
  final List<Map<String, dynamic>> _data = List.generate(
    200,
    (index) => {
      "id": index,
      "name": "Item $index",
      "price": Random().nextInt(100000),
    },
  );
  @override
  DataRow? getRow(int index) {
    return DataRow(cells: [
      DataCell(Text(_data[index]['id'].toString())),
      DataCell(Text(_data[index]['name'])),
      DataCell(Text(_data[index]['price'].toString())),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _data.length;

  @override
  int get selectedRowCount => 0;
}
