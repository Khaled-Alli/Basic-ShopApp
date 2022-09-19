import 'package:flutter/material.dart';

import 'constants.dart';

void Navigate_to({required context,required screen}){
  Navigator.of(context)?.push(MaterialPageRoute(builder: (context){
    return screen;
  }));
}
void Navigate_to_with_replacement({required context,required screen}){
  Navigator.of(context)?.pushReplacement(MaterialPageRoute(builder: (context){
    return screen;
  }));
}

Main_Text_Form({
  onTap,
  @required controller,
  @required type,
  @required validate,
  @required label,
  @required prefix,
  suffix,
  obscure=false,
  onchange,
  onsubmit,
}) {
  return TextFormField(
    controller: controller,
    onChanged: onchange,
    keyboardType: type,
    validator: validate,
    decoration: InputDecoration(
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide( color:primary_color),),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: primary_color),
      ),

      labelText: label,
     border: OutlineInputBorder(
       borderSide: BorderSide( color:primary_color),
     ),
      prefixIcon: prefix,
      suffixIcon: suffix,
      labelStyle: TextStyle(color: primary_color,),
      prefixIconColor: primary_color,
      suffixIconColor: primary_color,

    ),
    onFieldSubmitted: onsubmit,
    obscureText:obscure,
    onTap: onTap,



  );
}

Main_Button({required function,required String label}){
  return Container(
    width: double.infinity,
    height: 50,
    child: MaterialButton(
      onPressed: function,
      child: Text(label.toUpperCase(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
    ),
    color: primary_color,
  );
}

