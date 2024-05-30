import 'package:flutter/material.dart';

import '../../utils/style/app_text_style.dart';

class MainTitle extends StatelessWidget {
  const MainTitle({super.key, required this.title, required this.funk});
 final String title;
 final VoidCallback funk;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,style: AppTextStyle.interBlack.copyWith(
            fontSize: 16
        ),),
        TextButton(onPressed: (){
          funk.call();
        }, child: Text("see all",style: AppTextStyle.interMedium.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.orange
        ),)),
      ],
    );
  }
}
