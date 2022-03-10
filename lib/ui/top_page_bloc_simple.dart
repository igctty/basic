import 'package:flutter/material.dart';
import 'package:basic/bloc/counter_bloc.dart';
import 'package:basic/bloc/loading_bloc.dart';
import 'package:basic/repository/count_repository.dart';

import 'widget/loading_widget_streambuilder.dart';

class TopPageBLoCConst extends StatefulWidget {
  const TopPageBLoCConst(this.repository,{Key? key}) : super (key: key);
  final CountRepository repository;

  @override
  _TopPageState createState() => _TopPageState();
}

class _TopPageState extends State<TopPageBLoCConst> {
  late LoadingBloc loadingBloc;
  late CounterBloc counterBloc;

  @override
  void initState() {
    super.initState();
    loadingBloc = LoadingBloc();
    counterBloc = CounterBloc(widget.repository, loadingBloc);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          appBar: AppBar(
            title: const Text('BLoc Simple Demo'),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _TopContent(counterBloc),
              _MiddleContent(),
              _BottomContent(counterBloc),
            ],
          ),
        ),
        LoadingWidgetStreamBuilder(loadingBloc.value),
      ],
    );
  }
}

class _TopContent extends StatelessWidget {
  const _TopContent(this.counterBloc);
  final CounterBloc counterBloc;

  @override
  Widget build(BuildContext context) {
    print("called BL: _TopContent#build()");
    return Center(
        child: StreamBuilder(
          stream: counterBloc.value,
          builder: (context, snapshot) {
            return Text(
              '${snapshot.data}',
              style: Theme.of(context).textTheme.displayMedium,
            );
          },
        ));
  }
}

class _MiddleContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("called BL: _MiddleContent#build()");
    return const Text('I am a Widget that will not be rebuilt.');
  }
}

class _BottomContent extends StatelessWidget {
  const _BottomContent(this.counterBloc);
  final CounterBloc counterBloc;

  @override
  Widget build(BuildContext context) {
    print("called BL: _BottomContent#build()");
    return ElevatedButton(
      onPressed: counterBloc.incrementCounter,
      child: const Icon(Icons.add),
    );
  }
}