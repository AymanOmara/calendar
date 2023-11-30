import 'package:calender/calender_cubit.dart';
import 'package:calender/calender_states.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
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
            var nextPageTrigger = 0.93 * scroll.position.maxScrollExtent;
            if (scroll.position.pixels > nextPageTrigger) {
              print("next page");

              cubit.nextPage();
            }
            if (scroll.position.pixels <= 100) {
              print("previous page");
              //cubit.previousPage();
            }
            if (state is CalenderInitial) {}
          });
          return Scaffold(
            body: Column(
              children: [
                const SizedBox(
                  height: 300,
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
                    cubit.dateTime.toString(),
                  ),
                ),
                SizedBox(
                  height: 300,
                  child: ListView.builder(
                    controller: scroll,
                    scrollDirection: Axis.horizontal,
                    itemCount: cubit.times.length,
                    itemBuilder: (context, i) => Padding(
                      key: Key(cubit.times[i].date.toString()),
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: SizedBox(
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
