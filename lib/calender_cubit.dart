import 'package:calender/calender_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class CalenderCubit extends Cubit<CalenderStats> {
  CalenderCubit() : super(CalenderInitial()) {
    _generateItemsFromMonth(monthDateTime);
    _generateItemsFromYear(yearDateTime);
  }

  DateTime monthDateTime = DateTime.now();
  DateTime yearDateTime = DateTime.now();
  List<MyDate> monthTimes = [];
  List<MyDate> yearTimes = [];

  void nextPageInMonth() {
    final nextMonth = monthDateTime.month + 1 <= 12 ? monthDateTime.month + 1 : 1;
    final nextYear = nextMonth == 1 ? monthDateTime.year + 1 : monthDateTime.year;
    _generateItemsFromMonth(DateTime(nextYear, nextMonth, 1));
  }

  void previousPageInMonth() {
    final prevMonth = monthDateTime.month - 1 >= 1 ? monthDateTime.month - 1 : 12;
    final prevYear = prevMonth == 12 ? monthDateTime.year - 1 : monthDateTime.year;
    _generateItemsFromMonth(DateTime(prevYear, prevMonth, 1));
  }

  void nextPageInYear() {
    final nextYear = yearDateTime.year + 1;
    _generateItemsFromYear(DateTime(nextYear, 1, 1));
  }

  void previousPageInYear() {
    final prevYear = yearDateTime.year - 1;
    _generateItemsFromYear(DateTime(prevYear, 1, 1));
  }

  int daysInMonth(DateTime date) {
    final firstDayThisMonth = DateTime(date.year, date.month, 1);
    final firstDayNextMonth =
    DateTime(firstDayThisMonth.year, firstDayThisMonth.month + 1, 1);
    return firstDayNextMonth.difference(firstDayThisMonth).inDays;
  }

  void _generateItemsFromMonth(DateTime date) {
    monthTimes.clear();
    monthDateTime = date;
    final daysCount = daysInMonth(date);
    for (int i = 1; i <= daysCount; i++) {
      final date = DateTime(monthDateTime.year, monthDateTime.month, i);
      monthTimes.add(MyDate(date: date, dayName: date.day.toString(), dayNumber: "$i",));
    }
    emit(CalenderInitial());
  }

  void _generateItemsFromYear(DateTime date) {
    yearTimes.clear();
    yearDateTime = date;
    for (int i = 1; i <= 12; i++) {
      final monthDate = DateTime(yearDateTime.year, i, 1);
      yearTimes.add(MyDate(date: monthDate, dayName: DateFormat('MMMM').format(monthDate),
        dayNumber: i.toString(),
      ));
    }
    emit(CalenderInitial());
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

/* import 'package:calender/calender_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class CalenderCubit extends Cubit<CalenderStats> {
  CalenderCubit() : super(CalenderInitial()) {
    var yearMonths = List<int>.generate(12, (i) => i + 1);
    for(int month in yearMonths){
      times.addAll(_generateItemsFromMonth(month: month));
    }
    emit(CalenderInitial());
  }
  DateTime dateTime = DateTime.now();
  List<MyDate> times = [];

  void nextPage() {
    //  dateTime = DateTime(dateTime.year,dateTime.month+1,1);
    // if(times.firstWhereOrNull((element) => element.date.compareTo(dateTime)==0) != null){
    //   emit(CalenderInitial());
    //   return;
    // }
    // // dateTime = tempDate;
    // if(times.firstWhereOrNull((element) => element.date.compareTo(dateTime)==0) != null){
    //   return;
    // }
    // for (int i = 1; i<= daysInMonth();i++){
    //   var date = DateTime(dateTime.year,dateTime.month,i);
    //   times.add(MyDate(date: date, dayName: date.day.toString(), dayNumber: "$i"));
    // }
    // emit(CalenderInitial());
  }

  void previousPage() {
    // var  tempDate = DateTime(dateTime.year,dateTime.month-1,1);
    // if(times.firstWhereOrNull((element) => element.date.compareTo(tempDate)==0) != null){
    //   return;
    // }
    // dateTime = tempDate;
    // for (int i = daysInMonth(); i>= 1;i--){
    //   var date = DateTime(dateTime.year,dateTime.month,i);
    //   times.insert(0, MyDate(date: date, dayName: date.day.toString(), dayNumber: "$i"));
    // }
    // emit(CalenderInitial());
  }


  int daysInMonth(int month) {
    var firstDayThisMonth = DateTime(DateTime.now().year,month,1);
    var firstDayNextMonth = DateTime(firstDayThisMonth.year,
        firstDayThisMonth.month + 1, firstDayThisMonth.day);
    return firstDayNextMonth.difference(firstDayThisMonth).inDays;
  }
  List<MyDate> _generateItemsFromMonth({required int month}){
    List<MyDate> times = [];
    for (int i = 1; i<= daysInMonth(month);i++){
      var date = DateTime(dateTime.year,month,i);
      times.add(MyDate(date: date, dayName: date.day.toString(), dayNumber: "$i"));
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
*/