import 'package:flutter/material.dart';

class SyncedScrollControllers extends StatefulWidget {
  const SyncedScrollControllers(
      {super.key,
      required this.builder,
      this.scrollController,
      this.sc12toSc11Position = false,
      this.horizontalScrollController,
      this.sc22toSc21Position = false});

  final ScrollController? scrollController;

  final ScrollController? horizontalScrollController;

  final bool sc12toSc11Position;

  final bool sc22toSc21Position;

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
  ScrollController? _sc11;
  late ScrollController _sc12;
  ScrollController? _sc21;
  late ScrollController _sc22;

  final List<void Function()> _listeners = [];

  @override
  void initState() {
    super.initState();
    _initControllers();
  }

  @override
  void didUpdateWidget(SyncedScrollControllers oldWidget) {
    super.didUpdateWidget(oldWidget);
    _disposeOrUnsubscribe();
    _initControllers();
  }

  @override
  void dispose() {
    _disposeOrUnsubscribe();
    super.dispose();
  }

  void _initControllers() {
    _doNotReissueJump.clear();
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
        offset = _sc21!.offset;
      }
    } else {
      _sc21 = ScrollController();
    }

    _sc12 = ScrollController(
        initialScrollOffset: widget.sc12toSc11Position ? offset : 0.0);
    _sc22 = ScrollController(
        initialScrollOffset:
            widget.sc22toSc21Position ? horizontalOffset : 0.0);

    _syncScrollControllers(_sc11!, _sc12);
    _syncScrollControllers(_sc21!, _sc22);
  }

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

  void _syncScrollControllers(ScrollController sc1, ScrollController sc2) {
    var l = () => _jumpToNoCascade(sc1, sc2);
    sc1.addListener(l);
    _listeners.add(l);
    l = () => _jumpToNoCascade(sc2, sc1);
    sc2.addListener(l);
  }

  void _jumpToNoCascade(ScrollController master, ScrollController slave) {
    if (!slave.hasClients || slave.position.outOfRange) {
      return;
    }
    if (_doNotReissueJump[master] == null ||
        _doNotReissueJump[master]! == false) {
      _doNotReissueJump[slave] = true;
      slave.jumpTo(master.offset);
    } else {
      _doNotReissueJump[master] = false;
    }
  }

  @override
  Widget build(BuildContext context) =>
      widget.builder(context, _sc11!, _sc12, _sc21!, _sc22);
}
