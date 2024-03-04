import 'package:flutter/material.dart';

class Horizontal extends StatefulWidget {
  const Horizontal({super.key});

  @override
  State<Horizontal> createState() => _HorizontalState();
}

class _HorizontalState extends State<Horizontal> {
  final double minWidth = 600.0;
  bool _isHover = false;
  final ScrollController horiScrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Horizontal")),
      body: MouseRegion(
        onEnter: (_) => setState(() => _isHover = true),
        onExit: (_) => setState(() => _isHover = false),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            // 화면 너비 체크
            if (constraints.maxWidth >= minWidth) {
              // minWidth 이상일 경우 Expanded 위젯을 사용
              return Row(
                children: [
                  Expanded(
                    child: Container(
                      color: Colors.blue,
                      height: double.infinity, // 높이 설정
                      alignment: Alignment.center,
                      child: const Text('Expanded'),
                    ),
                  ),
                ],
              );
            } else {
              // minWidth 미만일 경우 minWidth 크기의 Container를 스크롤 가능하게 유지
              return Scrollbar(
                controller: horiScrollController,
                thumbVisibility: _isHover,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  controller: horiScrollController,
                  child: Container(
                    width: minWidth, // 최소 너비 적용
                    height: double.infinity, // 높이 설정
                    color: Colors.yellow, // 색상을 노란색으로 변경
                    alignment: Alignment.center,
                    child: const Text('Min Width'),
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
