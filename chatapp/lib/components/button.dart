import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:styled_widget/styled_widget.dart';

class CustomButton extends StatefulWidget {
  final Widget child;
  final Color color;
  final Color textColor;
  final double elevation;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  CustomButton({
    @required this.child,
    this.color,
    this.textColor = const Color(0xFFFFFFFF),
    this.elevation = 8.0,
    this.onTap,
    this.onLongPress
  }) : assert(child != null);

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    var darkMode = Theme.of(context).brightness == Brightness.dark;
    var buttonColor = widget.color ?? Theme.of(context).accentColor;

    final cardItem = ({Widget child}) => Styled.widget(child: child)
        .ripple(
            highlightColor: Colors.transparent,
            splashColor: darkMode ? Color(0x20000000) : Color(0x20FFFFFF)
        )
        .height(58)
        .backgroundColor(buttonColor, animate: true)
        .clipRRect(all: 10)
        .borderRadius(all: 10)
        .gestures(
          onTapChange: (tapStatus) => setState(() => pressed = tapStatus),
          onTap: widget.onTap,
          onLongPress: widget.onLongPress,
        )
        .scale(all: pressed ? 0.95 : 1.0, animate: true)
        .animate(Duration(milliseconds: 150), Curves.easeOut);

    return cardItem(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 14),
        child: DefaultTextStyle(
            style: TextStyle(color: widget.textColor),
            child: Center(child: widget.child)
        ),
      ),
    );
  }
}

class CustomOutlineButton extends StatefulWidget {
  final Widget child;
  final Color color;
  final double elevation;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  CustomOutlineButton({
    @required this.child,
    this.color,
    this.elevation = 8.0,
    this.onTap,
    this.onLongPress
  }) : assert(child != null);

  @override
  _CustomOutlineButtonState createState() => _CustomOutlineButtonState();
}

class _CustomOutlineButtonState extends State<CustomOutlineButton> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    var darkMode = Theme.of(context).brightness == Brightness.dark;
    var buttonColor = widget.color ?? Theme.of(context).accentColor;
    var outlineColor = darkMode ? Color(0x30FFFFFF) : Color(0x30000000);

    final cardItem = ({Widget child}) => Styled.widget(child: child)
        .ripple(
          highlightColor: Colors.transparent,
          splashColor: buttonColor.withOpacity(0.3),
        )
        .height(58)
        .decorated(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: outlineColor,
            width: 2,
          ),
        )
        .backgroundColor(Colors.transparent, animate: true)
        .clipRRect(all: 10)
        .borderRadius(all: 10)
        .gestures(
          onTapChange: (tapStatus) => setState(() => pressed = tapStatus),
          onTap: widget.onTap,
          onLongPress: widget.onLongPress,
        )
        .scale(all: pressed ? 0.95 : 1.0, animate: true)
        .animate(Duration(milliseconds: 150), Curves.easeOut);

    return cardItem(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 14),
        child: DefaultTextStyle(
            style: TextStyle(color: buttonColor),
            child: Center(child: widget.child)
        ),
      ),
    );
  }
}