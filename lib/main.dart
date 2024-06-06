import 'package:counterbloc/blocs/counter_bloc.dart';
import 'package:counterbloc/blocs/counter_event.dart';
import 'package:counterbloc/blocs/counter_state.dart';
import 'package:counterbloc/visibility_blocs/bloc/visibility_bloc.dart';
import 'package:counterbloc/visibility_blocs/bloc/visibility_event.dart';
import 'package:counterbloc/visibility_blocs/bloc/visibility_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        //home: const MyHomePage(title: 'Flutter Demo Home Page'),
        // home: BlocProvider<CounterBloc>(
        //   create: (context) => CounterBloc(),
        //   child: const MyHomePage(title: 'Flutter Demo Home Page'),
        // ),
        home: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => CounterBloc()),
            BlocProvider(create: (context) => VisibilityBloc())
          ],
          child: const MyHomePage(title: 'Flutter Demo Home Page'),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            BlocBuilder<CounterBloc, CounterState>(
                buildWhen: (previous, current) {
              return true;
            }, builder: (context, state) {
              return Text(state.count.toString(),
                  style: Theme.of(context).textTheme.headlineMedium);
            }),
            BlocBuilder<VisibilityBloc, VisibilityState>(
              builder: (context, state) {
                return Visibility(
                    visible: state.show,
                    child: Container(
                      color: Colors.red[300],
                      height: 200,
                      width: 200,
                    ));
              },
            )
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            onPressed: () {
              context.read<CounterBloc>().add(CounterIncrementEvent());
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: () {
              context.read<CounterBloc>().add(CounterDecrementEvent());
            },
            tooltip: 'Decrement',
            child: const Icon(Icons.minimize),
          ),
          FloatingActionButton(
            onPressed: () {
              context.read<VisibilityBloc>().add(VisibilityShowEvent());
            },
            tooltip: 'Show',
            child: const Icon(Icons.visibility),
          ),
          FloatingActionButton(
            onPressed: () {
              context.read<VisibilityBloc>().add(VisibilityHideEvent());
            },
            tooltip: 'Hide',
            child: const Icon(Icons.visibility_off),
          )
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
