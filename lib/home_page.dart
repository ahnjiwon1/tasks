import 'package:flutter/material.dart';
import 'todo_widget/todo_entity.dart';
import 'todo_widget/todo_detail_page.dart';

// To Do 추가 화면 (Bottom Sheet)
part 'bottom_sheet/add_todo_bottom_sheet.dart';
// To Do가 없을 때의 화면
part 'no_todo/no_todo_view.dart';
// 개별 To Do 항목 위젯
part 'todo_widget/todo_view_widget.dart';

class HomePage extends StatefulWidget {
  final String userName;
  const HomePage({super.key, required this.userName});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // To Do 리스트
  List<ToDoEntity> _todoList = [];

  // 5. addTodo 함수 작성 및 위젯에 연결
  void _addTodo() {
    showModalBottomSheet<ToDoEntity?>(
      context: context,
      isScrollControlled: true, // 키보드 노출 시 화면 조정
      builder: (context) => AddToDoBottomSheet(),
    ).then((newTodo) {
      if (newTodo != null) {
        setState(() {
          _todoList.add(newTodo);
        });
      }
    });
  }

  // To Do 상태 업데이트 함수
  void _updateTodo(int index, ToDoEntity updatedTodo) {
    setState(() {
      _todoList[index] = updatedTodo;
    });
  }

  @override
  Widget build(BuildContext context) {
    // 5. title에 ‘사용자 이름`s Tasks’ 넣기
    final appBarTitle = "${widget.userName}'s Tasks";
    
    // 7. To Do가 없을 때는 NoToDoView, 있을 때는 리스트 표시
    final hasTasks = _todoList.isNotEmpty;

    return Scaffold(
      resizeToAvoidBottomInset: false, // 6. FloatingActionButton 위치 고정
      appBar: AppBar(
        title: Text(
          appBarTitle,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87 // 5. AppBar title에 사이즈 20, 볼드체 적용
          ),
        ),
        backgroundColor: Colors.deepOrangeAccent[100],
        elevation: 0,
      ),
      body: hasTasks
          ? ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
              itemCount: _todoList.length,
              itemBuilder: (context, index) {
                final todo = _todoList[index];
                return ToDoView(
                  todo: todo,
                  // Done 상태 변경
                  onToggleDone: () {
                    final updatedTodo = todo.copyWith(isDone: !todo.isDone);
                    _updateTodo(index, updatedTodo);
                  },
                  // Favorite 상태 변경
                  onToggleFavorite: () {
                    final updatedTodo = todo.copyWith(isFavorite: !todo.isFavorite);
                    _updateTodo(index, updatedTodo);
                  },
                  // 상세 화면으로 이동
                  onTap: () async {
                    final updatedTodo = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ToDoDetailPage(todo: todo),
                      ),
                    );
                    if (updatedTodo is ToDoEntity) {
                      _updateTodo(index, updatedTodo);
                    }
                  },
                );
              },
            )
          : NoToDoView(appBarTitle: appBarTitle), // 5. 기본화면 (To Do 리스트가 없는 화면)
      
      floatingActionButton: FloatingActionButton(
        onPressed: _addTodo, // addTodo 함수 연결
        backgroundColor: Colors.amberAccent,
        child: const Icon(Icons.add, size: 28),
      ),
    );
  }
}