import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class CustomTextField extends StatefulWidget {
  final String? prefix;
  final  TextEditingController? textEditingController;
  final String? label;
  final   IconData? suffix;
  final Function(String)? validate;
      bool? obscure = false;
   bool? enabled = true;
      bool? onlyDigit = false;
   CustomTextField({this.prefix,this.textEditingController,this.label,this.suffix,this.validate,this.enabled,this.onlyDigit,Key? key}) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  String? prefix;
      TextEditingController? textEditingController;
  String? label;
      IconData? suffix;
  Function(String)? validate;
      bool obscure = false;
  bool enabled = true;
      bool onlyDigit = false;
      @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      controller: textEditingController,
      validator: (val) {
        return validate!(val!);
      },
      enabled: enabled,
      onChanged: (val){
      },
      inputFormatters: onlyDigit ? [FilteringTextInputFormatter.digitsOnly] : [],
      obscureText: obscure,
      keyboardType: onlyDigit ? TextInputType.number : null,
      textAlignVertical: TextAlignVertical.center,
      style: const TextStyle(
          color: Colors.black, fontWeight: FontWeight.w500, fontSize: 14),
      cursorColor: const Color(0xFFAEA3A5),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Color(0xFFAEA3A5), fontSize: 14),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        filled: true,
        isDense: true,
        contentPadding: EdgeInsets.zero,
        fillColor: const Color(0xFFF7F8F8),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
              width: 1, color: Colors.red, style: BorderStyle.solid),
        ),
        disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                width: 1, color: Color(0xFFFDFDFD), style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(16)),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                width: 1, color: Color(0xFFFDFDFD), style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(16)),
        prefixIcon: SvgPicture.asset(
          "assets/icons/$prefix",
          fit: BoxFit.scaleDown,
        ),
        suffixIcon: Icon(
          suffix,
          color: Color(0xFF7B6F72),
        ),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                width: 1, color: Color(0xFFFDFDFD), style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}

Widget customTextField({
  String? prefix,
  TextEditingController? textEditingController,
  String? label,
  IconData? suffix,
  Function(String)? validate,
  bool obscure = false,
  bool enabled = true,
  bool onlyDigit = false,
  Function (String)?onChanged
}) {
  return TextFormField(
    controller: textEditingController,
    validator: (val) {
      return validate!(val!);
    },
    enabled: enabled,
    onChanged: (val){
      if(onChanged!=null){
        onChanged(val);
      }
    },

    inputFormatters: onlyDigit ? [FilteringTextInputFormatter.digitsOnly] : [],
    obscureText: obscure,
    keyboardType: onlyDigit ? TextInputType.number : null,
    textAlignVertical: TextAlignVertical.center,
    style: const TextStyle(
        color: Colors.black, fontWeight: FontWeight.w500, fontSize: 14),
    cursorColor: const Color(0xFFAEA3A5),
    decoration: InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Color(0xFFAEA3A5), fontSize: 14),
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      filled: true,
      isDense: true,
      contentPadding: EdgeInsets.zero,
      fillColor: const Color(0xFFF7F8F8),
      errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(
            width: 1, color: Colors.red, style: BorderStyle.solid),
      ),
      disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
              width: 1, color: Color(0xFFFDFDFD), style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(16)),
      enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
              width: 1, color: Color(0xFFFDFDFD), style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(16)),
      prefixIcon: SvgPicture.asset(
        "assets/icons/$prefix",
        fit: BoxFit.scaleDown,
      ),
      suffixIcon: Icon(
        suffix,
        color: Color(0xFF7B6F72),
      ),
      focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
              width: 1, color: Color(0xFFFDFDFD), style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(16)),
    ),
  );
}
