import 'package:flutter/material.dart';
import 'package:table_view/example/simple_table/simple_table.dart';
import 'package:table_view/talbe/model.dart';

class Example extends StatefulWidget {
  const Example({super.key});

  @override
  _ExampleState createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  final double minWidth = 600.0;
  bool _isHover = false;
  final ScrollController _horizontalScrollController = ScrollController();
  final ScrollController _verticalScrollController = ScrollController();
  final List<MyDataRow> rows = List.generate(
    5000,
    (index) => MyDataRow(
      id: 'ID$index',
      name: 'Product $index',
      quantity: 100 + index,
      price: 9.99 + index,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Vertical")),
      body: MouseRegion(
        onEnter: (_) => setState(() => _isHover = true),
        onExit: (_) => setState(() => _isHover = false),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            // 화면 너비 체크
            if (constraints.maxWidth >= minWidth) {
              // minWidth 이상일 경우 Expanded 위젯을 사용
              return SizedBox(
                width: constraints.maxWidth,
                child: Column(
                  children: [
                    Container(
                      color: Colors.blue,
                      child: const TableHeader(),
                    ),
                    Expanded(
                      child: Container(
                        height: double.infinity, // 높이 설정
                        alignment: Alignment.center,
                        child: Scrollbar(
                          controller: _verticalScrollController,
                          thumbVisibility: _isHover,
                          child: ListView.builder(
                            controller: _verticalScrollController,
                            itemCount: rows.length,
                            itemBuilder: (context, index) {
                              return TableDataField(row: rows[index]);
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              // minWidth 미만일 경우 minWidth 크기의 Container를 스크롤 가능하게 유지
              return Scrollbar(
                controller: _verticalScrollController,
                thumbVisibility: _isHover,
                child: Scrollbar(
                  controller: _horizontalScrollController,
                  thumbVisibility: _isHover,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    controller: _horizontalScrollController,
                    child: SizedBox(
                      width: minWidth,
                      child: Column(
                        children: [
                          Container(
                            color: Colors.blue,
                            child: const TableHeader(),
                          ),
                          Expanded(
                            child: Container(
                              height: double.infinity, // 높이 설정
                              alignment: Alignment.center,
                              child: ListView.builder(
                                controller: _verticalScrollController,
                                itemCount: rows.length,
                                itemBuilder: (context, index) {
                                  return TableDataField(row: rows[index]);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
