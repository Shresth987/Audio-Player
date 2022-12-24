import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppTabs extends StatelessWidget {
  final Color color;
  final String text;
  const AppTabs({Key? key,required this.color,required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: 120,
      height: 50,
      alignment: Alignment.center,
      child: Text(this.text,style: TextStyle(color: Colors.white,fontSize: 20),
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color:this.color,
          boxShadow: [
            BoxShadow(color: Colors.grey.withOpacity(0.2),
              blurRadius: 7,
              offset: Offset(0,0),
            )
          ]
      ),
    );
  }
}
