import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final void Function()? onTap;
  String text;

   MyButton({super.key,required this.text,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTap,
      child: Container(
        decoration:BoxDecoration(
          color:Theme.of(context).colorScheme.tertiary,
          borderRadius: BorderRadius.circular(8)
        ),
        padding:const EdgeInsets.all(25),
        margin:const EdgeInsets.all(25),
        child:Center(child: Text(text),)
      ),
    );
  }
}