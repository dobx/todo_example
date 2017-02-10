// ========================================================================
// Copyright 2017 David Yu
// ------------------------------------------------------------------------
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
// http://www.apache.org/licenses/LICENSE-2.0
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// ========================================================================

import 'package:flutter/material.dart';
import './types.dart';

final ThemeData THEME = new ThemeData(primarySwatch: Colors.blueGrey);

// from Colors.blueGrey
const Color SWATCH_COLOR = const Color(0xFF90A4AE),
    SWATCH_COLOR_LIGHT = const Color(0xFFB0BEC5);

const double FONT_SIZE = 18.0,
    PADDING_SIZE = 5.0,
    INPUT_EXTRA_SIZE = 4.0;

// ==================================================
// widgets

class AppBarWidget extends StatelessWidget implements AppBarBottomWidget {
  final WidgetBuilder wb;
  final double bottomHeight;
  AppBarWidget(this.wb, this.bottomHeight);

  @override
  Widget build(BuildContext context) {
    return wb(context);
  }
}

// ==================================================
// utils

void showSnackbar(BuildContext context, String value) {
  Scaffold.of(context).showSnackBar(new SnackBar(
      content: new Text(value),
  ));
}

// ==================================================

Border bottom({
  width: 1.5,
  Color color: const Color(0xCCCCCC),
  BorderStyle style: BorderStyle.solid
}) {
  return new Border(
    bottom: new BorderSide(color: color, width: width, style: style),
  );
}

Widget padded_top(Widget w, {
  EdgeInsets topPad: const EdgeInsets.only(top: PADDING_SIZE),
}) {
  return new Padding(
    padding: topPad,
    child: w,
  );
}

Widget fluid(Widget w) {
  return new Row(
    children: [
      new Expanded(
        child: w,
      ),
    ],
  );
}

Widget fluid_box(Widget w, {
  Color bg_color = Colors.white,
  num padLR = PADDING_SIZE,
  num padTop = 0.0
}) {
  return fluid(new Container(
    padding: new EdgeInsets.only(left: padLR, right: padLR, top: padTop),
    decoration: new BoxDecoration(
      backgroundColor: bg_color,
    ),
    child: w,
  ));
}

Widget fluid_input(String value, InputValueCB cb, {
  bool borderB = true,
  num fontSize = FONT_SIZE + INPUT_EXTRA_SIZE,
  color: const Color.fromRGBO(85, 85, 85, 20.0),
  borderColor: const Color.fromRGBO(85, 85, 85, 200.0)
}) {
  return fluid(new Container(
    decoration: !borderB ? null : new BoxDecoration(
      border: bottom(color: borderColor),
    ),
    child: new InputField(
      autofocus: true,
      value: new InputValue(text: value),
      onSubmitted: cb,
      style: new TextStyle(
        color: color,
        fontSize: fontSize,
      ),
    ),
  ));
}

Widget input_label(String value, {
  num fontSize = FONT_SIZE,
  Color color = const Color.fromRGBO(85, 85, 85, 100.0),
}) {
  return new Padding(
    padding: new EdgeInsets.only(bottom: 1.0),
    child: new Text(value,
      style: new TextStyle(
        color: color,
        fontSize: fontSize,
      ),
    ),
  );
}

Widget text(String value, {
  num fontSize = FONT_SIZE,
  Color color = const Color.fromRGBO(85, 85, 85, 20.0),
  TextDecoration decoration
}) {
  return new Text(value,
    style: new TextStyle(
      fontSize: fontSize,
      color: color,
      decoration: decoration,
    ),
  );
}

Widget block(List<Widget> children) {
  return new Block(
    children: children,
  );
}

Widget btn_close(VoidCallback onPressed) {
  return new IconButton(
    icon: new Icon(Icons.close, color: SWATCH_COLOR),
    onPressed: onPressed,
  );
}