import 'package:flutter/material.dart';

class Test1 extends StatefulWidget {
  const Test1({super.key});

  @override
  _Test1State createState() => _Test1State();
}

class _Test1State extends State<Test1> {
  final ScrollController _verticalScrollController = ScrollController();
  final double minWidth = 600.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Scroll View'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final bool isWide = constraints.maxWidth >= minWidth;

          Widget listView = ListView.builder(
            controller: _verticalScrollController,
            itemCount: 100, // 예시로 100개의 아이템
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('Item $index'),
              );
            },
          );

          if (isWide) {
            // 화면이 넓은 경우, 단순 ListView 표시
            return listView;
          } else {
            // 화면이 좁은 경우, 수직 Scrollbar와 함께 ListView 표시
            return Stack(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    width: minWidth,
                    child: listView,
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: Scrollbar(
                    controller: _verticalScrollController,
                    thumbVisibility: true,
                    child: Container(
                      width: 20, // Scrollbar의 너비를 시각적으로 표현하기 위한 컨테이너
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
