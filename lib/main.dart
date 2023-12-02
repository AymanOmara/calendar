import 'package:calender/calender_cubit.dart';
import 'package:calender/calender_states.dart';
import 'package:calender/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
          scroll.addListener(() {});

          return Scaffold(
            body: Column(
              children: [
                _buildDateContainer(cubit, context),
                _buildDateListView( cubit, scroll),
                _buildYearContainer(cubit , context),
                _buildYearListView( cubit, scroll),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildDateContainer(CalenderCubit cubit, BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final containerWidth = screenWidth > 20 ? screenWidth - 20 : screenWidth;
    return Padding(
      padding: const EdgeInsets.only(top:50.0),
      child: Container(
        alignment: Alignment.center,
        width: containerWidth,
        height: 70,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 222, 245, 240),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: txt(
          const Color(0xFF052460),
          DateFormat('yyyy MMM').format(cubit.monthDateTime),
          20,
        ),
      ),
    );
  }

  Widget _buildDateListView(CalenderCubit cubit, ScrollController scroll) {
    return Row(
      children: [
        IconButton(
          onPressed: cubit.previousPageInMonth,
          icon: const Icon(Icons.arrow_back_ios, size: 15, color: Color(0xFF7584AF)),
        ),
        Expanded(
          child: SizedBox(
            height: 85,
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: ListView.builder(
                controller: scroll,
                scrollDirection: Axis.horizontal,
                itemCount: cubit.monthTimes.length,
                itemBuilder: (context, i) {
                  final currentDate = DateTime.now();
                  final itemDate = cubit.monthTimes[i].date;
                  final isCurrentDate =
                      itemDate.year == currentDate.year &&
                          itemDate.month == currentDate.month &&
                          itemDate.day == currentDate.day;
                  return Padding(
                    key: Key(cubit.monthTimes[i].date.toString()),
                    padding:
                    const EdgeInsets.symmetric(horizontal: 10),
                    child: SizedBox(
                      height: 70,
                      width: 90,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              color: Color.fromARGB(
                                  255, 225, 224, 224),
                              width: 0.6),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        color: isCurrentDate
                            ? const Color(0xFF00B9AD)
                            : const Color(0xffFDFDFD),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Column(
                            children: [
                              isCurrentDate
                                  ? txt(
                                  Colors.white,
                                  DateFormat('EEEE').format(
                                      cubit.monthTimes[i].date),
                                  15)
                                  : txt(
                                  const Color(0xFF052460),
                                  DateFormat('EEEE').format(
                                      cubit.monthTimes[i].date),
                                  15),
                              isCurrentDate
                                  ? txt(
                                  Colors.white,
                                  cubit.monthTimes[i].dayName,
                                  17)
                                  : txt(
                                  const Color(0xFF7584AF),
                                  cubit.monthTimes[i].dayName,
                                  17)
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        IconButton(
          onPressed: cubit.nextPageInMonth,
          icon: const Icon(Icons.arrow_forward_ios, size: 15, color: Color(0xFF7584AF)),
        ),
      ],
    );
  }

  Widget _buildYearContainer(CalenderCubit cubit ,  BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final containerWidth = screenWidth > 20 ? screenWidth - 20 : screenWidth;
    return Padding(
      padding: const EdgeInsets.only(top: 60.0),
      child: Container(
        alignment: Alignment.center,
        width: containerWidth,
        height: 70,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 222, 245, 240),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: txt(
          const Color(0xFF052460),
          DateFormat('yyyy').format(cubit.yearDateTime),
          20,
        ),
      ),
    );
  }

  Widget _buildYearListView(CalenderCubit cubit, ScrollController scroll) {
    return Row(
      children: [
        IconButton(
          onPressed: cubit.previousPageInYear,
          icon: const Icon(Icons.arrow_back_ios, size: 15, color: Color(0xFF7584AF)),
        ),
        Expanded(
          child: SizedBox(
            height: 85,
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: ListView.builder(
                controller: scroll,
                scrollDirection: Axis.horizontal,
                itemCount: cubit.yearTimes.length,
                itemBuilder: (context, i) {
                  final currentMonth= DateTime.now();
                  final itemDate = cubit.yearTimes[i].date;
                  final isCurrentMonth =
                      itemDate.year == currentMonth.year &&
                          itemDate.month == currentMonth.month;
                  return Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 10),
                    child: SizedBox(
                      height: 70,
                      width: 90,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              color: Color.fromARGB(
                                  255, 225, 224, 224),
                              width: 0.6),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        color: isCurrentMonth
                            ? const Color(0xFF00B9AD)
                            : const Color(0xffFDFDFD),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Column(
                            children: [
                              isCurrentMonth
                                  ? txt(
                                  Colors.white, DateFormat('MMMM').format(
                                  DateTime(currentMonth.year, i + 1, 1)),
                                  15)
                                  : txt(
                                  const Color(0xFF052460),
                                  DateFormat('MMMM').format(
                                      DateTime(
                                          currentMonth.year, i + 1, 1)), 15),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        IconButton(
          onPressed: cubit.nextPageInYear,
          icon: const Icon(Icons.arrow_forward_ios, size: 15, color: Color(0xFF7584AF)),
        ),
      ],
    );
  }
}
