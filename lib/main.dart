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

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:dobx/dobx.dart';
import 'package:todo/todo.dart';
import './ui.dart' as ui;

void main() {
  runApp(new AppWidget());
}

// Dynamic parts
enum Root {
  $todo_input,
  $todo_list,
}

const String HEADER_TITLE = 'Todo List';
const int PAGE_SIZE = 10;

class AppWidget extends StatelessWidget {
  final App app = new App('');
  final WF wf = WF.get(0);

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: HEADER_TITLE,
      theme: ui.THEME,
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text(HEADER_TITLE),
          actions: [
            ui.icon_defpad_btn(Icons.filter_list, _filterPressed, color: Colors.white),
            new ui.AppBarPopup(_filterSelected, Todo_Filter$$str),
          ],
          bottom: new ui.AppBarWidget(newTopBar, (ui.FONT_SIZE + ui.FONT_SIZE + ui.INPUT_EXTRA_SIZE + 14.0)),
        ),
        body: new Padding(
          padding: const EdgeInsets.only(top: ui.PADDING_SIZE * 2),
          child: wf.$($todo_list, Root.$todo_list),
        ),
      ),
    );
  }

  void _filterSelected(int idx) {
    if (!app.todos.isEmpty)
      app.filter = Todo_Filter.values[idx];
  }

  void _filterPressed() {
    if (!app.todos.isEmpty)
      app.filter = App.rotate(app.filter);
  }

  Widget newTopBar(BuildContext context) {
    return new Column(
      children: [
        ui.fluid(ui.box(ui.input_label('What needs to be done?'))),
        /*ui.box(ui.row2col(
          ui.input_label('What needs to be done?'),
          ui.icon_btn(Icons.filter_list, _filterPressed, color: ui.SWATCH_DARK_COLOR),
        )),*/
        ui.fluid(ui.box(wf.$($todo_input, Root.$todo_input))),
      ],
    );
  }

  void _titleChanged(InputValue iv) {
    final String title = iv.text.trim();
    if (title.isEmpty) return;

    // recent first
    app.todos.insert(0, Todo.create(title, completed: false));
    // assign null to force clear
    app.pnew.title = null;
  }

  Widget $todo_input(BuildContext context) {
    return ui.input(app.pnew.title, _titleChanged);
  }

  List<Widget> newTodoItems(List<Todo> todos, int offset) {
    final int len = math.min(todos.length - offset, PAGE_SIZE);
    final List<Widget> children = new List<Widget>(len);
    for (int i = 0; i < len; i++) {
      children[i] = new TodoItem(app, todos[offset], offset++);
    }

    return children;
  }

  Widget $todo_list(BuildContext context) {
    final List<Todo> todos = App.filterTodos(app.todos, app.filter);
    final int page = todos.length == 0 ? -1 : ((todos.length - 1) / PAGE_SIZE).floor();

    return new PageView.builder(
      itemCount: page + 1,
      itemBuilder: (BuildContext context, int idx) {
        return ui.block(newTodoItems(todos, idx * PAGE_SIZE));
      },
    );
  }
}

class TodoItemState extends State<TodoItem> {

  void _toggleCompleted() {
    final Todo todo = config.todo;
    todo.completed = !todo.completed;
    setState(noop);
  }

  void _remove() {
    final TodoItem c = config;
    c.app.todos.removeAt(c.idx);
  }

  @override
  Widget build(BuildContext context) {
    final TodoItem c = config;

    return new ListItem(
      dense: true,
      title: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ui.text(c.todo.title, decoration: c.todo.completed ? TextDecoration.lineThrough : null),
          ui.icon_btn(Icons.clear, _remove),
        ],
      ),
      onLongPress: _toggleCompleted,
    );
  }
}

class TodoItem extends StatefulWidget {
  final App app;
  final Todo todo;
  final int idx;
  TodoItem(this.app, this.todo, this.idx);

  @override
  State createState() {
    return new TodoItemState();
  }
}