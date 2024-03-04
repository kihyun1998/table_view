import 'package:flutter/material.dart';

// SyncedScrollControllers 위젯은 스크롤 컨트롤러를 동기화하는 커스텀 위젯입니다.
class SyncedScrollControllers extends StatefulWidget {
  // 생성자에서는 빌더 함수, 기본 및 가로 스크롤 컨트롤러, 그리고 스크롤 동기화 여부를 인자로 받습니다.
  const SyncedScrollControllers({
    super.key,
    required this.builder,
    this.scrollController,
    this.sc12toSc11Position = false,
    this.horizontalScrollController,
    this.sc22toSc21Position = false,
  });

  // 스크롤 컨트롤러들과 스크롤 동기화 여부를 저장하는 필드들입니다.
  final ScrollController? scrollController;
  final ScrollController? horizontalScrollController;
  final bool sc12toSc11Position;
  final bool sc22toSc21Position;
  // 위젯 빌드에 사용될 함수형 필드입니다.
  final Widget Function(
      BuildContext context,
      ScrollController sc11,
      ScrollController sc12,
      ScrollController sc21,
      ScrollController sc22) builder;

  @override
  SyncedScrollControllersState createState() => SyncedScrollControllersState();
}

class SyncedScrollControllersState extends State<SyncedScrollControllers> {
  // 스크롤 컨트롤러들과 리스너 목록을 선언합니다.
  ScrollController? _sc11;
  late ScrollController _sc12;
  ScrollController? _sc21;
  late ScrollController _sc22;
  final List<void Function()> _listeners = [];

  @override
  void initState() {
    super.initState();
    // 위젯 초기화 시 컨트롤러 초기화 함수를 호출합니다.
    _initControllers();
  }

  @override
  void didUpdateWidget(SyncedScrollControllers oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 위젯 업데이트 시 기존 컨트롤러를 정리하고 다시 초기화합니다.
    _disposeOrUnsubscribe();
    _initControllers();
  }

  @override
  void dispose() {
    // 위젯이 소멸될 때 리소스를 정리합니다.
    _disposeOrUnsubscribe();
    super.dispose();
  }

  // 컨트롤러 초기화 및 동기화 설정을 담당하는 함수입니다.
  void _initControllers() {
    _doNotReissueJump.clear();
    // 기본 스크롤 컨트롤러(_sc11)와 가로 스크롤 컨트롤러(_sc21)의 초기 오프셋을 설정합니다.
    var offset =
        _sc11 == null || _sc11!.positions.isEmpty ? 0.0 : _sc11!.offset;
    if (widget.scrollController != null) {
      _sc11 = widget.scrollController!;
      if (_sc11!.positions.isNotEmpty) {
        offset = _sc11!.offset;
      }
    } else {
      _sc11 = ScrollController();
    }

    var horizontalOffset =
        _sc21 == null || _sc21!.positions.isEmpty ? 0.0 : _sc21!.offset;
    if (widget.horizontalScrollController != null) {
      _sc21 = widget.horizontalScrollController!;
      if (_sc21!.positions.isNotEmpty) {
        horizontalOffset = _sc21!.offset;
      }
    } else {
      _sc21 = ScrollController();
    }

    // _sc12와 _sc22 컨트롤러를 동기화할 오프셋으로 초기화합니다.
    _sc12 = ScrollController(
        initialScrollOffset: widget.sc12toSc11Position ? offset : 0.0);
    _sc22 = ScrollController(
        initialScrollOffset:
            widget.sc22toSc21Position ? horizontalOffset : 0.0);

    // 각 스크롤 컨트롤러들을 동기화합니다.
    _syncScrollControllers(_sc11!, _sc12);
    _syncScrollControllers(_sc21!, _sc22);
  }

  // 컨트롤러 및 리스너 리소스 정리를 담당하는 함수입니다.
  void _disposeOrUnsubscribe() {
    if (widget.scrollController == _sc11) {
      _sc11?.removeListener(_listeners[0]);
    } else {
      _sc11?.dispose();
    }
    _sc12.dispose();

    if (widget.horizontalScrollController == _sc21) {
      _sc21?.removeListener(_listeners[0]);
    } else {
      _sc21?.dispose();
    }
    _sc22.dispose();

    _listeners.clear();
  }

  final Map<ScrollController, bool> _doNotReissueJump = {};

  // 두 스크롤 컨트롤러의 동기화를 설정하는 함수입니다.
  void _syncScrollControllers(ScrollController sc1, ScrollController sc2) {
    var l = () => _jumpToNoCascade(sc1, sc2);
    sc1.addListener(l);
    _listeners.add(l);
    l = () => _jumpToNoCascade(sc2, sc1);
    sc2.addListener(l);
  }

  // 스크롤 이벤트를 다른 컨트롤러에 전파하지 않도록 하는 함수입니다.
  void _jumpToNoCascade(ScrollController master, ScrollController slave) {
    if (!slave.hasClients || slave.position.outOfRange) {
      return;
    }
    if (_doNotReissueJump[master] == null || !_doNotReissueJump[master]!) {
      _doNotReissueJump[slave] = true;
      slave.jumpTo(master.offset);
    } else {
      _doNotReissueJump[master] = false;
    }
  }

  // builder 함수를 사용하여 위젯을 구성합니다.
  @override
  Widget build(BuildContext context) =>
      widget.builder(context, _sc11!, _sc12, _sc21!, _sc22);
}
