import 'package:calender/calender_cubit.dart';
import 'package:calender/calender_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

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
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Calender(),
    );
  }
}

class Calender extends StatelessWidget {
  const Calender({super.key});

  @override
  Widget build(BuildContext context) {
    var scroll = ScrollController();
    return BlocProvider(
      create: (_) => CalenderCubit(),
      child: BlocConsumer<CalenderCubit, CalenderStats>(
        listener: (context, state) {},
        builder: (context, state) {
          CalenderCubit cubit = BlocProvider.of(context);
          scroll.addListener(() {
            var nextPageTrigger = 1 * scroll.position.maxScrollExtent;
            var previousPageTrigger = scroll.position.extentBefore;
            if (scroll.position.pixels > nextPageTrigger) {
              cubit.nextPage();
            }
            if (scroll.position.pixels == 0) {
              cubit.previousPage();
            }
            if (state is CalenderInitial) {}
          });
          return Scaffold(
            body: Column(
              children: [
                const SizedBox(
                  height: 60,
                ),
                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 60,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(
                        20,
                      ),
                    ),
                  ),
                  child: Text(
                    DateFormat('yyyy MMM').format(cubit.dateTime),
                  ),
                ),
                SizedBox(
                  height: 70,
                  child: ListView.builder(
                    controller: scroll,
                    scrollDirection: Axis.horizontal,
                    itemCount: cubit.times.length,
                    itemBuilder: (context, i) => Padding(
                      key: Key(cubit.times[i].date.toString()),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: SizedBox(
                        height: 70,
                        child: Card(
                          child: Column(
                            children: [
                              Text(cubit.times[i].date.toString()),
                              Text(cubit.times[i].dayName),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
