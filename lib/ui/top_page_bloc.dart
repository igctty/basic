import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:basic/bloc/counter_bloc.dart';
import 'package:basic/bloc/loading_bloc.dart';
import 'package:basic/repository/count_repository.dart';

import 'widget/loading_widget_bloc.dart';

class TopPageBLoC extends StatelessWidget {
  const TopPageBLoC(this._repository, {Key? key}) : super(key: key);

  final CountRepository _repository;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<LoadingBloc>(
          create: (_) => LoadingBloc(),
          dispose: (_, bloc) => bloc.dispose(),
        ),
        Provider<CounterBloc>(
          create: (context) {
            var bloc = Provider.of<LoadingBloc>(context, listen: false);
            return CounterBloc(_repository, bloc);
          },
          dispose: (_, bloc) => bloc.dispose(),
        ),
      ],
      child: Stack(
        children: <Widget>[
          Scaffold(
            appBar: AppBar(
              title: const Text('BLoC Demo'),
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
          const LoadingWidgetBLoC(),
        ],
      ),
    );
  }
}

class _TopContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("called BC: _TopContent#build()");
    var bloc = Provider.of<CounterBloc>(context, listen: false);
    return Center(
      child: StreamBuilder<int>(
        initialData: 0,
        stream: bloc.value,
        builder: (context, snapshot) {
          return Text(
            '${snapshot.data}',
            style: Theme.of(context).textTheme.headline4,
          );
        },
      ),
    );
  }
}

class _MiddleContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("called BC: _MiddleContent#build()");
    return const Text('I am a Widget that will not be rebuilt.');
  }
}

class _BottomContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("called BC: _BottomContent#build()");
    return ElevatedButton(
      onPressed: () {
        Provider.of<CounterBloc>(context, listen: false).incrementCounter();
      },
      child: const Icon(Icons.add),
    );
  }
}