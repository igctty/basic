import 'package:flutter/material.dart';
import 'package:basic/scopedmodel/valuenotifier/loading_value.dart';
import 'package:basic/ui/top_page_bloc.dart';
import 'package:basic/ui/top_page_inheritedwidget.dart';
import 'package:basic/ui/top_page_redux.dart';
import 'package:basic/ui/top_page_scopedmodel.dart';
import 'package:basic/ui/top_page_scopedmodel_provider.dart';
import 'package:basic/ui/top_page_setstate.dart';
import 'package:basic/ui/top_page_valuenotifier.dart';

import 'repository/count_repository.dart';
import 'scopedmodel/loading_model.dart';
import 'ui/top_page_bloc_inheritedwidget.dart';
import 'ui/top_page_bloc_simple.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final CountRepository _repository = CountRepository();
  final LoadingModel _loadingModel = LoadingModel();
  final _loadingValue = LoadingValue();
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            key: const Key("in case of setState"),
            title: const Text("setState の場合"),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TopPageSetState(_repository),
                    fullscreenDialog: true,
                  ));
            },
          ),
          const Divider(),
          ListTile(
            title: const Text("InheritedWidget の場合"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TopPageInhWidget(_repository),
                  fullscreenDialog: true,
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            title: const Text("Scoped Model の場合"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TopPageScopedModel(_repository, _loadingModel),
                  fullscreenDialog: true,
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            title: const Text("Scoped Model(ValueNotifier+InheritedWidget) の場合"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TopPageValueNotifier(_repository, _loadingValue),
                  fullscreenDialog: true,
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            title: const Text("Scoped Model(Provider) の場合"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TopPageProvider(_repository),
                  fullscreenDialog: true,
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            title: const Text("BLoC の場合(Provider利用)"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TopPageBLoC(_repository),
                  fullscreenDialog: true,
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            title: const Text("BLoC の場合(blocをコンストラクタで渡すパターン)"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TopPageBLoCConst(_repository),
                  fullscreenDialog: true,
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            title: const Text("BLoC の場合(InheritedWidgetでのパターン)"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TopPageBLoCInhWidget(_repository),
                  fullscreenDialog: true,
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            title: const Text("redux の場合"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TopPageRedux(_repository),
                  fullscreenDialog: true,
                ),
              );
            },
          ),
          const Divider(),
        ],
      ),
    );
  }
}