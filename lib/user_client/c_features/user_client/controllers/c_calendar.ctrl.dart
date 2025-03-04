
import 'package:get/get.dart';



class ClientCalendarController extends GetxController{
  static ClientCalendarController get instance => Get.find();

  final selectedDate = DateTime.now().obs;
   late DateTime date;
  int? currentIndex;
  var bookedTimes = <String>[].obs;

  var allTimes = [
    {'time': '09:00 AM', 'isBooked': false},
    {'time': '10:00 AM', 'isBooked': false},
    {'time': '11:00 AM', 'isBooked': false},
    {'time': '12:00 PM', 'isBooked': false},
    {'time': '01:00 PM', 'isBooked': false},
    {'time': '02:00 PM', 'isBooked': false},
    {'time': '03:00 PM', 'isBooked': false},
    {'time': '04:00 PM', 'isBooked': false},
    {'time': '05:00 PM', 'isBooked': false},
  ].obs;

  void bookTime(String time) {
    // Find the time slot and mark it as booked
    var timeSlot = allTimes.firstWhere((slot) => slot['time'] == time);
    timeSlot['isBooked'] = true;
  }

  void onDaySelected(DateTime day , DateTime focusedDay){

    selectedDate.value = day;
    update();
    date = selectedDate.value;
  }

}
