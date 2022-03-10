import 'package:flutter/material.dart';
import 'package:basic/repository/count_repository.dart';

import 'widget/loading_widget_setstate.dart';

class TopPageInhWidget extends StatelessWidget {
  const TopPageInhWidget(this._repository,{Key? key}) : super(key: key);
  final CountRepository _repository;

  @override
  Widget build(BuildContext context) {
    return _HomePage(
      repository: _repository,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('InheritedWidget Demo'),
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
    required this.child,
  }) : super(key: key);
  
  final CountRepository repository;
  final Widget child;

  @override
  _HomePageState createState() => _HomePageState();

  static _HomePageState of(BuildContext context, {bool rebuild = true}) {
    if (rebuild) {
      return (context.dependOnInheritedWidgetOfExactType<_MyInheritedWidget>())!.data;
    }
    return (context.getElementForInheritedWidgetOfExactType<_MyInheritedWidget>()?.widget as _MyInheritedWidget).data;
  }
}

class _HomePageState extends State<_HomePage> {
  int counter = 0;
  bool isLoading = false;

  void _incrementCounter() {
    setState(() {
      isLoading = true;
    });
    widget.repository.fetch().then((increaseCount) {
      setState(() {
        counter += increaseCount;
      });
    }).whenComplete(() {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _MyInheritedWidget(
      data: this,
      child: Stack(
        children: <Widget>[
          widget.child,
          LoadingWidgetSetState(isLoading: isLoading),
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
    print("called IN: _TopContent#build()");
    final state = _HomePage.of(context);

    return Center(
      child: Text(
        '${state.counter}',
        style: Theme.of(context).textTheme.displayMedium,
      ),
    );
  }
}

class _MiddleContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("called IN: _MiddleContent#build()");
    return const Text('I am a Widget that will not be rebuilt.');
  }
}

class _BottomContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("called IN: _BottomContent#build()");
    final state = _HomePage.of(context, rebuild: false);
    return ElevatedButton(
      onPressed: state._incrementCounter,
      child: const Icon(Icons.add),
    );
  }
}