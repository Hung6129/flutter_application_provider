import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'provider/provider.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// init provider values
    final countNum = ref.watch(counter);
    final currClock = ref.watch(clockProvider);
    final timeFormat = DateFormat.Hms().format(currClock);
    final listProduct = ref.watch(productProvider);
    final helloProvider = ref.watch(helloWord);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Provider'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          /// simple hello word using consumer widget
          Consumer(builder: (context, ref, child) {
            return Text(helloProvider);
          }),
          Text(helloProvider),

          /// real-time clock
          Text(timeFormat),

          /// simple counter
          const Text('You have pushed the button this many times:'),
          Text('$countNum', style: Theme.of(context).textTheme.headline4),

          /// get products list from internet
          listProduct.when(
              data: (data) {
                return Expanded(
                    child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) => ListTile(
                            title: Text(data[index].id.toString()),
                            subtitle: Text(data[index].title.toString()))));
              },
              error: (error, stackTrace) => Text(error.toString()),
              loading: () => const CircularProgressIndicator()),
        ],
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            onPressed: () => ref.read(counter.notifier).state++,
            tooltip: 'Increment',
            child: const Icon(Icons.arrow_drop_up_rounded),
          ),
          FloatingActionButton(
            onPressed: () => ref.read(counter.notifier).state--,
            tooltip: 'Decrement',
            child: const Icon(Icons.arrow_drop_down_rounded),
          ),
        ],
      ),
    );
  }
}
