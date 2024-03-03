import 'package:flutter/material.dart';
import 'package:todo_test/My_theme.dart';


typedef myValidetor =  String? Function(String?) ;

class CustomTextFormField extends StatelessWidget {

  String text;
  myValidetor validetor;
  TextEditingController controller ;
  TextInputType keyboardType;
  bool obscureText ;

  CustomTextFormField ({
    required this.text ,
    required this.controller ,
    required this.validetor,
    this.keyboardType= TextInputType.text,
    this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        right: MediaQuery.of(context).size.height *0.02,
        left: MediaQuery.of(context).size.height *0.02,
        bottom: MediaQuery.of(context).size.height *0.02,),
      child: TextFormField(
        controller: controller,
        validator: validetor,
        keyboardType: keyboardType,
        obscureText: obscureText ,
        decoration: InputDecoration(
          filled: true,
          fillColor: MyTheme.witheColor,
          label: Text(text),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: MyTheme.primaryColor)
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: MyTheme.primaryColor,width: 2)
          ),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: MyTheme.primaryColor,width: 2)
          ),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: MyTheme.primaryColor,width: 2)
          ),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: MyTheme.primaryColor,width: 2)
          ),
          labelStyle: TextStyle(color: MyTheme.lableColor,)
        ),
      ),
    );
  }

}