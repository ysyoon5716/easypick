import 'package:flutter/material.dart';

class HeaderCell extends StatelessWidget {
  final String text;
  HeaderCell({required this.text});

  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Text(
          text, 
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)
        )
      )
    );
  }
}


class TextFormCell extends StatelessWidget {
  final String text;
  final Function(String) onChanged;
  TextFormCell({required this.text, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: TextFormField(
        initialValue: text,
        onChanged: onChanged,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 30, right: 20, top: 5, bottom: 5),
          border: InputBorder.none,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black)
          ),
        )
      )
    );
  }
}


class IconCell extends StatelessWidget {
  final IconData icon;
  final Function() onPressed;
  IconCell({required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TableCell(
      
      child: Center(
        child: IconButton(
        icon: Icon(icon),
        onPressed: onPressed
        )
      )
    );
  }
}