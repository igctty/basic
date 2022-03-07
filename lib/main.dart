import 'package:flutter/material.dart';
// import 'package:basic/counterRepository.dart';

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
          title: 'Flutter Demo Home Page',
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
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
          //TODO: アーキ用の画面追加
          ListTile(
            title: const Text("setStateの場合"),
            onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TopPage(),
                    fullscreenDialog: true,
                  ));
            },
          ),
        ]
      ),
    );
  }
}

class TopPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _HomePage(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Inherited Widget Demo'),
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
  _HomePage({
    Key? key,
    required this.child,
  }) : super(key: key);
  final Widget child;

  @override
  _HomePageState createState() => _HomePageState();

  static _HomePageState of(BuildContext context,{bool rebuild = true}) {
    if (rebuild) {
      return (context.dependOnInheritedWidgetOfExactType<_MyInheritedWidget>())!.data;
    }
    return (context.getElementForInheritedWidgetOfExactType<_MyInheritedWidget>()?.widget as _MyInheritedWidget).data;
  }
}

class _HomePageState extends State<_HomePage>{
  int counter = 0;

  void _incrementCounter() async {
    setState((){
      counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _MyInheritedWidget(
      data: this,
      child: widget.child,
    );
  }
}

class _MyInheritedWidget extends InheritedWidget {
  _MyInheritedWidget({
    Key? key,
    required Widget child,
    required this.data,
  }) : super(key: key, child: child);
  final _HomePageState data;

  @override
  bool updateShouldNotify(_MyInheritedWidget oldWidget){
    return true;
  }
}

class _TopContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("called _TopContent #build()");
    final _HomePageState state = _HomePage.of(context);

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
    print("called _MiddleContent #build()");
    return const Text('I am a Widget that will not be rebuilt.');
  }
}

class _BottomContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("called _BottomContent #build()");
    final _HomePageState state = _HomePage.of(context,rebuild:false);
    return ElevatedButton(
        onPressed: (){
          state._incrementCounter();
        },
        child: Icon(Icons.add),
    );
  }
}



