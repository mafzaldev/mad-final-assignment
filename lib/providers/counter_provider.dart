import 'package:flutter/foundation.dart';

class CounterProvider with ChangeNotifier {
  // ignore: prefer_final_fields
  int _count = 0;

  int get count => _count;

  void setCount() {
    _count++;
    notifyListeners();
  }
}
