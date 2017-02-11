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
    SWATCH_LIGHT_COLOR = const Color(0xFFB0BEC5),
    SWATCH_DARK_COLOR = const Color(0xFF78909C),

    INPUT_LABEL_COLOR = const Color.fromRGBO(85, 85, 85, 100.0),
    INPUT_COLOR = const Color.fromRGBO(85, 85, 85, 40.0),
    INPUT_BORDER_COLOR = const Color.fromRGBO(85, 85, 85, 200.0),

    TEXT_COLOR = const Color.fromRGBO(85, 85, 85, 20.0);

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

class AppBarPopup extends StatelessWidget {
  static PopupMenuItem<int> new_item(String text, int idx) {
    return new PopupMenuItem<int>(
      value: idx,
      child: new Text(text),
    );
  }

  final IntCB cb;
  final List<String> items;
  final List<PopupMenuItem<int>> popupItems;

  AppBarPopup(this.cb, this.items) : popupItems = new List<PopupMenuItem<int>>(items.length) {
    for (int i = 0, len = items.length; i < len; i++) {
      popupItems[i] = new_item(items[i], i);
    }
  }

  List<PopupMenuItem<int>> buildItems(BuildContext context) {
    return popupItems;
  }

  @override
  Widget build(BuildContext context) {
    return new PopupMenuButton<int>(
      onSelected: cb,
      itemBuilder: buildItems,
    );
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
// border

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

// ==================================================
// padding

Widget box(Widget w, {
  Color bg_color = Colors.white,
  num padLR = PADDING_SIZE,
  num padTop = 0.0
}) {
  return new Container(
    padding: new EdgeInsets.only(left: padLR, right: padLR, top: padTop),
    decoration: new BoxDecoration(
      backgroundColor: bg_color,
    ),
    child: w,
  );
}

// ==================================================
// rows

Widget row2col(Widget w1, Widget w2) {
  return new Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      w1,
      w2,
    ],
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

// ==================================================
// input

Widget text_input(String value, InputValueCB cb, {
  num fontSize = FONT_SIZE + INPUT_EXTRA_SIZE,
  color: INPUT_COLOR,
  borderColor: INPUT_BORDER_COLOR,
}) {
  return new Container(
    decoration: new BoxDecoration(
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
  );
}

Widget input(String value, InputValueCB cb, {
  num fontSize = FONT_SIZE + INPUT_EXTRA_SIZE,
  color: INPUT_COLOR,
}) {
  return new InputField(
    autofocus: true,
    value: new InputValue(text: value),
    onSubmitted: cb,
    style: new TextStyle(
      color: color,
      fontSize: fontSize,
    ),
  );
}

Widget input_label(String value, {
  num fontSize = FONT_SIZE,
  Color color = INPUT_LABEL_COLOR,
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

// ==================================================
// text

Widget text(String value, {
  num fontSize = FONT_SIZE,
  Color color = TEXT_COLOR,
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

// ==================================================
// button

Widget icon_defpad_btn(IconData icon, VoidCallback onPressed, {
  Color color = SWATCH_COLOR,
}) {
  return new IconButton(
    icon: new Icon(icon, color: color),
    onPressed: onPressed,
  );
}

Widget icon_btn(IconData icon, VoidCallback onPressed, {
  EdgeInsets pad = EdgeInsets.zero,
  Color color = SWATCH_COLOR,
}) {
  return new IconButton(
      icon: new Icon(icon, color: color),
      padding: pad,
      onPressed: onPressed,
  );
}

// ==================================================
// block

Widget block(List<Widget> children) {
  return new Block(
      children: children,
  );
}