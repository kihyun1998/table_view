import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_view/talbe/provider/selected_provider.dart';

/// Table Columns Field
class TableColumn extends ConsumerWidget {
  const TableColumn({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedRows = ref.watch(selectedRowProvider);
    final bool isAllSelected = selectedRows.length == itemCounts;
    return const Padding(
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
    );
  }
}

/// Talbe Header Tile
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
