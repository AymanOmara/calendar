import 'package:calender/calender_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';
class CalenderCubit extends Cubit<CalenderStats> {
  CalenderCubit() : super(CalenderInitial()) {
    var v =  daysInMonth();
    for (int i = 1; i<= daysInMonth();i++){
      var date = DateTime(dateTime.year,dateTime.month,i);
      times.add(MyDate(date: date, dayName: date.day.toString(), dayNumber: "$i"));
    }
    // times.insertAll(0,_generateItemsForDate(dateTime: DateTime(dateTime.year,dateTime.month-1,0)));
    emit(CalenderInitial());
  }
  DateTime dateTime = DateTime.now();
  List<MyDate> times = [];


  void nextPage() {
    dateTime = DateTime(dateTime.year,dateTime.month+1,1);
    if(times.firstWhereOrNull((element) => element.date.compareTo(dateTime)==0) != null){
      return;
    }
    // return;
    for (int i = 1; i<= daysInMonth();i++){
      var date = DateTime(dateTime.year,dateTime.month,i);
      times.add(MyDate(date: date, dayName: date.day.toString(), dayNumber: "$i"));
    }
    emit(CalenderInitial());
  }

  void previousPage() {
  //   dateTime = DateTime(dateTime.year,dateTime.month-1,1);
  //   print(times.firstWhereOrNull((element) => element.date.compareTo(dateTime)==0));
  //
  //   if(times.firstWhereOrNull((element) => element.date.compareTo(dateTime)==0) != null){
  //     return;
  //   }
  //   // return;
  //   for (int i = daysInMonth(); i>= 1;i--){
  //     var date = DateTime(dateTime.year,dateTime.month,i);
  //     times.insert(0, MyDate(date: date, dayName: date.day.toString(), dayNumber: "$i"));
  //   }
  //   log(times.map((e) => e.date).toList().toString());
  //   emit(CalenderInitial());
  }


  int daysInMonth() {
    var firstDayThisMonth = dateTime;
    var firstDayNextMonth = DateTime(firstDayThisMonth.year,
        firstDayThisMonth.month + 1, firstDayThisMonth.day);
    return firstDayNextMonth.difference(firstDayThisMonth).inDays;
  }
  List<MyDate> _generateItemsForNextMonth({required DateTime dateTime}){
    List<MyDate> times = [];
    dateTime = DateTime(dateTime.year,dateTime.month,1);
    for (int i = daysInMonth(); i>= 1;i--){
      var date = DateTime(dateTime.year,dateTime.month,i);
      times.insert(0, MyDate(date: date, dayName: date.day.toString(), dayNumber: "$i"));
    }
    return times;
  }
  List<MyDate> _generateItemsForPreviousMonth({required DateTime dateTime}){
    List<MyDate> times = [];
    dateTime = DateTime(dateTime.year,dateTime.month,1);
    for (int i = daysInMonth(); i>= 1;i--){
      var date = DateTime(dateTime.year,dateTime.month,i);
      times.insert(0, MyDate(date: date, dayName: date.day.toString(), dayNumber: "$i"));
    }
    return times;
  }
}

class MyDate {
  String dayNumber;
  String dayName;
  DateTime date;

  MyDate({
    required this.date,
    required this.dayName,
    required this.dayNumber,
  });
}
