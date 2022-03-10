import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:basic/repository/count_repository.dart';
import 'package:basic/scopedmodel/valuenotifier/counter_value.dart';
import 'package:basic/scopedmodel/valuenotifier/loading_value.dart';
import 'package:basic/ui/widget/loading_widget_valuenotifier.dart';

class TopPageProvider extends StatelessWidget {
  const TopPageProvider(this._repository,{Key? key}) : super(key: key);

  final CountRepository _repository;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoadingValueScoped>(
          create: (_) => LoadingValueScoped(),
        ),
        ChangeNotifierProvider<CounterValueScoped>(
          create: (context) {
            var loading = Provider.of<LoadingValueScoped>(context, listen: false);
            return CounterValueScoped(_repository, loading);
          },
        ),
      ],
      child: Stack(
        children: <Widget>[
          Scaffold(
            appBar: AppBar(
              title: const Text('ValueNotifier + Provider Demo'),
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
          const LoadingWidgetScProvider(),
        ],
      ),
    );
  }
}

class _TopContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("called SP: _TopContent#build()");
    var logic = Provider.of<CounterValueScoped>(context, listen: false);
    return Center(
      child: ValueListenableBuilder<int>(
        valueListenable: logic,
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
    print("called SP: _MiddleContent#build()");
    return const Text('I am a Widget that will not be rebuilt.');
  }
}

class _BottomContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("called SP: _BottomContent#build()");
    return ElevatedButton(
      onPressed: () {
        Provider.of<CounterValueScoped>(context, listen: false).incrementCounter();
      },
      child: const Icon(Icons.add),
    );
  }
}