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

import 'package:dobx/dobx.dart' show PubSub, ObservableList;

class Todo {
  static Todo create(String title, {
    bool completed,
  }) {
    assert (title != null);
    return new Todo()
      .._title = title
      .._completed = completed;
  }

  static Todo createObservable(String title, {
    bool completed = false,
  }) {
    assert (title != null);
    return new _Todo()
      .._title = title
      .._completed = completed;
  }

  String _title;
  bool _completed;

  get title => _title;
  set title(String title) { _title = title; }

  get completed => _completed;
  set completed(bool completed) { _completed = completed; }
}

class _Todo extends Todo with PubSub {

  get title { sub(1); return _title; }
  set title(String title) { if (title != null && title == _title) return; _title = title ?? ''; pub(1); }

  get completed { sub(2); return _completed; }
  set completed(bool completed) { if (completed != null && completed == _completed) return; _completed = completed ?? false; pub(2); }
}

// nested enum
/// enum Filter {
///   ALL = 1;
///   PENDING = 2;
///   COMPLETED = 3;
/// }
enum Todo_Filter {
  ALL,
  PENDING,
  COMPLETED,
}

const List<String> Todo_Filter$$str = const <String>[
  'All',
  'Pending',
  'Completed',
];

/*
// generated
Todo_Filter Todo_Filter$$get(int id, Todo_Filter def) {
  switch (id) {
    case 1: return Todo_Filter.ALL;
    case 2: return Todo_Filter.PENDING;
    case 3: return Todo_Filter.COMPLETED;
    default: return def;
  }
}*/

class App extends PubSub {
  static bool filterCompleted(Todo todo) => todo.completed;
  static bool filterPending(Todo todo) => !todo.completed;
  static List<Todo> filterTodos(final List<Todo> all, Todo_Filter filter) {
    switch (filter) {
      case Todo_Filter.COMPLETED:
        return all.where(filterCompleted).toList(growable: false);
      case Todo_Filter.PENDING:
        return all.where(filterPending).toList(growable: false);
      default:
        return all;
    }
  }
  static Todo_Filter rotate(Todo_Filter filter) {
    assert (filter != null);

    int idx = filter.index;
    if (++idx == Todo_Filter.values.length) {
      idx = 0;
    }

    return Todo_Filter.values[idx];
  }

  final List<Todo> _todos = new ObservableList<Todo>();
  final Todo pupdate = Todo.createObservable('');
  final Todo pnew;
  Todo_Filter _filter = Todo_Filter.ALL;

  Todo_Filter get filter {
    sub(1);
    return _filter;
  }

  set filter(Todo_Filter filter) {
    if (filter != null && filter == _filter) return;

    _filter = filter ?? Todo_Filter.ALL;
    pub(1);
  }

  App(String initialText) : pnew = Todo.createObservable(initialText);

  // passing null subscribes the caller once only and if tracking is on.
  List<Todo> get todos => _todos.sublist(null);
}


