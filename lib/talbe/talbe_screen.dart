import 'package:flutter/material.dart';
import 'package:table_view/talbe/model.dart';

class TalbeScreen extends StatelessWidget {
  const TalbeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> columns = [
      'ID',
      'Name',
      'Quantity',
      'Price',
    ];

    final List<MyDataRow> rows = List.generate(
      5000,
      (index) => MyDataRow(
        id: 'ID$index',
        name: 'Product $index',
        quantity: 100 + index,
        price: 9.99 + index,
      ),
    );

    return Scaffold(
      appBar: AppBar(title: const Text("Table")),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Row(
              children: [
                TableHeader(
                  title: "ID",
                ),
                TableHeader(
                  title: "Name",
                  flex: 3,
                ),
                TableHeader(
                  title: "Quantity",
                ),
                TableHeader(
                  title: "Price",
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: rows.length,
              itemBuilder: (context, index) {
                final row = rows[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 4.0),
                  child: Row(
                    children: [
                      Expanded(flex: 2, child: Text(row.id)),
                      Expanded(flex: 3, child: Text(row.name)),
                      Expanded(flex: 2, child: Text('${row.quantity}')),
                      Expanded(
                          flex: 2,
                          child: Text('\$${row.price.toStringAsFixed(2)}')),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// 테이블 헤더 코드
class TableHeader extends StatelessWidget {
  const TableHeader({
    Key? key,
    this.flex = 2,
    required this.title,
  }) : super(key: key);

  final String title;
  final int flex;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Container(
        padding: const EdgeInsets.all(8), // 패딩 추가
        decoration: BoxDecoration(
          color: Colors.blueGrey[100], // 배경색 추가
          border: const Border(
            right: BorderSide(color: Colors.grey, width: 0.5), // 우측 경계선 추가
            bottom: BorderSide(color: Colors.grey, width: 0.5), // 하단 경계선 추가
          ),
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87, // 텍스트 색상 변경
          ),
          textAlign: TextAlign.center, // 텍스트 중앙 정렬
        ),
      ),
    );
  }
}
