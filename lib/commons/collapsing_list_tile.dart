import 'package:flutter/material.dart';
import 'package:gurucoolv1/pages/home_page.dart';
import 'theme.dart';

class CollapsingListTile extends StatefulWidget {

  final String title;
  final IconData icon;
  final bool isSelected;
  final Function onTap;

  CollapsingListTile({this.title, this.icon, this.isSelected, this.onTap});

  @override
  _CollapsingListTileState createState() => _CollapsingListTileState();
}

class _CollapsingListTileState extends State<CollapsingListTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: widget.isSelected? Colors.white : HomepageBackground,
//          color: widget.isSelected? Colors.transparent.withOpacity(0.5) : Colors.transparent,
        ),
        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Icon(widget.icon,
                color: widget.isSelected? HomepageBackground : defColor,
//                color: widget.isSelected? defColor: defColor,
                size: 40.0,),
              SizedBox(width: 10.0,),
              Text(widget.title, style: widget.isSelected? ListTileText.selected.copyWith(color: HomepageBackground) : ListTileText.white,),
            ],
          ),
        ),
      ),
    );
  }
}