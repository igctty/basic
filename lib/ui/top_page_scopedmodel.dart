import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:basic/repository/count_repository.dart';
import 'package:basic/scopedmodel/counter_model.dart';
import 'package:basic/scopedmodel/loading_model.dart';

import 'widget/loading_widget_scopedmodel.dart';

class TopPageScopedModel extends StatelessWidget {
  const TopPageScopedModel(this._repository, this._loadingModel,{Key? key}) : super(key: key);
  final CountRepository _repository;
  final LoadingModel _loadingModel;

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: _loadingModel,
      child: Stack(
        children: <Widget>[
          Scaffold(
            appBar: AppBar(
              title: const Text('Scoped Model Demo'),
            ),
            body: ScopedModel(
              model: CounterModel(_repository, _loadingModel),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _TopContent(),
                  _MiddleContent(),
                  _BottomContent(),
                ],
              ),
            ),
          ),
          const LoadingWidgetScopedModel(),
        ],
      ),
    );
  }
}

class _TopContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("called SC: _TopContent#build()");
    return Center(
      child: ScopedModelDescendant<CounterModel>(
        builder: (context, child, model) {
          return Text(
            '${model.counter}',
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
    print("called SC: _MiddleContent#build()");
    return const Text('I am a Widget that will not be rebuilt.');
  }
}

class _BottomContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("called SC: _BottomContent#build()");
    return ElevatedButton(
      onPressed: () {
        ScopedModel.of<CounterModel>(context, rebuildOnChange: false).incrementCounter();
      },
      child: const Icon(Icons.add),
    );
  }
}