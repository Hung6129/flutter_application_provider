import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../product_model.dart';
import '../services.dart';




/// get data from url using http
final product = Provider<API>((ref) => API());
final productProvider = FutureProvider<List<Products>>((ref) async {
  return ref.watch(product).getProduct();
});

/// get simple string
final helloWord = Provider<String>((ref) {
  return "Hello word";
});

/// counter num
final counter = StateProvider<int>((ref) {
  return 0;
});

/// clock
final clockProvider = StateNotifierProvider<Clock, DateTime>((ref) {
  return Clock();
});

class Clock extends StateNotifier<DateTime> {
  // 1. initialize with current time
  Clock() : super(DateTime.now()) {
    // 2. create a timer that fires every second
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      // 3. update the state with the current time
      state = DateTime.now();
    });
  }

  late final Timer _timer;

  // 4. cancel the timer when finished
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
