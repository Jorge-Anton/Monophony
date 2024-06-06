import 'package:flutter/foundation.dart';

class ActiveSearchNotifier extends ValueNotifier<String> {
  ActiveSearchNotifier() : super('');

  void setActiveSearch(String query) {
    value = query;
  }
}

// @Riverpod(keepAlive: true)
// class ActiveSearchController extends _$ActiveSearchController {

//   @override
//   String build() => '';
  
//   void setActiveSearch(String query) => state = query;
// }