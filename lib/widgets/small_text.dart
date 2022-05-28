import 'package:flutter/material.dart';
import 'package:food_delivery/utils/dimensions.dart';

class SmallText extends StatelessWidget {
   Color? color;
  final String text;
  double size;
  double height;
  // TextOverflow overFlow;
  SmallText({ Key? key, this.color = const Color(0xFFccc7c5),
   required this.text,
   this.size = 0,
   this.height = 1.8, // khoảng cách giữa các dòng trong văn bản có chiều cao là 1.2
  //this.overFlow = TextOverflow.ellipsis // nếu chiều dài của văn bản vượt quá kích thước thì nó sẽ hiển thị dấu "..." cho phần vượt quá.
   }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      // maxLines: 2,
      // overflow: overFlow,
      textAlign: TextAlign.justify,
      style: TextStyle(
        fontFamily: 'Roboto',
        fontSize: size==0?Dimensions.font12:size,
        color: color,
        height: height,
      ),
    );
  }
}