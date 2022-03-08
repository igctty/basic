import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:basic/action/actions.dart';
import 'package:basic/state/app_state.dart';
import 'package:basic/reducer/app_state_reducer.dart';
import 'package:basic/repository/counter_repository.dart';
import 'package:basic/middleware/counter_middleware.dart';
import 'package:basic/loading_widget.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
          title: 'Flutter Demo Home Page'
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final CountRepository _repository = CountRepository();
  final String title;
  MyHomePage({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: const Text("Reduxの場合"),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TopPage(_repository),
                    fullscreenDialog: true,
                  ));
            },
          ),
          const Divider(),
        ],
      ),
    );
  }
}

@immutable
class TopPage extends StatelessWidget {
  final CountRepository _repository;

  final Store<AppState> store;

  TopPage(this._repository)
      : store = Store<AppState>(
        appStateReducer,
            initialState: const AppState(),
            middleware: counterMiddleware(_repository),
        );
  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: Stack(
        children: <Widget>[
          Scaffold(
            appBar: AppBar(
              title: const Text('Redux Demo'),
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
          const LoadingWidget(),
        ],
      ),
    );
  }
}


class _TopContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("called _TopContent#build()");
    return Center(
        child: StoreConnector<AppState, int>(
          converter: (store) => store.state.counter,
          builder: (context, counter) {
            return Text(
              '$counter',
              style: Theme.of(context).textTheme.headline4,
            );
          },
        ));
  }
}

class _MiddleContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("called _MiddleContent#build()");
    return const Text('I am a Widget that will not be rebuilt.');
  }
}

class _BottomContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("called _BottomContent#build()");
    return ElevatedButton(
      onPressed: () {
        var store = StoreProvider.of<AppState>(context);
        store.dispatch(CountUpAction(store.state.counter));
      },
      child: const Icon(Icons.add),
    );
  }
}