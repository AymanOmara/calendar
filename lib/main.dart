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

            // print();
          });
          return Scaffold(
            body: Column(
              children: [
                const SizedBox(
                  height: 60,
                ),
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width-20,
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
                Row(
                  children: [
                    IconButton(onPressed: (){
                      scroll.animateTo(scroll.offset+80, duration: const Duration(milliseconds: 10), curve: Curves.easeOut);
                    }, icon:const Icon(Icons.dangerous)),
                    Expanded(child: SizedBox(
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
                            width: 90,
                            child: Card(
                              child: Column(
                                children: [
                                  Text(DateFormat('EEEE').format(cubit.times[i].date)),
                                  Text(cubit.times[i].dayName),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),),
                    IconButton(onPressed: (){
                      scroll.animateTo(scroll.offset-80, duration: const Duration(milliseconds: 10), curve: Curves.easeOut);
                    }, icon:const Icon(Icons.dangerous)),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
