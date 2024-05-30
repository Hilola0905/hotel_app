
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/colors/app_colors.dart';
import '../../utils/style/app_text_style.dart';


class CurrencyDropdown extends StatelessWidget {
  const CurrencyDropdown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.c0D0140.withOpacity(0.1),
        ),
      ),
      child: DropdownButtonHideUnderline(

        child: DropdownButton<String>(
          isExpanded: true,
          value: "Hilola",
          items: ["\$(US dollar)","₽(Rubl)",  "SO'M", "€(Euro)"]
              .map((e) => DropdownMenuItem<String>(
            value: e,
            child: Text(
              e,
              style: AppTextStyle.interRegular.copyWith(fontSize: 14),
            ),
          ))
              .toList(),
          onChanged: (String? newValue) {
          },
        ),
      ),
    );
  }
}