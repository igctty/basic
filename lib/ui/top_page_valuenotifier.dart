import 'package:flutter/material.dart';
import 'package:basic/repository/count_repository.dart';
import 'package:basic/scopedmodel/valuenotifier/counter_value.dart';
import 'package:basic/scopedmodel/valuenotifier/loading_value.dart';
import 'package:basic/ui/widget/loading_widget_valuenotifier.dart';

class TopPageValueNotifier extends StatelessWidget {
  const TopPageValueNotifier(this.repository, this.loadingValue,{Key? key}) : super(key: key);
  final CountRepository repository;
  final LoadingValue loadingValue;

  @override
  Widget build(BuildContext context) {
    return _HomePage(
      repository: repository,
      loadingValue: loadingValue,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('ValueNotifier Demo'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _TopContent(),
            _MiddleContent(),
            _BottomContent(),
          ],
        ),
      ),
    );
  }
}

class _HomePage extends StatefulWidget {
  const _HomePage({
    Key? key,
    required this.repository,
    required this.loadingValue,
    required this.child,
  }) : super(key: key);

  final CountRepository repository;
  final LoadingValue loadingValue;
  final Widget child;

  @override
  _HomePageState createState() => _HomePageState();

  static _HomePageState of(BuildContext context, {bool rebuild = true}) {
    if (rebuild) {
      return (context.dependOnInheritedWidgetOfExactType<_MyInheritedWidget>())!.data;
    }
    return (context.getElementForInheritedWidgetOfExactType<_MyInheritedWidget>()!.widget as _MyInheritedWidget).data;
  }
}

class _HomePageState extends State<_HomePage> {
  late CounterValue counter;

  @override
  void initState() {
    super.initState();
    counter = CounterValue(widget.repository, widget.loadingValue);
  }

  @override
  Widget build(BuildContext context) {
    return _MyInheritedWidget(
      data: this,
      child: Stack(
        children: <Widget>[
          widget.child,
          LoadingWidgetValuenotifier(widget.loadingValue),
        ],
      ),
    );
  }
}

class _MyInheritedWidget extends InheritedWidget {
  const _MyInheritedWidget({
    Key? key,
    required Widget child,
    required this.data,
  }) : super(key: key, child: child);

  final _HomePageState data;

  @override
  bool updateShouldNotify(_MyInheritedWidget oldWidget) {
    return true;
  }
}

class _TopContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("called VN: _TopContent#build()");
    final state = _HomePage.of(context, rebuild: false);

    return Center(
      child: ValueListenableBuilder<int>(
        valueListenable: state.counter.valueNotifier,
        builder: (_context, count, _child) {
          return Text(
            '$count',
            style: Theme.of(context).textTheme.displayMedium,
          );
        },
      ),
    );
  }
}

class _MiddleContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("called VN: _MiddleContent#build()");
    return const Text('I am a Widget that will not be rebuilt.');
  }
}

class _BottomContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("called VN: _BottomContent#build()");
    final state = _HomePage.of(context, rebuild: false);
    return ElevatedButton(
      onPressed: () {
        state.counter.incrementCounter();
      },
      child: const Icon(Icons.add),
    );
  }
}