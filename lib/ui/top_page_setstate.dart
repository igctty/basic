import 'package:flutter/material.dart';
import 'package:basic/repository/count_repository.dart';

import 'widget/loading_widget_setstate.dart';

class TopPageSetState extends StatefulWidget {
  const TopPageSetState(this.repository,{Key? key}) : super(key: key);
  final CountRepository repository;

  @override
  _TopPageState createState() => _TopPageState();
}

class _TopPageState extends State<TopPageSetState> {
  int _counter = 0;
  bool _isLoading = false;

  void _incrementCounter() {
    setState(() {
      _isLoading = true;
    });
    widget.repository.fetch().then((increaseCount) {
      setState(() {
        _counter += increaseCount;
      });
    }).whenComplete(() {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          appBar: AppBar(
            title: const Text('setState Demo'),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _TopContent(_counter),
              _MiddleContent(),
              _BottomContent(_incrementCounter),
            ],
          ),
        ),
        LoadingWidgetSetState(isLoading: _isLoading),
      ],
    );
  }
}

class _TopContent extends StatelessWidget {
  const _TopContent(this.counter);

  final int counter;

  @override
  Widget build(BuildContext context) {
    print("called SS: _TopContent#build()");
    return Center(
      child: Text(
        '$counter',
        key: const Key("Text of setState"),
        style: Theme.of(context).textTheme.displayMedium,
      ),
    );
  }
}

class _MiddleContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("called SS: _MiddleContent#build()");
    return const Text('I am a Widget that will not be rebuilt.');
  }
}

class _BottomContent extends StatelessWidget {
  const _BottomContent(this.incrementCounter);

  final void Function() incrementCounter;

  @override
  Widget build(BuildContext context) {
    print("called SS: _WidgetC#build()");
    return ElevatedButton(
      key: const Key("Button of setState"),
      onPressed: incrementCounter,
      child: const Icon(Icons.add),
    );
  }
}