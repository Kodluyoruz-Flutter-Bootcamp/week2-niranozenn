import 'package:flutter/foundation.dart';

class Groceries {
  String product;
  int price;
  Category category;
  List<String> _list = [];
  Groceries(this._list);

  List get list => _list;
}
