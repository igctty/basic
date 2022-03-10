import 'package:flutter/foundation.dart';

class LoadingValue {
  final isLoading = ValueNotifier<bool>(false);

  loading({bool isLoading = false}) {
    this.isLoading.value = isLoading;
  }
}

// ValueListenableProviderの場合
class LoadingValueScoped extends ValueNotifier<bool> {
  LoadingValueScoped() : super(false);

  loading({bool isLoading = false}) {
    super.value = isLoading;
  }
}

// ChangeNotifierProviderの場合
class LoadingValueChange with ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  loading({bool isLoading = false}) {
    _isLoading = isLoading;
    notifyListeners();
  }
}