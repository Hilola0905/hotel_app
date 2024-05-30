

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../utils/colors/app_colors.dart';

class DatePickerItem extends StatefulWidget {
  const DatePickerItem(
      {super.key,
        required this.onSelectionDate,
        required this.dateType,
        this.selectedDate});

  final ValueChanged<String> onSelectionDate;
  final String dateType;
  final String? selectedDate;

  @override
  State<DatePickerItem> createState() => _DatePickerItemState();
}

class _DatePickerItemState extends State<DatePickerItem> {
  DateTime? date;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150.w,
      padding: EdgeInsets.all(15.w),
      margin: EdgeInsets.symmetric(vertical: 10.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: AppColors.c99ABC6.withOpacity(0.18),
            blurRadius: 62,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        onTap: () async {
          date = await showDatePicker(
              context: context,
              firstDate: DateTime(1960),
              lastDate: DateTime(2030),
              builder: (context, child) {
                return Theme(
                  data: ThemeData.dark().copyWith(
                    colorScheme: const ColorScheme.dark(
                        onPrimary: Colors.black, // selected text color
                        onSurface: Colors.amberAccent, // default text color
                        primary: Colors.amberAccent // circle color
                    ),
                    dialogBackgroundColor: Colors.black54,
                    textButtonTheme: TextButtonThemeData(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.amber,
                        textStyle: const TextStyle(
                            color: Colors.amber,
                            fontWeight: FontWeight.normal,
                            fontSize: 12,
                            fontFamily: 'Quicksand'),
                        // color of button's letters
                        backgroundColor: Colors.black54,
                        // Background color
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              color: Colors.transparent,
                              width: 1,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                  ),
                  child: child!,
                );
              });
          if (date != null) {
            widget.onSelectionDate("${date!.year}-${date!.month}-${date!.day}");
          }
          setState(() {});
        },
        child: Text(
            widget.selectedDate != null
                ? "${widget.selectedDate}"
                : date != null
                ? "${date!.year}-${date!.month}-${date!.day}"
                : (widget.dateType),
            style: Theme.of(context).textTheme.titleMedium),
      ),
    );
  }
}
