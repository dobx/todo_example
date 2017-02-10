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

class App {
  final List<Todo> _todos = new ObservableList<Todo>();
  final Todo pupdate = Todo.createObservable('');
  final Todo pnew;

  App(String initialText) : pnew = Todo.createObservable(initialText);

  // passing null subscribes the caller once only and if tracking is on.
  List<Todo> get todos => _todos.sublist(null);
}


