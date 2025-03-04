import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../../../common/widgets/chips/rounded_choice_chips.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/helpers/helper_functions.dart';
import '../../../controllers/c_calendar.ctrl.dart';

class KCalendarSection extends StatelessWidget {
  const KCalendarSection({super.key});

  @override
  Widget build(BuildContext context) {
    //final calendarCtrl = ClientCalendarController.instance;
    return GetBuilder<ClientCalendarController>(
      assignId: true,
      builder: (calendarCtrl) {
        return SizedBox(
          child: Column(
            children: [
              SizedBox(
                width: 100,
                child: ElevatedButton(onPressed: (){},
                  child: Text(KHelperFunctions.getFormattedDate(calendarCtrl.selectedDate.value),),
                ),
              ),

              const SizedBox(height: KSizes.spaceBtwItems ,),
              TableCalendar(
                headerVisible: false,
                calendarFormat: CalendarFormat.twoWeeks,
                headerStyle: HeaderStyle(formatButtonVisible: false, formatButtonShowsNext: false,),
                selectedDayPredicate: (day) => isSameDay(day, calendarCtrl.selectedDate.value),
                focusedDay: calendarCtrl.selectedDate.value,
                firstDay: DateTime.now(),
                lastDay: DateTime.now().add(Duration(days: 7)),
                onDaySelected: (selectedDay, focusedDay) =>
                    calendarCtrl.onDaySelected(selectedDay, focusedDay),
              ),

              // Center(child: Text('Select Time', style:Theme.of(context).textTheme.headlineMedium,),),

              const SizedBox(height: KSizes.spaceBtwItems ,),
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     Wrap(
              //       spacing: 8,
              //         children: [
              //           KChoiceChip(text: "8.30", selected: true,onSelected: (value){},),
              //           KChoiceChip(text: '9.30', selected: false,onSelected: (value){}),
              //
              //     ]),
              //   ],
              // ),

            ],
          ),
        );
      },
    );
  }
}
