import 'package:flutter/material.dart';
import 'package:food_delivery/utils/dimensions.dart';

class BigText extends StatelessWidget {
   Color? color;
  final String text;
  double size;
  TextOverflow overFlow;
  BigText({ Key? key, this.color = const Color(0xFF332d2b),
   required this.text,
   this.size = 0,
   this.overFlow = TextOverflow.ellipsis // nếu chiều dài của văn bản vượt quá kích thước thì nó sẽ hiển thị dấu "..." cho phần vượt quá.
   }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1, // ta thiết lập chiều dài tối đa của BigText là 1 dòng => nếu dài hơn 1 dòng thì nó sẽ hiển thị "..."
      overflow: overFlow,
      style: TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w400,
        fontSize: size==0?Dimensions.font20:size,
        color: color,
      ),
    );
  }
}